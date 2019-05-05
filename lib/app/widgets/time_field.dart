

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeFieldController extends ValueNotifier<TimeOfDay> {

  TimeFieldController({ TimeOfDay time })
    : super(time);

  TimeOfDay get time => value;

  set time(TimeOfDay newDateTime) {
    value = newDateTime;
  }

  void clear() {
    value = null;
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    Key key,
    @required
    this.controller,
    @required this.initialTime,
    this.builder,
    @required
    this.child,
  }) :
    assert(controller != null),
    super(key: key);

  final TimeFieldController controller;
  final TimeOfDay initialTime;
  final TransitionBuilder builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        TimeOfDay timeOfDay = await showTimePicker(
          context: context,
          initialTime: controller.time ?? initialTime,
          builder: builder,
        );
        if (timeOfDay != null) {
          controller.time = timeOfDay;
        }
      },
    );
  }
}
