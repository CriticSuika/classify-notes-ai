import 'package:flutter/material.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/model/model_note.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:software_studio_project/service/service_file_control.dart';

class PageSearchNote extends StatefulWidget {
  const PageSearchNote({
    super.key,
  });

  @override
  State<PageSearchNote> createState() => _PageSearchNoteState();
}

class _PageSearchNoteState extends State<PageSearchNote> {

  final _searchController = TextEditingController();
  DateTime? _selectedDate = today;
  List<Note> filteredNotes = [];

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: startDay,
      lastDate: endDay,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  ToggleListItem toggleItem(String date, String courseName, String noteType,
      String fileName, String memo, String? fileUrl, String id) {
    return ToggleListItem(
      headerDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
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
      content: toggleContent(memo, fileUrl, fileName, id),
    );
  }

  Widget toggleContent(
      String memo, String? fileUrl, String fileName, String id) {

    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiary,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
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
              flex: 1,
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
                          setState(() {
                            Note.noteDelete(id);
                            ServiceFileControl.deleteNoteById(id);
                          });
                        },
                        child: const Text('Delete Note')),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _searchName() {
    final query = _searchController.text;

    final results = notes.value.values
        .where((element) => (element.noteType.contains(query) ||
                element.courseName.contains(query) ||
                element.date == _selectedDate)
            )
        .toList();

    setState(() {
      filteredNotes = results;
    });
  }

  Widget view() {

    if (filteredNotes.isEmpty) return const Text('empty');
    return ToggleList(
        divider: const SizedBox(
          height: 8,
        ),
        children: List.generate(filteredNotes.length, (index) {
          return toggleItem(
              formatter.format(filteredNotes[index].date),
              filteredNotes[index].courseName,
              filteredNotes[index].noteType,
              filteredNotes[index].fileName,
              filteredNotes[index].memo,
              filteredNotes[index].fileUrl,
              filteredNotes[index].id);
        }));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Text('Search Note',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      'Searching:     ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(
                      width: (stackPageWidth =
                              (MediaQuery.of(context).size.width > 640
                                  ? 640
                                  : MediaQuery.of(context).size.width)) *
                          0.55,
                      height: 50,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'input CourseName or Notetype to find the file',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _searchName();
                      },
                      icon: const Icon(Icons.arrow_forward),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Date:',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: stackPageWidth * 0.55,
                      height: 50,
                      child: Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Builder(builder: (context) {
            return view();
          }),
        ),
      ],
    );
  }
}
