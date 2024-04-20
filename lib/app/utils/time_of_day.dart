import 'package:flutter/material.dart';

extension TimeOfDayComparison on TimeOfDay {
  int compareTo(TimeOfDay timeOfDay) {
    return (hour * 60 + minute) - (timeOfDay.hour * 60 + timeOfDay.minute);
  }
}
