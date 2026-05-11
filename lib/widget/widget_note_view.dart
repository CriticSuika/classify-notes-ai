import 'package:flutter/material.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:software_studio_project/global.dart';

class WidgetNoteView extends StatefulWidget {
  const WidgetNoteView(
      {required this.localViewBy, required this.toggleItem, super.key});

  final int localViewBy;

  final Function(String date, String courseName, String noteType,
      String fileName, String memo, String fileUrl, String id) toggleItem;

  @override
  State<WidgetNoteView> createState() => _WidgetNoteViewState();
}

class _WidgetNoteViewState extends State<WidgetNoteView> {
  final PageController controller = PageController();
  int selectedPage1 = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: controller,
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, pageIndex) {
          switch (pageIndex) {
            case 0:
              switch (widget.localViewBy) {
                case 2:
                  List<String> courseNameList = [];
                  for (int i = 0; i < noteByCourseName.value.length; i++) {

                    if (i == 0 ||
                        (notes.value[noteByCourseName.value[i]]!.courseName !=
                            notes.value[noteByCourseName.value[i - 1]]!.courseName)) {
                      courseNameList
                          .add(notes.value[noteByCourseName.value[i]]!.courseName);
                    }
                  }
                  return ListView(
                      children: List.generate(courseNameList.length, (index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPage1 = index;
                            });
                            controller.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            child: Row(
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                      child: AutoSizeText(
                                        (() {
                                          switch (i) {
                                            case 0:
                                              return '---';
                                            case 1:
                                              return courseNameList[index];
                                            case 2:
                                              return '---';
                                            case 3:
                                              return '---';
                                            default:
                                              return 'impossible';
                                          }
                                        })(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                        maxLines: 3,
                                        minFontSize: 10,
                                        maxFontSize: 40,
                                        softWrap: true,
                                        wrapWords: false,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 24)
                              ],
                            ),
                          ),
                        ));
                  }));
                case 3:
                  List<String> noteTypeList = [];
                  for (int i = 0; i < noteByNoteType.value.length; i++) {

                    if (i == 0 ||
                        (notes.value[noteByNoteType.value[i]]!.noteType !=
                            notes.value[noteByNoteType.value[i - 1]]!.noteType)) {
                      noteTypeList.add(notes.value[noteByNoteType.value[i]]!.noteType);
                    }
                  }
                  return ListView(
                      children: List.generate(noteTypeList.length, (index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPage1 = index;
                            });
                            controller.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            child: Row(
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                      child: AutoSizeText(
                                        (() {
                                          switch (i) {
                                            case 0:
                                              return '---';
                                            case 1:
                                              return '---';
                                            case 2:
                                              return noteTypeList[index];
                                            case 3:
                                              return '---';
                                            default:
                                              return 'impossible';
                                          }
                                        })(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                        maxLines: 3,
                                        minFontSize: 10,
                                        maxFontSize: 40,
                                        softWrap: true,
                                        wrapWords: false,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 24)
                              ],
                            ),
                          ),
                        ));
                  }));
                default:
                  return const Text('widget.localViewBy got wrong');
              }
            case 1:
              switch (widget.localViewBy) {
                case 2:
                  int border1 = 0, border2 = 0;
                  for (int i = 0;
                      border2 < noteByCourseName.value.length - 1;
                      border2++) {
                    if (notes.value[noteByCourseName.value[border2 + 1]]!.courseName !=
                        notes.value[noteByCourseName.value[border2]]!.courseName) {
                      i++;
                      if (i == selectedPage1) {
                        border1 = border2 + 1;
                      } else if (i == selectedPage1 + 1) {
                        break;
                      }
                    }
                  }
                  if (border2 == -1) border2 = noteByCourseName.value.length - 1;
                  return ToggleList(
                      divider: const SizedBox(
                        height: 8,
                      ),
                      children: List.generate(border2 - border1 + 1, (index) {
                        return widget.toggleItem(
                            formatter.format(
                                notes.value[noteByCourseName.value[border1 + index]]!.date),
                            notes.value[noteByCourseName.value[border1 + index]]!
                                .courseName,
                            notes.value[noteByCourseName.value[border1 + index]]!.noteType,
                            notes.value[noteByCourseName.value[border1 + index]]!.fileName,
                            notes.value[noteByCourseName.value[border1 + index]]!.memo,
                            notes.value[noteByCourseName.value[border1 + index]]!.fileUrl!,
                            notes.value[noteByCourseName.value[border1 + index]]!.id);
                      }));
                case 3:
                  int border1 = 0, border2 = 0;
                  for (int i = 0;
                      border2 < noteByNoteType.value.length - 1;
                      border2++) {
                    if (notes.value[noteByNoteType.value[border2 + 1]]!.noteType !=
                        notes.value[noteByNoteType.value[border2]]!.noteType) {
                      i++;
                      if (i == selectedPage1) {
                        border1 = border2 + 1;
                      } else if (i == selectedPage1 + 1) {
                        break;
                      }
                    }
                  }
                  if (border2 == -1) border2 = noteByNoteType.value.length - 1;
                  return ToggleList(
                      divider: const SizedBox(
                        height: 8,
                      ),
                      children: List.generate(border2 - border1 + 1, (index) {
                        return widget.toggleItem(
                            formatter.format(
                                notes.value[noteByNoteType.value[border1 + index]]!.date),
                            notes.value[noteByNoteType.value[border1 + index]]!.courseName,
                            notes.value[noteByNoteType.value[border1 + index]]!.noteType,
                            notes.value[noteByNoteType.value[border1 + index]]!.fileName,
                            notes.value[noteByNoteType.value[border1 + index]]!.memo,
                            notes.value[noteByNoteType.value[border1 + index]]!.fileUrl!,
                            notes.value[noteByNoteType.value[border1 + index]]!.id);
                      }));
                default:
                  return const Text('widget.localViewBy got wrong');
              }
            default:
              return const Text('pageIndex got wrong');
          }
        });
  }
}
