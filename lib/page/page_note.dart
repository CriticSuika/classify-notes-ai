import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/model/model_note.dart';
import 'package:software_studio_project/widget/widget_note_view.dart';
import 'package:software_studio_project/service/service_file_control.dart';
import 'package:software_studio_project/service/service_assistant.dart';
import 'package:software_studio_project/page/page_search_note.dart';

class PageNote extends StatefulWidget {
  const PageNote({super.key});

  @override
  State<PageNote> createState() => _PageNoteState();
}

class _PageNoteState extends State<PageNote> {
  final String myApiKey = '';
  ChatService chatService = ChatService();

  Key key1 = UniqueKey();
  Key key2 = UniqueKey();
  Key key3 = UniqueKey();
  Key key4 = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  ToggleListItem toggleItem(String date, String courseName, String noteType,
      String fileName, String memo, String? fileUrl, String id) {
    return ToggleListItem(
      headerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
      title: Row(
        children: [
          for (int i = 0; i < 4; i++)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                child: AutoSizeText(
                  (() {
                    switch (i) {
                      case 0:
                        return date;
                      case 1:
                        return courseName;
                      case 2:
                        return noteType;
                      case 3:
                        return fileName;
                      default:
                        return 'impossible';
                    }
                  })(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
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
        ],
      ),
      content: toggleContent(
          memo, fileUrl, fileName, id, date, courseName, noteType),
    );
  }

  Widget toggleContent(String memo, String? fileUrl, String fileName, String id,
      String date, String courseName, String noteType) {

    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    memo,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(8, 0, 8, 0)),
                        ),
                        onPressed: () {
                          ServiceFileControl.openFile(fileName);
                        },
                        child: const Text('Open File')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(8, 0, 8, 0)),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Alert'),
                              content: const Text(
                                  'Are you sure to delete this note?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      Note.noteDelete(id);
                                      ServiceFileControl.deleteNoteById(id);
                                      chatService.fetchPromptResponse(
                                          'System: Deleted note courseName"$courseName" date"$date" fileName"$fileName" noteType"$noteType"');
                                    });
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Okay'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Delete Note')),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget viewByDate(Key key) {

    return ToggleList(
        divider: const SizedBox(
          height: 8,
        ),
        children: List.generate(noteByDate.value.length, (index) {
          return toggleItem(
              formatter.format(notes.value[noteByDate.value[index]]!.date),
              notes.value[noteByDate.value[index]]!.courseName,
              notes.value[noteByDate.value[index]]!.noteType,
              notes.value[noteByDate.value[index]]!.fileName,
              notes.value[noteByDate.value[index]]!.memo,
              notes.value[noteByDate.value[index]]!.fileUrl,
              notes.value[noteByDate.value[index]]!.id);
        }));
  }

  Widget viewByFileName(Key key) {

    return ToggleList(
        divider: const SizedBox(
          height: 8,
        ),
        children: List.generate(noteByFileName.value.length, (index) {
          return toggleItem(
              formatter.format(notes.value[noteByFileName.value[index]]!.date),
              notes.value[noteByFileName.value[index]]!.courseName,
              notes.value[noteByFileName.value[index]]!.noteType,
              notes.value[noteByFileName.value[index]]!.fileName,
              notes.value[noteByFileName.value[index]]!.memo,
              notes.value[noteByFileName.value[index]]!.fileUrl,
              notes.value[noteByFileName.value[index]]!.id);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(width: appWidth / 10),
              for (int i = 1; i <= 4; i++)
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        Note.viewBy = i;
                        key1 = UniqueKey();
                        key2 = UniqueKey();
                        key3 = UniqueKey();
                        key4 = UniqueKey();
                      });
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(4, 0, 4, 0)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        (() {
                          switch (i) {
                            case 1:
                              return 'Date';
                            case 2:
                              return 'Course Name';
                            case 3:
                              return 'Note Type';
                            case 4:
                              return 'File Name';
                            default:
                              return 'impossible';
                          }
                        })(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Note.viewBy == i
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary),
                        maxLines: 3,
                        minFontSize: 10,
                        maxFontSize: 40,
                        softWrap: true,
                        wrapWords: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 24),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 0.8,
          indent: appWidth / 10 + 8,
          endIndent: 8,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: appWidth / 10,
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.sync,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (ctx) => const PageSearchNote(),
                        );
                      },
                      icon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(builder: (context) {
                  switch (Note.viewBy) {
                    case 1:
                      return viewByDate(key1);
                    case 2:
                      return WidgetNoteView(
                          localViewBy: Note.viewBy,
                          toggleItem: toggleItem,
                          key: key2);
                    case 3:
                      return WidgetNoteView(
                          localViewBy: Note.viewBy,
                          toggleItem: toggleItem,
                          key: key3);
                    case 4:
                      return viewByFileName(key4);
                    default:
                      return viewByDate(key1);
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
