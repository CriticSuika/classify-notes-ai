import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:software_studio_project/page/page_add.dart';
import 'package:software_studio_project/model/model_timetable.dart';
import 'package:software_studio_project/global.dart';

import 'package:software_studio_project/service/service_file_control.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = today;
  DateTime _focusedDay = today;

  @override
  void initState() {
    super.initState();
    ServiceFileControl.getNotesByUser();
  }

  bool selectedWeek(int i) {
    String week = DateFormat('EEEE').format(_selectedDay);
    switch (i) {
      case 1:
        if (week == 'Monday') return true;
        return false;
      case 2:
        if (week == 'Tuesday') return true;
        return false;
      case 3:
        if (week == 'Wednesday') return true;
        return false;
      case 4:
        if (week == 'Thursday') return true;
        return false;
      case 5:
        if (week == 'Friday') return true;
        return false;
      case 6:
        if (week == 'Saturday') return true;
        return false;
      default:
        return false;
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 6,
              ),
              height: 40.0,
              width: appWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedDay = today;
                        _focusedDay = today;
                      });
                    },
                    icon: const Icon(Icons.sync, size: 18),
                  ),
                  Text(
                    'Week $weekX',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ),

                  Text(DateFormat.Hm().format(today)),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TableCalendar(
            firstDay: startDay,
            lastDay: endDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            rowHeight: 35,
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
              headerPadding: const EdgeInsets.symmetric(vertical: 0),
              titleTextStyle: Theme.of(context).textTheme.bodyMedium!,
              formatButtonTextStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              selectedTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              defaultTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              weekendTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              outsideTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              weekendStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week'
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _selectedDay = focusedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          for (int j = 0; j < TimeTable.courseNum; j++)
                            SizedBox(
                              height: 60,
                              child: Center(
                                child: AutoSizeText(
                                  timeTable[j]!.courseName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                  maxLines: 4,
                                  minFontSize: 4,
                                  maxFontSize: 40,
                                  softWrap: true,
                                  wrapWords: false,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    for (int i = 1; i < 7; i++)
                      Expanded(
                          child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: selectedWeek(i)
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary)
                              : null,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            for (int j = 0; j < TimeTable.courseNum; j++)
                              SizedBox(
                                  height: 60,

                                  child: (timeTable[100 * i + j] != null)
                                      ? (selectedWeek(i)
                                          ? TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (ctx) => PageAdd(
                                                      preDate: _selectedDay,
                                                      preCourseName: timeTable[
                                                              100 * i + j]!
                                                          .courseName),
                                                );
                                              },
                                              child: AutoSizeText(
                                                timeTable[100 * i + j]!
                                                    .courseName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                maxLines: 4,
                                                minFontSize: 4,
                                                maxFontSize: 40,
                                                softWrap: true,
                                                wrapWords: false,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ))
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: AutoSizeText(
                                                timeTable[100 * i + j]!
                                                    .courseName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                maxLines: 4,
                                                minFontSize: 4,
                                                maxFontSize: 40,
                                                softWrap: true,
                                                wrapWords: false,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                      : null),
                          ],
                        ),
                      )),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
