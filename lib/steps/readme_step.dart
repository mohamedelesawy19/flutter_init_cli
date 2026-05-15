import 'package:path/path.dart' as p;
import '../init_context.dart';
import '../init_step.dart';
import '../utils/file_writer.dart';

class ReadmeStep implements InitStep {
  @override
  String get name => 'Generating README.md';

  @override
  Future<void> run(InitContext context) async {
    await FileWriter.write(
      p.join(context.projectPath, 'README.md'),
      _buildContent(context),
      overwrite: true,
    );
  }

  static String _buildContent(InitContext context) {
    return '''
<div align="center">

<img src="assets/images/logo.png" alt="${context.projectName} Logo" width="120" />

<br/>

# ${context.projectName}

**A short, punchy one-liner describing what your app does.**

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
${_smBadge(context.stateManagement)}
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Google Play](https://img.shields.io/badge/Google_Play-Available_Now-green?logo=googleplay&logoColor=white)](https://play.google.com/store/apps/details?id=com.example.your_app_id)
[![App Store](https://img.shields.io/badge/App_Store-Available_Now-black?logo=apple&logoColor=white)](https://apps.apple.com/us/app/your-app-name/idYOUR_APP_ID)

<br/>

[Features](#-features) · [Screenshots](#-screenshots) · [Getting Started](#-getting-started) · [Architecture](#-architecture) · [Contributing](#-contributing) · [License](#-license)

</div>

---

## 📖 Overview

> Provide 2–4 sentences that explain **what** the app does, **who** it is for, and **why** it matters.

```
Example:
${context.projectName} helps users accomplish X effortlessly.
Built with Flutter, it runs natively on iOS, Android, Web, and Desktop from a single
codebase, using ${_smDisplayName(context.stateManagement)} for state management.
```

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Auth** | Email / password, Google, and Apple sign-in |
| 🌍 **Localization** | Supports EN, AR, FR out of the box |
| 🌙 **Dark Mode** | Fully adaptive light & dark theming |
| 📡 **Offline First** | Local caching with automatic background sync |
| 🔔 **Push Notifications** | Firebase Cloud Messaging integration |
| 📊 **Analytics** | Event tracking with Firebase Analytics |

---

## 📸 Screenshots

<div align="center">
<table>
  <tr>
    <td align="center"><strong>Onboarding</strong></td>
    <td align="center"><strong>Home</strong></td>
    <td align="center"><strong>Detail</strong></td>
    <td align="center"><strong>Settings</strong></td>
  </tr>
  <tr>
    <td><img src="docs/screenshots/onboarding.png" width="180"/></td>
    <td><img src="docs/screenshots/home.png" width="180"/></td>
    <td><img src="docs/screenshots/detail.png" width="180"/></td>
    <td><img src="docs/screenshots/settings.png" width="180"/></td>
  </tr>
</table>
</div>

---

## 🚀 Getting Started

### Prerequisites

| Tool | Version | Notes |
|---|---|---|
| [Flutter SDK](https://docs.flutter.dev/get-started/install) | `≥ 3.x` | Stable channel |
| [Dart SDK](https://dart.dev/get-dart) | `≥ 3.x` | Bundled with Flutter |
| [Xcode](https://developer.apple.com/xcode/) | `≥ 15` | macOS / iOS only |
| [Android Studio](https://developer.android.com/studio) | Latest | Android builds |
| [Firebase CLI](https://firebase.google.com/docs/cli) | Latest | If using Firebase |

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-org/${context.projectName}.git
cd ${context.projectName}

# 2. Install dependencies
flutter pub get

# 3. Set up environment variables
cp .env.example .env
# → Fill in the required values inside .env

# 4. Generate code (if using build_runner)
dart run build_runner build --delete-conflicting-outputs

# 5. Run the app
flutter run
```

### Environment Configuration

Create a `.env` file at the project root (never commit this file):

```env
API_BASE_URL=https://api.example.com
API_KEY=your_api_key_here
FIREBASE_PROJECT_ID=your_project_id
```

### Running on Specific Platforms

```bash
flutter run -d ios          # iOS Simulator
flutter run -d android      # Android Emulator
flutter run -d chrome       # Web (Chrome)
flutter run -d macos        # macOS Desktop
flutter run -d windows      # Windows Desktop
flutter run -d linux        # Linux Desktop
```

---

## 🏗 Architecture

${_architectureSection(context.stateManagement)}

---

## 🧪 Testing

```bash
# Unit & widget tests
flutter test

# Integration tests
flutter test integration_test/

# Test coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

The project targets **≥ 80% code coverage** on domain and data layers.

---

## 🔧 Scripts & Tooling

```bash
# Lint & format
flutter analyze
dart format .

# Build APK (release)
flutter build apk --release

# Build iOS (release)
flutter build ipa --release

# Build Web
flutter build web --release

# Regenerate mocks / freezed / json_serializable
dart run build_runner watch --delete-conflicting-outputs

# Localization
flutter gen-l10n
```

---

## 📦 Key Dependencies

${_dependenciesSection(context.stateManagement)}

> See [`pubspec.yaml`](pubspec.yaml) for the complete list.

---

## 🌿 Branching Strategy

```
main          ← Production-ready, protected
develop       ← Integration branch
feature/*     ← New features  (e.g. feature/user-profile)
fix/*         ← Bug fixes     (e.g. fix/login-crash)
chore/*       ← Maintenance   (e.g. chore/upgrade-deps)
release/*     ← Release prep  (e.g. release/1.2.0)
```

---

## 🤝 Contributing

Contributions are welcome! Please read the guidelines before submitting a PR.

1. **Fork** the repository and create your branch from `develop`.
2. **Follow** the existing code style (`dart format` + `flutter analyze` must pass).
3. **Write tests** for any new functionality.
4. **Update** documentation and the `CHANGELOG.md` where relevant.
5. **Open a Pull Request** against `develop` with a clear description.

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for full details.

---

## 🗺 Roadmap

- [ ] Apple Watch companion app
- [ ] Widget support (iOS & Android)
- [ ] Offline-first sync with conflict resolution
- [ ] Biometric authentication
- [ ] Export to PDF / CSV

---

## 🔒 Security

If you discover a security vulnerability, please **do not** open a public issue.
Email us at **security@example.com** and we will respond within 48 hours.

See [`SECURITY.md`](SECURITY.md) for our full disclosure policy.

---

## 📄 License

```
MIT License — Copyright (c) ${DateTime.now().year} Your Name / Organization
```

See the full [`LICENSE`](LICENSE) file for details.

---

## 🙏 Acknowledgements

- [Flutter](https://flutter.dev) — the framework that makes this possible.
${_smAcknowledgement(context.stateManagement)}
- All open-source contributors listed in [`pubspec.yaml`](pubspec.yaml).

---

<div align="center">

Made with ❤️ and [Flutter](https://flutter.dev)

<br/>

[![Email](https://img.shields.io/badge/Gmail-your--email%40gmail.com-EA4335?style=flat&logo=gmail&logoColor=white)](mailto:your-email@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/your-account)

</div>
''';
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  static String _smDisplayName(String sm) => switch (sm) {
    'bloc' => 'BLoC',
    'riverpod' => 'Riverpod',
    'provider' => 'Provider',
    'getx' => 'GetX',
    'cubit' => 'Cubit',
    _ => sm,
  };

  static String _smBadge(String sm) => switch (sm) {
    'bloc' || 'cubit' =>
      '[![BLoC](https://img.shields.io/badge/State-BLoC-blueviolet)](https://bloclibrary.dev)',
    'riverpod' =>
      '[![Riverpod](https://img.shields.io/badge/State-Riverpod-009688)](https://riverpod.dev)',
    'provider' =>
      '[![Provider](https://img.shields.io/badge/State-Provider-1976D2)](https://pub.dev/packages/provider)',
    'getx' =>
      '[![GetX](https://img.shields.io/badge/State-GetX-9C27B0)](https://pub.dev/packages/get)',
    _ =>
      '[![State](https://img.shields.io/badge/State-$sm-grey)](https://pub.dev)',
  };

  static String _architectureSection(String sm) => switch (sm) {
    'bloc' || 'cubit' => _blocArchitecture(sm),
    'riverpod' => _riverpodArchitecture(),
    'provider' => _providerArchitecture(),
    'getx' => _getxArchitecture(),
    _ => _genericArchitecture(sm),
  };

  static String _blocArchitecture(String sm) {
    final layer = sm == 'cubit' ? 'Cubit' : 'Bloc';
    return '''This project follows **Clean Architecture** with a **feature-first** folder structure,
using [flutter_bloc](https://bloclibrary.dev/) for state management.

```
lib/
├── core/                   # App-wide utilities & shared code
│   ├── constants/          # Colors, text styles, dimensions
│   ├── errors/             # Failure types & error handling
│   ├── extensions/         # Dart extension methods
│   ├── network/            # Dio client, interceptors
│   ├── router/             # GoRouter configuration
│   └── theme/              # Light & dark ThemeData
│
├── features/               # One folder per feature
│   └── auth/
│       ├── data/           # Remote & local data sources, models
│       ├── domain/         # Entities, repository interfaces, use cases
│       └── presentation/
│           ├── screens/
│           ├── widgets/
│           └── $sm/      # ${layer}s + States
│
└── main.dart
```

### State Management — $layer

| Concept | Role |
|---|---|
| `$layer` | Business logic & state transitions |
| `${layer}State` | Immutable state sealed classes |
| `${layer}Event` | User-triggered events${sm == 'cubit' ? ' (method calls instead of events)' : ''} |
| `BlocProvider` | Injects the `$layer` into the widget tree |
| `BlocBuilder` | Rebuilds UI on state change |
| `BlocListener` | Side-effects (navigation, dialogs) |

```dart
// Example $layer
class Auth$layer extends $layer<${sm == 'cubit' ? 'AuthState' : 'AuthEvent, AuthState'}> {
  Auth$layer(this._authRepo) : super(AuthInitial());

  final AuthRepository _authRepo;

${sm == 'cubit' ? '''  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final result = await _authRepo.signIn(email, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user)    => emit(AuthSuccess(user)),
    );
  }''' : '''  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInRequested) {
      yield AuthLoading();
      final result = await _authRepo.signIn(event.email, event.password);
      yield result.fold(
        (failure) => AuthFailure(failure.message),
        (user)    => AuthSuccess(user),
      );
    }
  }'''}
}
```

| Layer | Tool |
|---|---|
| UI State | [flutter_bloc](https://pub.dev/packages/flutter_bloc) `$layer` |
| Navigation | [GoRouter](https://pub.dev/packages/go_router) |
| Local Storage | [Hive](https://pub.dev/packages/hive) / [Isar](https://isar.dev) |
| Remote Data | [Dio](https://pub.dev/packages/dio) + Repository pattern |''';
  }

  static String _riverpodArchitecture() =>
      '''This project follows **Clean Architecture** with a **feature-first** folder structure,
using [Riverpod](https://riverpod.dev/) for state management.

```
lib/
├── core/                   # App-wide utilities & shared code
│   ├── constants/          # Colors, text styles, dimensions
│   ├── errors/             # Failure types & error handling
│   ├── extensions/         # Dart extension methods
│   ├── network/            # Dio client, interceptors
│   ├── router/             # GoRouter configuration
│   └── theme/              # Light & dark ThemeData
│
├── features/               # One folder per feature
│   └── auth/
│       ├── data/           # Remote & local data sources, models
│       ├── domain/         # Entities, repository interfaces, use cases
│       └── presentation/
│           ├── screens/
│           ├── widgets/
│           └── providers/  # Riverpod providers & notifiers
│
└── main.dart
```

### State Management — Riverpod

| Concept | Role |
|---|---|
| `Provider` | Exposes read-only values / services |
| `AsyncNotifierProvider` | Async state with loading / error / data |
| `NotifierProvider` | Synchronous mutable state |
| `FutureProvider` | One-shot async data |
| `StreamProvider` | Real-time streams |

```dart
// Example AsyncNotifier
@riverpod
class AuthNotifier extends _\$AuthNotifier {
  @override
  FutureOr<User?> build() => null;

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signIn(email, password),
    );
  }
}
```

| Layer | Tool |
|---|---|
| UI State | [Riverpod](https://riverpod.dev/) `AsyncNotifier` |
| Navigation | [GoRouter](https://pub.dev/packages/go_router) |
| Local Storage | [Hive](https://pub.dev/packages/hive) / [Isar](https://isar.dev) |
| Remote Data | [Dio](https://pub.dev/packages/dio) + Repository pattern |''';

  static String _providerArchitecture() =>
      '''This project follows **Clean Architecture** with a **feature-first** folder structure,
using [Provider](https://pub.dev/packages/provider) for state management.

```
lib/
├── core/                   # App-wide utilities & shared code
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── router/
│   └── theme/
│
├── features/
│   └── auth/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── screens/
│           ├── widgets/
│           └── providers/  # ChangeNotifiers
│
└── main.dart
```

### State Management — Provider

| Concept | Role |
|---|---|
| `ChangeNotifier` | Mutable state class, calls `notifyListeners()` |
| `ChangeNotifierProvider` | Injects a `ChangeNotifier` into the tree |
| `Consumer<T>` | Rebuilds the subtree on change |
| `Selector<T, S>` | Rebuilds only when `S` changes (performance) |
| `context.read<T>()` | One-off read without listening |
| `context.watch<T>()` | Listens and triggers rebuild |

```dart
// Example ChangeNotifier
class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _loading = false;
  String? _error;

  User?   get user    => _user;
  bool    get loading => _loading;
  String? get error   => _error;

  Future<void> signIn(String email, String password) async {
    _loading = true; _error = null; notifyListeners();
    try {
      _user = await _authRepo.signIn(email, password);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}
```

| Layer | Tool |
|---|---|
| UI State | [Provider](https://pub.dev/packages/provider) `ChangeNotifier` |
| Navigation | [GoRouter](https://pub.dev/packages/go_router) |
| Local Storage | [Hive](https://pub.dev/packages/hive) |
| Remote Data | [Dio](https://pub.dev/packages/dio) + Repository pattern |''';

  static String _getxArchitecture() =>
      '''This project follows a **feature-first** folder structure,
using [GetX](https://pub.dev/packages/get) for state management, routing, and dependency injection.

```
lib/
├── core/                   # App-wide utilities & shared code
│   ├── constants/
│   ├── errors/
│   ├── network/            # Dio / GetConnect client
│   ├── bindings/           # Global GetX bindings
│   └── theme/
│
├── features/
│   └── auth/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── screens/
│           ├── widgets/
│           ├── controllers/ # GetxControllers
│           └── bindings/    # Feature-level bindings
│
└── main.dart
```

### State Management — GetX

| Concept | Role |
|---|---|
| `GetxController` | Business logic + lifecycle hooks |
| `Rx<T>` / `.obs` | Observable reactive variables |
| `Obx(()=> ...)` | Rebuilds only when observables change |
| `GetBuilder<T>` | Manual `update()` triggered rebuilds |
| `Binding` | Lazy dependency injection per route |
| `Get.put` / `Get.find` | Register / retrieve controller instances |

```dart
// Example GetxController
class AuthController extends GetxController {
  final _user    = Rxn<User>();
  final _loading = false.obs;

  User?   get user    => _user.value;
  bool    get loading => _loading.value;

  Future<void> signIn(String email, String password) async {
    _loading.value = true;
    try {
      _user.value = await _authRepo.signIn(email, password);
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _loading.value = false;
    }
  }
}
```

| Layer | Tool |
|---|---|
| UI State | [GetX](https://pub.dev/packages/get) `GetxController` + `Rx` |
| Navigation | GetX named routes + `Binding` |
| Local Storage | [GetStorage](https://pub.dev/packages/get_storage) / [Hive](https://pub.dev/packages/hive) |
| Remote Data | [Dio](https://pub.dev/packages/dio) + Repository pattern |''';

  static String _genericArchitecture(String sm) =>
      '''This project follows **Clean Architecture** with a **feature-first** folder structure,
using **${_smDisplayName(sm)}** for state management.

```
lib/
├── core/
├── features/
│   └── <feature>/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

| Layer | Tool |
|---|---|
| UI State | ${_smDisplayName(sm)} |
| Navigation | [GoRouter](https://pub.dev/packages/go_router) |
| Local Storage | [Hive](https://pub.dev/packages/hive) |
| Remote Data | [Dio](https://pub.dev/packages/dio) + Repository pattern |''';

  // ── Dependencies table ────────────────────────────────────────────────────

  static String _dependenciesSection(String sm) {
    final smRow = switch (sm) {
      'bloc' =>
        '| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | BLoC state management |\n'
            '| [`bloc`](https://pub.dev/packages/bloc) | Core BLoC library |',
      'cubit' =>
        '| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Cubit state management |',
      'riverpod' =>
        '| [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | State management |\n'
            '| [`riverpod_annotation`](https://pub.dev/packages/riverpod_annotation) | Code-gen annotations |',
      'provider' =>
        '| [`provider`](https://pub.dev/packages/provider) | State management |',
      'getx' =>
        '| [`get`](https://pub.dev/packages/get) | State management, routing & DI |',
      _ => '| `$sm` | State management |',
    };

    return '''| Package | Purpose |
|---|---|
$smRow
| [`go_router`](https://pub.dev/packages/go_router) | Declarative routing |
| [`dio`](https://pub.dev/packages/dio) | HTTP client |
| [`freezed`](https://pub.dev/packages/freezed) | Immutable data classes |
| [`hive_flutter`](https://pub.dev/packages/hive_flutter) | Local key-value storage |
| [`flutter_localizations`](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization) | i18n support |
| [`mocktail`](https://pub.dev/packages/mocktail) | Mocking for tests |''';
  }

  // ── Acknowledgements ──────────────────────────────────────────────────────

  static String _smAcknowledgement(String sm) => switch (sm) {
    'bloc' || 'cubit' =>
      '- [flutter_bloc](https://bloclibrary.dev) — by [Felix Angelov](https://github.com/felangel).',
    'riverpod' =>
      '- [Riverpod](https://riverpod.dev) — by [Remi Rousselet](https://github.com/rrousselGit).',
    'provider' =>
      '- [Provider](https://pub.dev/packages/provider) — by [Remi Rousselet](https://github.com/rrousselGit).',
    'getx' =>
      '- [GetX](https://pub.dev/packages/get) — by [Jonny Borges](https://github.com/jonataslaw).',
    _ =>
      '- ${_smDisplayName(sm)} — the state management solution powering this app.',
  };
}
