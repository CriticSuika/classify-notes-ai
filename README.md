# classify-notes-ai

A Flutter app for students to organize academic notes with AI assistance. Combines a weekly course timetable, a multi-view note manager, and a real-time AI chat assistant.

## Features

- **Home** — Weekly calendar with timetable; tap a course slot to pre-fill a new note
- **Notes** — View, sort (by date, course, type, filename), search, open, and delete notes
- **Assist** — Real-time AI chat powered by the OpenAI Assistants API; automatically notified when notes are added or deleted

## Tech Stack

- **Flutter** — Cross-platform UI (Android & Web configured)
- **Firebase Auth** — Google OAuth login
- **Cloud Firestore** — Per-user note storage
- **Firebase Storage** — File uploads (PDF, DOC, DOCX, JPG, PNG)
- **OpenAI Assistants API** — Conversational AI assistant

## Setup

### 1. Clone and install dependencies

```bash
git clone https://github.com/<your-username>/classify-notes-ai.git
cd classify-notes-ai/GPT_app
flutter pub get
```

### 2. Configure Firebase

Install the FlutterFire CLI and run:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates `lib/firebase_options.dart` with your project credentials. This file is excluded from version control via `.gitignore`.

### 3. Add your OpenAI credentials

In `lib/service/service_assistant.dart`, fill in:

```dart
static const String _apiKey = 'YOUR_OPENAI_API_KEY';
static const String _assistantId = 'YOUR_ASSISTANT_ID';
static const String _threadId = 'YOUR_THREAD_ID';
```

In `lib/service/service_chat.dart`, fill in:

```dart
static const String _apiKey = 'YOUR_OPENAI_API_KEY';
```

### 4. Run the app

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── template.dart         # App shell with bottom navigation
├── global.dart           # Global state (ValueNotifiers)
├── model/                # Note, User, Message, Timetable models
├── page/                 # Home, Note, Assist, Add, Login, Profile, Search
├── service/              # Firebase, OpenAI, and file control services
├── repositories/         # Firestore data access
└── widget/               # Reusable widgets
```

## Notes

- `lib/firebase_options.dart` is gitignored — each developer must generate their own via `flutterfire configure`
- OpenAI credentials in the service files must be filled in manually and should never be committed
