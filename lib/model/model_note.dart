import 'package:uuid/uuid.dart';

import 'package:software_studio_project/global.dart';

const uuid = Uuid();

class Note {
  Note(
      {this.fileUrl,
      required this.fileName,
      required this.courseName,
      required this.noteType,
      required this.date,
      required this.memo,
      String? curId})
      : id = curId ?? uuid.v4();

  static int viewBy = 1;

  final String id;
  String? fileUrl;
  String fileName;
  final String courseName;
  final String noteType;
  final DateTime date;
  final String memo;

  static void noteDelete(String id){
    notes.value.remove(id);
    noteByDate.value.remove(id);
    noteByCourseName.value.remove(id);
    noteByNoteType.value.remove(id);
    noteByFileName.value.remove(id);
  }

  void noteInsert() {
    notes.value[id] = this;
    noteByDateInsert(this);
    noteByCourseNameInsert(this);
    noteByNoteTypeInsert(this);
    noteByFileNameInsert(this);
  }

  void noteByDateInsert(Note newNote) {

    Note tmpNote;
    for (int i = 0; i < noteByDate.value.length; i++) {
      tmpNote = notes.value[noteByDate.value[i]]!;
      if (compareByDate(newNote, tmpNote)) {
        noteByDate.value.insert(i, newNote.id);
        return;
      }
    }
    noteByDate.value.add(newNote.id);
    return;
  }

  void noteByCourseNameInsert(Note newNote) {

    Note tmpNote;
    for (int i = 0; i < noteByCourseName.value.length; i++) {
      tmpNote = notes.value[noteByCourseName.value[i]]!;
      if (compareByCourseName(newNote, tmpNote)) {
        noteByCourseName.value.insert(i, newNote.id);
        return;
      }
    }
    noteByCourseName.value.add(newNote.id);
    return;
  }

  void noteByNoteTypeInsert(Note newNote) {

    Note tmpNote;
    for (int i = 0; i < noteByNoteType.value.length; i++) {
      tmpNote = notes.value[noteByNoteType.value[i]]!;
      if (compareBynoteType(newNote, tmpNote)) {
        noteByNoteType.value.insert(i, newNote.id);
        return;
      }
    }
    noteByNoteType.value.add(newNote.id);
    return;
  }

  void noteByFileNameInsert(Note newNote) {

    Note tmpNote;
    for (int i = 0; i < noteByFileName.value.length; i++) {
      tmpNote = notes.value[noteByFileName.value[i]]!;
      if (compareByfileName(newNote, tmpNote)) {
        noteByFileName.value.insert(i, newNote.id);
        return;
      }
    }
    noteByFileName.value.add(newNote.id);
    return;
  }

  bool compareByDate(Note note1, Note note2)
      =>
      (note1.date.toIso8601String().compareTo(note2.date.toIso8601String()) >
          0);

  bool compareByCourseName(Note note1, Note note2)
      =>
      (note1.courseName.compareTo(note2.courseName) == 0);

  bool compareBynoteType(Note note1, Note note2)
      =>
      (note1.noteType.compareTo(note2.noteType) == 0);

  bool compareByfileName(Note note1, Note note2)
      =>
      (note1.fileName.compareTo(note2.fileName) < 0);

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'courseName': courseName,
      'noteType': noteType,
      'date': date.toIso8601String(),
      'memo': memo,
      'url': fileUrl,
      'id': id,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      fileName: map['fileName'],
      courseName: map['courseName'],
      noteType: map['noteType'],
      date: DateTime.parse(map['date']),
      memo: map['memo'],
      fileUrl: map['url'],
      curId: map['id'],
    );
  }

  static void cleanNote() {
    notes.value.clear();
    noteByDate.value.clear();
    noteByCourseName.value.clear();
    noteByNoteType.value.clear();
    noteByFileName.value.clear();
  }
}
