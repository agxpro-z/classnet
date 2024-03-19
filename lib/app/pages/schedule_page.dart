import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../res/values/strings.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(1970),
            lastDay: DateTime.utc(2030),
            rowHeight: 40.0,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) => setState(() {
              _calendarFormat = format;
            }),
            calendarStyle: CalendarStyle(
              cellMargin: const EdgeInsets.all(2.0),
              weekendTextStyle: TextStyle(
                color: theme.colorScheme.error,
              ),
              todayDecoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
              ),
              selectedDecoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: theme.colorScheme.onPrimary,
              )
            ),
            daysOfWeekHeight: 28.0,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: theme.colorScheme.error,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
          ),
        ],
      ),
    );
  }
}
