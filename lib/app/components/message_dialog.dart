import 'package:flutter/material.dart';

class MessageDialog extends Dialog {
  final String taskName;
  final String taskTime;
  final String taskDesc;
  Function dismissCallback;

  MessageDialog(
      {Key key,
      this.taskName,
      this.taskTime,
      this.taskDesc,
      this.dismissCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dismissDialog() {
      if (dismissCallback != null) {
        dismissCallback();
      }
      Navigator.of(context).pop();
    }

    return new GestureDetector(
//      onTap: outsideDismiss ? _dismissDialog : null,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          _createTitleWidget(context),
                          _createTimeWidget(),
                          _createDescWidget(),
                        ],
                      ),
                    ),
                    _createOperationWidget()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createTitleWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 15.0,
          width: 15.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7.5)),
              color: Color.fromARGB(255, 80, 210, 194)),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Dinner withAndreainner',
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: TextStyle(
                  color: Color.fromARGB(255, 74, 74, 74),
                  fontSize: 18,
                  fontFamily: 'Avenir'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Container(
              height: 1.0,
              color: Color.fromARGB(255, 216, 216, 216),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createTimeWidget() {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/time.png',
          width: 60.0,
          height: 60.0,
        ),
        Expanded(
          child: Text(
            '17AM · 7 pm',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        )
      ],
    );
  }

  Widget _createDescWidget() {
    return Container(
      child: Text(
        'This is a description of the task. This is a description of the task. This is a description of the task. This is a description of the task. ',
        style: TextStyle(fontSize: 13, color: Colors.black),
      ),
    );
  }

  Widget _createOperationWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            color: Color.fromARGB(255, 221, 221, 221),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            color: Color.fromARGB(255, 255, 92, 92),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
