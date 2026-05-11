import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:software_studio_project/model/model_log_in_method.dart';
import 'package:software_studio_project/model/model_user.dart' as models;
import 'package:software_studio_project/repositories/user_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:software_studio_project/global.dart';

class AuthenticationService {
  final UserRepository _userRepository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationService({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository();

  Future<String?> signUp(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required XFile avatarFile}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      String userId = userCredential.user!.uid;
      _postSignUp(
        userId: userId,
        email: email,
        name: name,
        avatarFile: avatarFile,
        logInMethods: [LogInMethod.emailAndPassword],
      );
      debugPrint('New email account created');

      return userId;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final existingUserDoc = await _userRepository.getUserByEmail(email);
        if (existingUserDoc == null) {
          throw Exception('Email already in use but no user doc found');
        }

        if (existingUserDoc.logInMethods
            .contains(LogInMethod.emailAndPassword)) {
          if (context.mounted) {
            await _promptLogInInstead(context);
          }
          return null;
        } else if (existingUserDoc.logInMethods.contains(LogInMethod.google)) {

          final googleSignIn = GoogleSignIn();
          GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
          if (googleUser == null && context.mounted) {

            bool shouldProceed = await _promptLinkEmailToGoogle(context);
            if (!shouldProceed) {
              return null;
            }
            googleUser = await googleSignIn.signIn();
          }

          if (googleUser == null) return null;

          final googleAuth = await googleUser.authentication;
          final googleCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final user =
              (await _firebaseAuth.signInWithCredential(googleCredential))
                  .user!;

          if (user.email == email) {

            final emailCredential = EmailAuthProvider.credential(
              email: email,
              password: password,
            );
            await user.linkWithCredential(emailCredential);
            debugPrint(
                'Email account linked to existing Google account: $email');

            _postSignUp(
              userId: user.uid,
              email: email,
              name: name,
              avatarFile: avatarFile,
              logInMethods: [
                LogInMethod.google,
                LogInMethod.emailAndPassword,
              ],
            );

            return user.uid;
          } else {
            throw Exception(
                'Email does not match Google account email while linking');
          }
        } else {
          throw Exception('Email already in use but no log in method found');
        }
      } else {
        throw Exception('${e.code}: ${e.message}');
      }
    }
  }

  Future<void> _postSignUp({
    required String userId,
    required String email,
    required name,
    String? avatarUrl,
    XFile? avatarFile,
    required List<LogInMethod> logInMethods,
  }) async {
    if (avatarFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('apps')
          .child('group_chat')
          .child('user_avatars')
          .child('$userId.jpg');
      if (kIsWeb) {
        await storageRef.putData(await avatarFile.readAsBytes());
      } else {
        await storageRef.putFile(File(avatarFile.path));
      }
      avatarUrl = await storageRef.getDownloadURL();
    }

    await _userRepository.createOrUpdateUser(models.User(
      id: userId,
      email: email,
      name: name,
      avatarUrl: avatarUrl!,
      logInMethods: logInMethods,
    ));
  }

  Future<void> _promptLogInInstead(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email already in use'),
          content: const Text(
            'The email address you provided is already in use. Please log in instead.',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _promptLinkEmailToGoogle(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Email already in use'),
              content: const Text(
                'The email address you provided is already in use. This may be due to an existing Google account using the same email address. Press Cancel to use another email address, or Proceed to log in with the Google account and link it with your password.',
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Proceed'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<String> logIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _postLogIn(userCredential.user!);

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception('${e.code}: ${e.message}');
    }
  }

  Future<void> _postLogIn(User user) async {

    IdTokenResult idTokenResult = await user.getIdTokenResult(true);

    final isModerator = idTokenResult.claims?['isModerator'] ?? false;
    debugPrint('Logged in with state: isModerator=$isModerator');
  }

  Future<String?> logInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final googleEmail = googleUser.email;
      final existingUserDoc = await _userRepository.getUserByEmail(googleEmail);

      if (!context.mounted) return null;

      late User user;
      if (existingUserDoc == null) {

        user =
            (await _firebaseAuth.signInWithCredential(googleCredential)).user!;

        userId = user.uid;
        userEmail = googleEmail;
        userName = googleUser.displayName ?? googleEmail.split('@').first;
        userAvatarUrl =
            googleUser.photoUrl ?? 'https://via.placeholder.com/150';

        print(user.uid);

        _postSignUp(
          userId: user.uid,
          email: googleEmail,
          name: googleUser.displayName ?? googleEmail.split('@').first,
          avatarUrl: googleUser.photoUrl ?? 'https://via.placeholder.com/150',
          logInMethods: [LogInMethod.google],
        );
        debugPrint('New Google account created');
      } else {
        if (!existingUserDoc.logInMethods.contains(LogInMethod.google)) {

          final password = await _promptLinkGoogleToEmail(context, googleEmail);
          if (password == null) {
            return null;
          }

          user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: googleEmail,
            password: password,
          ))
              .user!;

          await user.linkWithCredential(googleCredential);
          debugPrint(
              'Google account linked to existing email account: $googleEmail');

          userId = user.uid;
          userEmail = googleEmail;
          userName = googleUser.displayName ?? googleEmail.split('@').first;
          userAvatarUrl =
              googleUser.photoUrl ?? 'https://via.placeholder.com/150';

          print(user.uid);

          _postSignUp(
            userId: user.uid,
            email: googleEmail,
            name: existingUserDoc.name,
            avatarUrl: existingUserDoc.avatarUrl,
            logInMethods: [LogInMethod.emailAndPassword, LogInMethod.google],
          );
        } else {

          user = (await _firebaseAuth.signInWithCredential(googleCredential))
              .user!;

          userId = user.uid;
          userEmail = googleEmail;
          userName = googleUser.displayName ?? googleEmail.split('@').first;
          userAvatarUrl =
              googleUser.photoUrl ?? 'https://via.placeholder.com/150';

          print(user.uid);
        }
      }

      _postLogIn(user);

      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception('${e.code}: ${e.message}');
    }
  }

  Future<String?> _promptLinkGoogleToEmail(
      BuildContext context, String email) async {
    TextEditingController passwordController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email already in use'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium!,
                  children: [
                    const TextSpan(
                        text: 'The email address of your Google account:\n\n'),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                        text:
                            '\n\nhas already been used by an email account. To proceed, please log into the email account to link it with this Google account.'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    print("Signout Successfully.");
  }

  String? checkAndGetLoggedInUserId() {
    User? user = _firebaseAuth.currentUser;
    if (user == null) return null;

    user.reload();
    return _firebaseAuth.currentUser?.uid;
  }

  Stream<bool> authStateChanges() {
    return _firebaseAuth.idTokenChanges().map((user) => user != null);
  }
}
