import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/model/model_timetable.dart';

class WidgetAdjustTimetable extends StatefulWidget {
  const WidgetAdjustTimetable({
    super.key,
  });

  @override
  State<WidgetAdjustTimetable> createState() => _WidgetAdjustTimetableState();
}

class _WidgetAdjustTimetableState extends State<WidgetAdjustTimetable> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 420,
        height: 620,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Text('Adjust Time Schedule',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ),
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
                                child: Column(
                              children: [
                                for (int j = 0; j < TimeTable.courseNum; j++)
                                  SizedBox(
                                      height: 60,

                                      child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Enter Course Name'),
                                                  content: TextField(
                                                    controller: controller,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (timeTable[
                                                                  100 * i +
                                                                      j] !=
                                                              null) {
                                                            timeTable[100 * i +
                                                                        j]!
                                                                    .courseName =
                                                                controller.text;
                                                          } else {
                                                            timeTable[
                                                                100 * i +
                                                                    j] = TimeTable(
                                                                week: i,
                                                                ith: j,
                                                                courseName:
                                                                    controller
                                                                        .text);
                                                          }
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Change'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: AutoSizeText(
                                            (timeTable[100 * i + j] != null)
                                                ? timeTable[100 * i + j]!
                                                    .courseName
                                                : '',
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
                                          ))),
                              ],
                            )),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
