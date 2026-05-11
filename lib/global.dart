import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:software_studio_project/model/model_timetable.dart';
import 'package:software_studio_project/model/model_note.dart';

DateTime today = DateTime.now();
final startDay = DateTime.utc(2020, 4, 13);
final endDay = DateTime.utc(2030, 4, 13);

final formatter = DateFormat.yMd();

double appWidth = 400;
double appHeight = 400;
double stackPageWidth = (appWidth > 640 ? 640 : appWidth);

ValueNotifier<bool> isLogin = ValueNotifier<bool>(false);

Map<int, TimeTable> timeTable = {
  0: TimeTable(
    week: 0,
    ith: 0,
    courseName: '1',
  ),
  1: TimeTable(
    week: 0,
    ith: 1,
    courseName: '2',
  ),
  2: TimeTable(
    week: 0,
    ith: 2,
    courseName: '3',
  ),
  3: TimeTable(
    week: 0,
    ith: 3,
    courseName: '4',
  ),
  4: TimeTable(
    week: 0,
    ith: 4,
    courseName: 'n',
  ),
  5: TimeTable(
    week: 0,
    ith: 5,
    courseName: '5',
  ),
  6: TimeTable(
    week: 0,
    ith: 6,
    courseName: '6',
  ),
  7: TimeTable(
    week: 0,
    ith: 7,
    courseName: '7',
  ),
  8: TimeTable(
    week: 0,
    ith: 8,
    courseName: '8',
  ),
  102: TimeTable(
    week: 1,
    ith: 2,
    courseName: 'Happy Day Course',
  ),
  103: TimeTable(
    week: 1,
    ith: 3,
    courseName: 'Happy Day Course',
  ),
  105: TimeTable(
    week: 1,
    ith: 5,
    courseName: 'Sad Course',
  ),
  106: TimeTable(
    week: 1,
    ith: 6,
    courseName: 'Sad Course',
  ),
  207: TimeTable(
    week: 2,
    ith: 7,
    courseName: 'Software Studio',
  ),
  208: TimeTable(
    week: 2,
    ith: 8,
    courseName: 'Software Studio',
  ),
  300: TimeTable(
    week: 3,
    ith: 0,
    courseName: 'Table Tennis',
  ),
  301: TimeTable(
    week: 3,
    ith: 1,
    courseName: 'Table Tennis',
  ),
  403: TimeTable(
    week: 4,
    ith: 3,
    courseName: 'Bored Course',
  ),
  407: TimeTable(
    week: 4,
    ith: 7,
    courseName: 'Software Studio',
  ),
  408: TimeTable(
    week: 4,
    ith: 8,
    courseName: 'Software Studio',
  ),
  505: TimeTable(
    week: 5,
    ith: 5,
    courseName: 'Some kinds of Course',
  ),
  506: TimeTable(
    week: 5,
    ith: 6,
    courseName: 'Some kinds of Course',
  ),
  507: TimeTable(
    week: 5,
    ith: 7,
    courseName: 'Some kinds of Course',
  ),
};

ValueNotifier<Map<String, Note>> notes = ValueNotifier<Map<String, Note>>({});

ValueNotifier<List<String>> noteByDate = ValueNotifier<List<String>>([]);

ValueNotifier<List<String>> noteByCourseName = ValueNotifier<List<String>>([]);

ValueNotifier<List<String>> noteByNoteType = ValueNotifier<List<String>>([]);

ValueNotifier<List<String>> noteByFileName = ValueNotifier<List<String>>([]);

String userId = '';

String userEmail = '';

String userName = '';

String userAvatarUrl = '';

DateTime? startDate = DateTime.now();

int? weekX = 4;
