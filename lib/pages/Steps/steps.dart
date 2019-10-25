import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/steps/steps.dart';

class PageSteps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Steps'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Steps(
                  current: 1,
                  size: 'small',
                  steps: [
                    StepItem(
                      title: 'Finished',
                      description: 'This is description',
                    ),
                    StepItem(
                      title: 'In Progress',
                      description: 'This is description',
                    ),
                    StepItem(
                      title: 'Waiting',
                      description: 'This is description',
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Steps(
                  current: 1,
                  size: 'small',
                  steps: [
                    StepItem(
                      title: 'Finished',
                    ),
                    StepItem(
                      title: 'In Progress',
                    ),
                    StepItem(
                      title: 'Waiting',
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Steps(
                  steps: [
                    StepItem(
                      title: 'Finished',
                      status: 'process',
                      description: 'This is description',
                    ),
                    StepItem(
                      title: 'Error',
                      status: 'error',
                      description: 'This is description',
                    ),
                    StepItem(
                      title: 'Waiting',
                      description: 'This is description',
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Steps(
                  steps: [
                    StepItem(
                      title: 'Step 1',
                      status: 'finish',
                      icon: Icon(Icons.import_contacts),
                    ),
                    StepItem(
                      title: 'Step 2',
                      status: 'process',
                      icon: Icon(Icons.import_contacts),
                    ),
                    StepItem(
                      status: 'error',
                      title: 'Step 3',
                      icon: Icon(Icons.import_contacts),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Steps(
                  current: 1,
                  steps: [
                    StepItem(
                      title: 'Step 1',
                      description: 'This is description',
                      icon: Icon(Icons.import_contacts),
                    ),
                    StepItem(
                      title: 'Step 2',
                      description: 'This is description',
                      icon: Icon(Icons.import_contacts),
                    ),
                    StepItem(
                      title: 'Step 3',
                      description: 'This is description',
                      icon: Icon(Icons.import_contacts),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Steps(
                      direction: 'horizontal',
                      current: 1,
                      size: 'small',
                      steps: [
                        StepItem(
                          title: 'Finished',
                          description: 'This is description',
                        ),
                        StepItem(
                          title: 'In Progress',
                          description: 'This is description',
                        ),
                        StepItem(
                          title: 'Waiting',
                          description: 'This is description',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Steps(
                      direction: 'horizontal',
                      current: 1,
                      steps: [
                        StepItem(
                          title: 'Finished',
                          description: 'This is description',
                        ),
                        StepItem(
                          title: 'In Progress',
                          description: 'This is description',
                        ),
                        StepItem(
                          title: 'Waiting',
                          description: 'This is description',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Steps(
                      direction: 'horizontal',
                      current: 1,
                      steps: [
                        StepItem(
                          title: 'Step 1',
                          icon: Icons.access_alarm,
                        ),
                        StepItem(
                          title: 'Step 2',
                          status: 'error',
                          icon: Icons.access_alarm,
                        ),
                        StepItem(
                          title: 'Step 3',
                          icon: Icons.access_alarm,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
