

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateFieldController extends ValueNotifier<DateTime> {

  DateFieldController({ DateTime date })
    : super(date);

  DateTime get date => value;

  set date(DateTime newDateTime) {
    value = newDateTime;
  }

  void clear() {
    value = null;
  }
}

class DateField extends StatelessWidget {
  const DateField({
    Key key,
    @required
    this.controller,
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.selectableDayPredicate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.locale,
    this.builder,
    @required
    this.child,
  }) :
    assert(controller != null),
    super(key: key);

  final DateFieldController controller;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final SelectableDayPredicate selectableDayPredicate;
  final DatePickerMode initialDatePickerMode;
  final Locale locale;
  final TransitionBuilder builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        DateTime selectedDate = await showDatePicker(
          context: context,
          initialDate: controller.date ?? initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          selectableDayPredicate: selectableDayPredicate,
          initialDatePickerMode: initialDatePickerMode,
          locale: locale,
          builder: builder,
        );
        if (selectedDate != null) {
          controller.date = selectedDate;
        }
      },
    );
  }
}
