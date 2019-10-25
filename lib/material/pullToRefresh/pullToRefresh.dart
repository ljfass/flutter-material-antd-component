import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../activityIndicator/activityIndicator.dart';

typedef ScrollPhysicsChanged(ScrollPhysics physics);

enum RefreshBoxAnimationModel {
  //  加载数据前缩回，加载数据后缩回，主动触发弹出
  PUSH_BEFORE_LOAD_DATA,
  PULL_BEFORE_LOAD_DATA,
  PUSH_RECOVER_TO_NORMAL,
  PULL_RECOVER_TO_NORMAL,
}

enum AnimationStates {
  ///RefreshBox高度达到distanceToRefresh,上下拉刷新可用;
  DragAndRefreshEnabled,

  ///开始加载数据时；When loading data starts
  StartLoadData,

  /// 加载数据完成
  LoadDataEnd,

  ///空闲状态
  RefreshBoxIdle
}

class PullToRefresh extends StatefulWidget {
  PullToRefresh(
      {Key key,
      this.direction = 'down',
      this.distanceToRefresh = 25.0,
      this.activateIndicator = const Text('松手立即刷新'),
      this.deactivateIndicator,
      this.releaseIndicator,
      this.finishIndicator = const Text('完成刷新'),
      this.damping = 100.0,
      @required this.scrollPhysicsChanged,
      @required this.listView,
      @required this.onRefresh})
      : assert(onRefresh is Future Function()),
        assert(direction == 'down' || direction == 'up'),
        assert(onRefresh != null),
        super(key: key);

  final String direction;
  final double distanceToRefresh;
  final Future Function() onRefresh;
  final Widget activateIndicator;
  final Widget deactivateIndicator;
  final Widget releaseIndicator;
  final Widget finishIndicator;
  final double damping;
  final ScrollView listView;
  final ScrollPhysicsChanged scrollPhysicsChanged;

  @override
  _PullToRefreshState createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  // 表头刷新区域高度
  double topItemHeight = 0.0;
  // 表尾刷新区域高度
  double bottomItemHeight = 0.0;

  double _shrinkageDistance = 0.0;

  // 记录是否改显示“松手立即刷新”
  double _triggerRefreshTopHeight;

  ///刷新栏RefreshBox的高度
  double _refreshHeight = 0.0;

  AnimationStates animationStates = AnimationStates.RefreshBoxIdle;

  ///记录RefreshBox在动画过程中是触发刷新（加载）的回缩还是刷新（加载）数据完后触发的刷新，
  RefreshBoxAnimationModel _boxAnimationStatus;

  bool isReset = false;
  bool isPulling = false;
  Widget _deactiveIndicator;
  Widget _releaseIndicator;

  TextStyle _indicatorTextStyle = TextStyle(color: Colors.grey, fontSize: 14.0);

  @override
  void initState() {
    super.initState();
    _refreshHeight = widget.distanceToRefresh;
    _triggerRefreshTopHeight = widget.distanceToRefresh + 10.0;
    widget.direction == 'down'
        ? _deactiveIndicator = Text('下拉可以刷新')
        : _deactiveIndicator = Text('上拉可以刷新');
    widget.releaseIndicator != null
        ? _releaseIndicator = widget.releaseIndicator
        : _releaseIndicator = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ActivityIndicator()],
          );

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    animation = new Tween(begin: 1.0, end: 0.0).animate(animationController)
      ..addListener(() {
        //因为animationController reset()后，addListener会收到监听，导致再执行一遍setState topItemHeight和bottomItemHeight会异常 所以用此标记
        //判断是reset的话就返回避免异常
        if (isReset) return;
        setState(() {
          switch (_boxAnimationStatus) {
            case RefreshBoxAnimationModel.PUSH_BEFORE_LOAD_DATA:
              bottomItemHeight =
                  _refreshHeight + _shrinkageDistance * animation.value;
              break;
            case RefreshBoxAnimationModel.PULL_BEFORE_LOAD_DATA:
              topItemHeight =
                  _refreshHeight + _shrinkageDistance * animation.value;
              break;
            case RefreshBoxAnimationModel.PUSH_RECOVER_TO_NORMAL:
              bottomItemHeight = _shrinkageDistance * animation.value;
              break;
            case RefreshBoxAnimationModel.PULL_RECOVER_TO_NORMAL:
              topItemHeight = _shrinkageDistance * animation.value;
              break;
          }
        });
      });

    animation.addStatusListener((AnimationStatus animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        isReset = true;
        animationController.reset();
        isReset = false;
        setState(() {
          switch (_boxAnimationStatus) {
            case RefreshBoxAnimationModel.PUSH_BEFORE_LOAD_DATA:
              bottomItemHeight = _refreshHeight;
              _startRefresh();
              break;
            case RefreshBoxAnimationModel.PULL_BEFORE_LOAD_DATA:
              topItemHeight = _refreshHeight;
              _startRefresh();
              break;
            case RefreshBoxAnimationModel.PUSH_RECOVER_TO_NORMAL:
              bottomItemHeight = 0.0;
              isPulling = false;
              animationStates = AnimationStates.RefreshBoxIdle;
              widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
              break;
            case RefreshBoxAnimationModel.PULL_RECOVER_TO_NORMAL:
              topItemHeight = 0.0;
              isPulling = false;
              animationStates = AnimationStates.RefreshBoxIdle;
              widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
              break;
          }
        });
      } else if (animationStatus == AnimationStatus.forward) {
        if (topItemHeight > _triggerRefreshTopHeight) {
          _shrinkageDistance = topItemHeight - _triggerRefreshTopHeight;
          _boxAnimationStatus = RefreshBoxAnimationModel.PULL_BEFORE_LOAD_DATA;
        } else if (bottomItemHeight > _triggerRefreshTopHeight) {
          _shrinkageDistance = bottomItemHeight - _refreshHeight;
          _boxAnimationStatus = RefreshBoxAnimationModel.PUSH_BEFORE_LOAD_DATA;
        } else if (bottomItemHeight <= _refreshHeight &&
            bottomItemHeight > 0.0) {
          _shrinkageDistance = bottomItemHeight;
          _boxAnimationStatus = RefreshBoxAnimationModel.PUSH_RECOVER_TO_NORMAL;
        } else {
          if (topItemHeight <= _triggerRefreshTopHeight &&
              topItemHeight > 0.0) {
            _shrinkageDistance = topItemHeight;
            _boxAnimationStatus =
                RefreshBoxAnimationModel.PULL_RECOVER_TO_NORMAL;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget _buildRefreshHeader() {
    return DefaultTextStyle(
      style: _indicatorTextStyle,
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        margin: EdgeInsets.symmetric(vertical: topItemHeight > 0 ? 8.0 : 0.0),
        height: topItemHeight,
        child: Align(
          child: animationStates == AnimationStates.StartLoadData
              ? _releaseIndicator
              : animationStates == AnimationStates.DragAndRefreshEnabled
                  ? widget.activateIndicator
                  : animationStates == AnimationStates.LoadDataEnd
                      ? widget.finishIndicator
                      : this._deactiveIndicator,
        ),
      ),
    );
  }

  Widget _buildRefreshFooter() {
    return DefaultTextStyle(
      style: _indicatorTextStyle,
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        margin:
            EdgeInsets.symmetric(vertical: bottomItemHeight > 0 ? 8.0 : 0.0),
        height: bottomItemHeight,
        child: Align(
          child: animationStates == AnimationStates.StartLoadData
              ? _releaseIndicator
              : animationStates == AnimationStates.DragAndRefreshEnabled
                  ? widget.activateIndicator
                  : animationStates == AnimationStates.LoadDataEnd
                      ? widget.finishIndicator
                      : this._deactiveIndicator,
        ),
      ),
    );
  }

  void _startRefresh() {
    setState(() {
      animationStates = AnimationStates.StartLoadData;
    });
    widget.onRefresh().then((data) {
      if (!mounted) return;

      if (topItemHeight > 0.0 || bottomItemHeight > 0.0) {
        setState(() {
          animationStates = AnimationStates.LoadDataEnd;
        });
        animationController.forward();
      } else {
        isPulling = false;
        setState(() {
          animationStates = AnimationStates.RefreshBoxIdle;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.direction == 'down'
            ? <Widget>[
                _buildRefreshHeader(),
                Expanded(
                  flex: 1,
                  child: NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      ScrollMetrics metrics = notification.metrics;
                      if (notification is ScrollUpdateNotification) {
                        _handleScrollUpdateNotification(notification);
                      } else if (notification is UserScrollNotification) {
                        _handleUserScrollNotification(notification);
                      } else if (notification is ScrollEndNotification) {
                        _handleScrollEndNotification(notification);
                      } else if (metrics.atEdge &&
                          notification is OverscrollNotification) {
                        _handleOverscrollNotification(notification);
                      }
                      return true;
                    },
                    child: ScrollConfiguration(
                      behavior: ScrollViewBehavior(false, false, Colors.blue),
                      child: widget.listView,
                    ),
                  ),
                )
              ]
            : <Widget>[
                Expanded(
                  flex: 1,
                  child: NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      ScrollMetrics metrics = notification.metrics;
                      if (notification is ScrollUpdateNotification) {
                        _handleScrollUpdateNotification(notification);
                      } else if (notification is UserScrollNotification) {
                        _handleUserScrollNotification(notification);
                      } else if (notification is ScrollEndNotification) {
                        _handleScrollEndNotification(notification);
                      } else if (metrics.atEdge &&
                          notification is OverscrollNotification) {
                        _handleOverscrollNotification(notification);
                      }
                      return true;
                    },
                    child: ScrollConfiguration(
                      behavior: ScrollViewBehavior(false, false, Colors.blue),
                      child: widget.listView,
                    ),
                  ),
                ),
                _buildRefreshFooter()
              ],
      ),
    );
  }

  void _handleScrollUpdateNotification(ScrollUpdateNotification notification) {
    if (notification.dragDetails == null) {
      return;
    }
    if (topItemHeight > 0.0) {
      setState(() {
        if (topItemHeight + notification.dragDetails.delta.dy / 2 <= 0.0) {
          animationStates = AnimationStates.RefreshBoxIdle;
          topItemHeight = 0.0;

          widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
        } else {
          //当刷新布局可见时，让头部刷新布局的高度+delta.dy(此时dy为负数)，来缩小头部刷新布局的高度
          topItemHeight = topItemHeight + notification.dragDetails.delta.dy / 2;
          if (topItemHeight < _refreshHeight)
            animationStates = AnimationStates.RefreshBoxIdle;
        }
      });
    } else if (bottomItemHeight > 0.0) {
      setState(() {
        if (bottomItemHeight - notification.dragDetails.delta.dy / 2 <= 0.0) {
          bottomItemHeight = 0.0;
          animationStates = AnimationStates.RefreshBoxIdle;
          widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
        } else {
          if (notification.dragDetails.delta.dy > 0) {
            bottomItemHeight =
                bottomItemHeight - notification.dragDetails.delta.dy / 2;

            if (bottomItemHeight < _refreshHeight)
              animationStates = AnimationStates.RefreshBoxIdle;
          }
        }
      });
    }
  }

  void _handleUserScrollNotification(UserScrollNotification notification) {
    if (bottomItemHeight > 0.0 &&
        notification.direction == ScrollDirection.forward) {
      //底部加载布局出现反向滑动时（由上向下），将scrollPhysics置为RefreshScrollPhysics，只要有2个原因。1 减缓滑回去的速度，2 防止手指快速滑动时出现惯性滑动
      widget.scrollPhysicsChanged(new RefreshScrollPhysics());
    } else if (topItemHeight > 0.0 &&
        notification.direction == ScrollDirection.reverse) {
      //头部刷新布局出现反向滑动时（由下向上）,减缓listview的滑动速度，保持与headerbox高度减少的速率同步
      widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
    } else if (bottomItemHeight > 0 &&
        notification.direction == ScrollDirection.reverse) {
      widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
    }
  }

  // 用户松手
  void _handleScrollEndNotification(ScrollEndNotification notification) {
    if (topItemHeight > 0 || bottomItemHeight > 0) {
      if (isPulling == true) return;
      if (bottomItemHeight > 0) {
        isPulling = true;
      }
      widget.scrollPhysicsChanged(new NeverScrollableScrollPhysics());
      animationController.forward();
    }
  }

  void _handleOverscrollNotification(OverscrollNotification notification) {
    if (notification.dragDetails == null) {
      return;
    }

    if (notification.overscroll < 0.0 &&
        bottomItemHeight < 0.5 &&
        widget.direction == 'down') {
      setState(() {
        if (notification.dragDetails.delta.dy / 2 + topItemHeight <= 0.0) {
          animationStates = AnimationStates.RefreshBoxIdle;
          topItemHeight = 0.0;
          widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
        } else {
          if (topItemHeight > widget.damping) {
            topItemHeight = widget.damping;
          } else if (topItemHeight > widget.damping * 0.8) {
            topItemHeight =
                notification.dragDetails.delta.dy / 6 + topItemHeight;
          } else if (topItemHeight > _triggerRefreshTopHeight) {
            animationStates = AnimationStates.DragAndRefreshEnabled;
            topItemHeight =
                notification.dragDetails.delta.dy / 4 + topItemHeight;
          } else {
            topItemHeight =
                notification.dragDetails.delta.dy / 2 + topItemHeight;
          }
        }
      });
    } else if (topItemHeight < 0.5 && widget.direction == 'up') {
      setState(() {
        if (-notification.dragDetails.delta.dy / 2 + bottomItemHeight <= 0.0) {
          bottomItemHeight = 0.0;
          animationStates = AnimationStates.RefreshBoxIdle;
          widget.scrollPhysicsChanged(RefreshAlwaysScrollPhysics());
        } else {
          if (bottomItemHeight > widget.damping) {
            bottomItemHeight = widget.damping;
          } else if (bottomItemHeight > widget.damping * 0.8) {
            bottomItemHeight =
                -notification.dragDetails.delta.dy / 6 + bottomItemHeight;
          } else if (bottomItemHeight > _triggerRefreshTopHeight) {
            animationStates = AnimationStates.DragAndRefreshEnabled;
            bottomItemHeight =
                -notification.dragDetails.delta.dy / 4 + bottomItemHeight;
          } else {
            bottomItemHeight =
                -notification.dragDetails.delta.dy / 2 + bottomItemHeight;
          }
        }
      });
    }
  }
}

///切记 继承ScrollPhysics  必须重写applyTo，，在NeverScrollableScrollPhysics类里面复制就可以
///出现反向滑动时用此ScrollPhysics
class RefreshScrollPhysics extends ScrollPhysics {
  const RefreshScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  RefreshScrollPhysics applyTo(ScrollPhysics ancestor) {
    return new RefreshScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }

  ///防止ios设备上出现弹簧效果
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError(
            '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.\n'
            'The physics object in question was:\n'
            '  $this\n'
            'The position object in question was:\n'
            '  $position\n');
      }
      return true;
    }());
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) // underscroll
      return value - position.pixels;
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) // overscroll
      return value - position.pixels;
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) // hit top edge
      return value - position.minScrollExtent;
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) // hit bottom edge
      return value - position.maxScrollExtent;
    return 0.0;
  }

  //重写这个方法为了减缓ListView滑动速度
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (offset < 0.0) {
      return 0.00000000000001;
    }
    if (offset == 0.0) {
      return 0.0;
    }
    return offset / 2;
  }

  //此处返回null时为了取消惯性滑动
  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return null;
  }
}

///切记 继承ScrollPhysics  必须���写applyTo，，在NeverScrollableScrollPhysics类里面复制就可以
///此类用来控制IOS过度滑动出现弹簧效果
class RefreshAlwaysScrollPhysics extends AlwaysScrollableScrollPhysics {
  const RefreshAlwaysScrollPhysics({ScrollPhysics parent})
      : super(parent: parent);

  @override
  RefreshAlwaysScrollPhysics applyTo(ScrollPhysics ancestor) {
    return new RefreshAlwaysScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }

  ///防止ios设备上出现弹簧效果
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError(
            '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.\n'
            'The physics object in question was:\n'
            '  $this\n'
            'The position object in question was:\n'
            '  $position\n');
      }
      return true;
    }());
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) // underscroll
      return value - position.pixels;
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) // overscroll
      return value - position.pixels;
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) // hit top edge
      return value - position.minScrollExtent;
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) // hit bottom edge
      return value - position.maxScrollExtent;
    return 0.0;
  }

  ///防止ios设备出现卡顿
  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (position.outOfRange) {
      double end;
      if (position.pixels > position.maxScrollExtent)
        end = position.maxScrollExtent;
      if (position.pixels < position.minScrollExtent)
        end = position.minScrollExtent;
      assert(end != null);
      return ScrollSpringSimulation(spring, position.pixels,
          position.maxScrollExtent, math.min(0.0, velocity),
          tolerance: tolerance);
    }
    if (velocity.abs() < tolerance.velocity) return null;
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent)
      return null;
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent)
      return null;
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );
  }
}

///可去掉过度滑动时ListView顶部的蓝色光晕效果
class ScrollViewBehavior extends ScrollBehavior {
  final bool isShowLeadingGlow;
  final bool isShowTrailingGlow;
  final Color _kDefaultGlowColor;

  ScrollViewBehavior(
      this.isShowLeadingGlow, this.isShowTrailingGlow, this._kDefaultGlowColor);

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    //如果头部或底部有一个 不需要 显示光晕时 返回GlowingOverscrollIndicator
    if (!isShowLeadingGlow || !isShowTrailingGlow) {
      return new GlowingOverscrollIndicator(
        showLeading: isShowLeadingGlow,
        showTrailing: isShowTrailingGlow,
        child: child,
        axisDirection: axisDirection,
        color: _kDefaultGlowColor,
      );
    } else {
      //都需要光晕时  返回系统默认
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
