# Flutter Company Listing App

A Flutter application that demonstrates **Firebase Authentication, API integration, pagination (infinite scrolling), and clean architecture using Provider state management**.

This project was created as part of an assignment to implement authentication, session management, and API-based data display.

---

## Features

### Authentication

* Firebase Email & Password login
* Form validation
* Session management using Hive
* Auto-login if user session exists
* Logout with confirmation popup

### Home Screen

* Fetch company list from API
* Infinite scrolling (pagination)
* Pull-to-refresh
* Loading indicator
* Shimmer skeleton loading
* Error handling with retry button
* Empty state handling

### Details Screen

* Displays company information
* Shows logo and company details
* Handles image loading errors

---

## Architecture

The project follows **Clean Architecture** structure.

```
lib
│
├── core
│   ├── network
│   │   └── api_service.dart
│   └── utils
│       └── app_loader.dart
│
├── data
│   └── repositories
│       ├── auth_repository_impl.dart
│       └── company_repository_impl.dart
│
├── domain
│   ├── entities
│   │   └── company.dart
│   └── repositories
│       ├── auth_repository.dart
│       └── company_repository.dart
│
├── presentation
│   ├── providers
│   │   ├── auth_provider.dart
│   │   └── company_provider.dart
│   │
│   ├── screens
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   └── details_screen.dart
│   │
│   └── widgets
│       ├── company_tile.dart
│       └── company_shimmer.dart
│
└── main.dart
```

---

## API Used

### Companies List API

```
https://fake-json-api.mock.beeceptor.com/companies
```

### Company Details API

```
https://fake-json-api.mock.beeceptor.com/companies/{id}
```

Networking is implemented using **Dio**.

---

## Tech Stack

* Flutter
* Dart
* Firebase Authentication
* Provider (State Management)
* Dio (Networking)
* Hive (Local Storage)
* Shimmer (Skeleton loading UI)

---

## Installation

Clone the repository

```
git clone https://github.com/YOUR_GITHUB_USERNAME/flutter-company-app.git
```

Go to project directory

```
cd flutter-company-app
```

Install dependencies

```
flutter pub get
```

Run the application

```
flutter run
```

---

## Screenshots

### Login Screen

![Login](screenshots/login.png)

### Companies List

![Home](screenshots/home.png)

### Company Details

![Details](screenshots/details.png)

---

## APK Download

APK file is available in the **Releases section** of this repository.

---

## Author

Developed by **Urvashi Jain**

Flutter Developer
