import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  NavBar(
      {Key key,
      this.mode = 'dark',
      this.icon,
      this.leftContent,
      this.rightContent,
      @required this.onLeftClick,
      @required this.title})
      : super(key: key);
  final String mode;
  final IconData icon;
  final String leftContent;
  final List<Widget> rightContent;
  final String title;
  final VoidCallback onLeftClick;

  Widget _buildLeftContent(BuildContext context) {
    if (this.icon == null && this.leftContent == null) {
      return Center();
    } else if (this.icon != null && this.leftContent == null) {
      return InkWell(
        onTap: this.onLeftClick,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(this.icon,
                  color: this.mode == 'light'
                      ? Theme.of(context).primaryColor
                      : Colors.white),
            )
          ],
        ),
      );
    } else if (this.icon == null && this.leftContent != null) {
      return InkWell(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                this.leftContent,
                style: TextStyle(
                    fontSize: 16.0,
                    color: this.mode == 'light'
                        ? Theme.of(context).primaryColor
                        : Colors.white),
              ),
            )
          ],
        ),
        onTap: this.onLeftClick,
      );
    } else {
      return InkWell(
        child: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(this.icon),
              SizedBox(
                width: 5.0,
              ),
              Text(
                this.leftContent,
                style: TextStyle(
                    fontSize: 16.0,
                    color: this.mode == 'light'
                        ? Theme.of(context).primaryColor
                        : Colors.white),
              )
            ],
          ),
        ),
        onTap: this.onLeftClick,
      );
    }
  }

  Widget _buildRightContent(BuildContext context) {
    if (this.rightContent == null) {
      return Center();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: this.rightContent,
      );
    }
  }

  Flex _buildContent(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Theme(
              data: ThemeData(
                  iconTheme: Theme.of(context).iconTheme.copyWith(
                      color: this.mode == 'light'
                          ? Theme.of(context).primaryColor
                          : Colors.white)),
              child: _buildLeftContent(context),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(this.title,
                style: TextStyle(
                    fontSize: 18.0,
                    color: this.mode == 'dark'
                        ? Colors.white
                        : Theme.of(context).textTheme.body1.color)),
          ),
          Flexible(
            flex: 1,
            child: Theme(
              data: ThemeData(
                  iconTheme: Theme.of(context).iconTheme.copyWith(
                      color: this.mode == 'light'
                          ? Theme.of(context).primaryColor
                          : Colors.white)),
              child: _buildRightContent(context),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: this.mode == 'dark' ? Brightness.dark : Brightness.light),
      child: Container(
        decoration: BoxDecoration(
            color: this.mode == 'dark'
                ? Theme.of(context).primaryColor
                : Colors.white),
        height: 45.0,
        child: _buildContent(context),
      ),
    );
  }
}
