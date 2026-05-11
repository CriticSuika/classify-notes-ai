import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:software_studio_project/global.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_studio_project/model/model_note.dart';

class ServiceFileControl {
  List<String> uploadedFiles = [];

  static Future<List> pickAndUploadFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      withData: true,
    );

    List<PlatformFile> files = result!.files;
    return files;
  }

  static Future<void> uploadFile(
      Future<List<dynamic>>? filesFuture, Note newNote) async {
    try {
      List<dynamic>? files =
          await filesFuture;

      if (files != null) {
        for (var file in files) {
          await _uploadFile(file,
              newNote);
        }
      } else {
        throw Exception('Files list is null');
      }
    } catch (e) {
      print('Error uploading files: $e');

    }
  }

  static Future<void> _uploadFile(PlatformFile file, Note newNote) async {
    try {
      if (file.bytes == null) {
        throw Exception('File data is null');
      }

      FirebaseStorage storage = FirebaseStorage.instance;
      newNote.fileName = newNote.fileName + '.' + file.name.split('.').last;
      print("newNote.fileName: ${newNote.fileName}");
      Reference ref =
          storage.ref().child('uploads/$userEmail/${newNote.fileName}');
      await ref.putData(file.bytes!);

      String fileUrl = await getNoteUrl(newNote.fileName);
      newNote.fileUrl = fileUrl;
      print('newNote.fileUrl: ${newNote.fileUrl}');
      addNoteToUser(newNote);
    } catch (e) {
      print('Failed to upload file: $e');
    }
  }

  static Future<String> getNoteUrl(String filename) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url = await storage
        .ref()
        .child('uploads/$userEmail/$filename')
        .getDownloadURL();
    return url;
  }

  static Future<void> openFile(String fileName) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String url = await storage
          .ref()
          .child('uploads/$userEmail/$fileName')
          .getDownloadURL();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Failed to open file: $e');
    }
  }

  static Future<void> getNotesByUser() async {

    Note.cleanNote();
    try {

      CollectionReference notesCollection = FirebaseFirestore.instance
          .collection('apps')
          .doc('notes')
          .collection(userEmail);

      QuerySnapshot snapshot = await notesCollection.get();

      if (snapshot.docs.isEmpty) {
        print('No notes found for user: $userEmail');
        return;
      }

      for (var doc in snapshot.docs) {
        Note noteFromDoc = Note.fromMap(doc.data() as Map<String, dynamic>);
        noteFromDoc.noteInsert();
      }
    } catch (e) {
      print('Error fetching notes: $e');
      throw Exception('Failed to fetch notes');
    }
    return;
  }

  static Future<void> addNoteToUser(Note note) async {
    Map<String, dynamic> noteMap = note.toMap();
    await FirebaseFirestore.instance
        .collection('apps/notes/$userEmail')
        .doc(note.id)
        .set(noteMap);

    note.noteInsert();
  }

  static Future<void> deleteNoteById(String noteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('apps')
          .doc('notes')
          .collection(userEmail)
          .doc(noteId)
          .delete();
      print('Note deleted successfully');
    } catch (e) {
      print('Error deleting note: $e');
      throw Exception('Failed to delete note');
    }
  }
}
