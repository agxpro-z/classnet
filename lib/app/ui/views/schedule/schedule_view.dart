import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timelines/timelines.dart';

import '../../../../i18n/strings.g.dart';
import '../../../app.locator.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../../widgets/schedule/task_card.dart';
import 'schedule_viewmodel.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<ScheduleViewModel>.reactive(
      disposeViewModel: false,
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) => viewModel.initialize(),
      viewModelBuilder: () => locator<ScheduleViewModel>(),
      builder: (BuildContext context, ScheduleViewModel viewModel, Widget? child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => viewModel.fetchScheduleForDay(viewModel.taskDay),
          child: CustomScrollView(
            slivers: <Widget>[
              CustomSliverAppBar(
                isMainView: true,
                title: Text(
                  t.scheduleView.schedule,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  <Widget>[
                    TableCalendar(
                      focusedDay: viewModel.focusedDay,
                      firstDay: DateTime.utc(1970),
                      lastDay: DateTime.utc(2099),
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
                        ),
                      ),
                      daysOfWeekHeight: 28.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                          color: theme.colorScheme.error,
                        ),
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(viewModel.selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) async {
                        await viewModel.fetchScheduleForDay(DateFormat('EEE').format(focusedDay));
                        setState(() {
                          viewModel.selectedDay = selectedDay;
                          viewModel.focusedDay = focusedDay; // update `_focusedDay` here as well
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    if (viewModel.isBusy)
                      const Center(child: CircularProgressIndicator())
                    else
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                        child: FixedTimeline.tileBuilder(
                          theme: TimelineThemeData(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          builder: TimelineTileBuilder.connectedFromStyle(
                            contentsAlign: ContentsAlign.basic,
                            connectionDirection: ConnectionDirection.after,
                            nodePositionBuilder: (context, index) => 0.0,
                            firstConnectorStyle: ConnectorStyle.transparent,
                            lastConnectorStyle: ConnectorStyle.transparent,
                            contentsBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TaskCard(
                                task: viewModel.taskList[index],
                              ),
                            ),
                            connectorStyleBuilder: (context, index) {
                              if (DateFormat('EEE').format(DateTime.now()) != viewModel.taskDay) {
                                return ConnectorStyle.solidLine;
                              }
                              return viewModel.taskList[index].time.toString().compareTo(TimeOfDay.now().toString()) < 0 &&
                                      viewModel.taskList[index].time.toString().compareTo(
                                              (TimeOfDay(hour: TimeOfDay.now().hour - 1, minute: TimeOfDay.now().minute))
                                                  .toString()) >
                                          0
                                  ? ConnectorStyle.dashedLine
                                  : ConnectorStyle.solidLine;
                            },
                            indicatorStyleBuilder: (context, index) {
                              if (DateFormat('EEE').format(DateTime.now()) != viewModel.taskDay) {
                                return IndicatorStyle.outlined;
                              }
                              return viewModel.taskList[index].time.toString().compareTo(TimeOfDay.now().toString()) < 0
                                  ? IndicatorStyle.dot
                                  : IndicatorStyle.outlined;
                            },
                            itemCount: viewModel.taskList.length,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
