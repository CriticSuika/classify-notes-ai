import 'package:flutter/material.dart';

import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/service/service_file_control.dart';

import 'package:software_studio_project/model/model_note.dart';
import 'package:software_studio_project/service/service_assistant.dart';

class PageAdd extends StatefulWidget {
  PageAdd({super.key, this.preDate, this.preCourseName});

  DateTime? preDate;
  String? preCourseName;

  @override
  State<PageAdd> createState() => _PageAddState();
}

class _PageAddState extends State<PageAdd> {

  final _fileNameController = TextEditingController();
  final _courseNameController = TextEditingController();
  final _noteTypeController = TextEditingController();
  DateTime? _selectedDate = today;
  final _memoController = TextEditingController();

  Future<List<dynamic>>? files;
  ChatService chatService = ChatService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.preCourseName != null) {
        _courseNameController.text = widget.preCourseName!;
      }
    });
    setState(() {
      if (widget.preDate != null) {
        _selectedDate = widget.preDate;
      }
    });
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _courseNameController.dispose();
    _noteTypeController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  bool checkInputData() {
    return (files != null &&
        _fileNameController.text != '' &&
        _courseNameController.text != '' &&
        _noteTypeController.text != '' &&
        _selectedDate != null);
  }

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.preDate,
      firstDate: startDay,
      lastDate: endDay,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future<List> _performFilePick(BuildContext context) async {
    try {
      List<dynamic> files = await ServiceFileControl.pickAndUploadFiles();
      return files;
    } catch (e) {
      throw ('Error picking/uploading files: $e');
    }
  }

  Note createNewNote() {

    return Note(
        fileName: _fileNameController.text,
        courseName: _courseNameController.text,
        noteType: _noteTypeController.text,
        date: _selectedDate!,
        memo: _memoController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
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
            Text('Add Note',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        Expanded(
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: files != null
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.error),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      files = _performFilePick(context);
                    });
                  },
                  icon: Icon(
                    Icons.upload_file,
                    color: files != null
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.error,
                  ),
                  label: Text(
                    files != null ? 'I Got It!!!' : 'Note File',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: files != null
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'File Name:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: (stackPageWidth =
                            (MediaQuery.of(context).size.width > 640
                                ? 640
                                : MediaQuery.of(context).size.width)) *
                        0.55,
                    height: 50,
                    child: TextFormField(
                      controller: _fileNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ex: Lec_00',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Course Name:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: stackPageWidth * 0.55,
                    height: 50,
                    child: TextFormField(
                      controller: _courseNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ex: Software Studio',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Note Type:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: stackPageWidth * 0.55,
                    height: 50,
                    child: TextFormField(
                      controller: _noteTypeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ex: Lecture/SelfNote/etc',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Date:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
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
                          style: _selectedDate == null
                              ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.error)
                              : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Memo:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(
                    width: stackPageWidth - 40,
                    height: 120,
                    child: TextFormField(
                      controller: _memoController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write down anything about this note',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextButton.icon(
                  onPressed: () {
                    if (!checkInputData()) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Invalid input'),
                          content: const Text(
                              'Please make sure a valid text was entered.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text('Okay'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      setState(() {
                        Note newNote = createNewNote();
                        ServiceFileControl.uploadFile(files, newNote);
                        chatService.fetchPromptResponse(
                            'System: Uploaded note courseName"${newNote.courseName}" date${newNote.date}" fileName"${newNote.fileName}" noteType"${newNote.noteType}"');
                        Navigator.pop(context);
                      });
                    }
                  },
                  icon: const Icon(Icons.upload),
                  label: Text(
                    'Upload Note',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
