# Notee App

**Notee** is a simple note-taking app built with Flutter. It allows users to sign up, log in, and manage personal notes with full create, read, update, and delete (CRUD) functionality. All data is stored securely in Firebase.

---

## Features

- Sign up and log in using email and password
- Add new notes with a title and body
- View a list of saved notes
- Edit and delete individual notes
- Real-time database updates using Firebase Firestore
- Notes are user-specific and private

---

## Requirements

- Flutter SDK
- Firebase account with Firestore and Authentication enabled
- Android device or emulator

---

## How to Run

1. Clone this repository
2. Run `flutter pub get`
3. Connect your Firebase project (make sure to add `google-services.json` to `android/app`)
4. Use `flutter run` to start the app

---

## Folder Structure

- `main.dart` – Entry point of the app
- `signup.dart` – Handles user registration
- `login.dart` – Handles user login
- `notes.dart` – Displays all saved notes
- `new_note.dart` – Page for creating new notes
- `edit_note.dart` – Page for editing existing notes

---

## Firebase Setup

- Firestore is used to store notes
- Authentication is used to manage user accounts
- Notes are saved with the user's unique ID to ensure privacy

---

## Author

Created by Umugabekazi  
For academic use – July 2025

---


