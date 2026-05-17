<div align="center">

# Flutter Init CLI

**A powerful Dart CLI to bootstrap production-ready Flutter projects with clean architecture and best practices.**

<br/>

[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/Flutter-Supported-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![CLI](https://img.shields.io/badge/Platform-CLI-black?logo=gnubash&logoColor=white)](https://dart.dev/tools/dart-tool)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

<br/>

[Overview](#-overview) •
[Features](#-features) •
[Installation](#-installation) •
[Usage](#-usage) •
[Configuration](#-what-the-cli-configures) •
[Example](#-example-workflow) •
[Project Structure](#-project-structure) •
[Contributing](#-contributing)

</div>

---

# 📖 Overview

`flutter_init_cli` is a Dart CLI tool that standardizes setup for existing Flutter projects.

Instead of manually configuring every project after `flutter create`, the CLI applies a consistent baseline with:

- Rewritten `pubspec.yaml` with curated dependencies
- Strict `analysis_options.yaml`
- A ready-to-edit README template
- Built-in localization setup (English & Arabic)
- Pre-configured Material 3 Theme (Colors, Text Theme, and Theme Data)

The goal is to eliminate repetitive setup work and standardize Flutter project configuration across teams and personal projects.

> **Note:** This CLI expects a Flutter project directory (a folder that already contains `pubspec.yaml`).
> It overwrites `pubspec.yaml`, `analysis_options.yaml`, and `README.md`.

---

# ✨ Features

| Feature | Description |
|---|---|
| 🏗 Opinionated Setup | Applies a curated dependency and tooling baseline |
| 📦 Pubspec Setup | Rewrites `pubspec.yaml` using the latest versions from pub.dev |
| 🔧 State Management | Adds `bloc` or `riverpod` dependencies based on `--state` |
| 📏 Lint Rules | Generates a strict `analysis_options.yaml` on top of `flutter_lints` |
| 🌍 Localization | Initializes `l10n` support with English and Arabic ARB files |
| 🎨 Theme | Generates a complete Material 3 theme (Colors, TextTheme, AppTheme) |
| 📍 Routing | Sets up `go_router` with a scalable routing structure |
| 📄 README Generator | Creates a clean, editable `README.md` template |
| 🧹 Safe Validation | Stops if `pubspec.yaml` is missing |
| ⚡ Fast Setup | Runs in seconds |
| 🖥 Pure Dart CLI | Lightweight and fast without Flutter runtime dependency |

---

# 🚀 Installation

## Activate Globally

```bash
dart pub global activate flutter_init_cli
```

## Run the CLI

```bash
flutter_init_cli --help
```

## Or Run From Source

```bash
dart run bin/flutter_init_cli.dart --help
```

---

# ⚙️ Usage

## Initialize the Current Flutter Project

```bash
flutter_init_cli
```

## Initialize a Project by Path

```bash
flutter_init_cli --path ./my_app
```

## Choose State Management (bloc | riverpod)

```bash
flutter_init_cli --path ./my_app --state riverpod
```

## Show Help

```bash
flutter_init_cli --help
```

---

# 🛠 What The CLI Configures

After running the CLI, it automatically:

* Rewrites `pubspec.yaml` with curated dependencies and latest versions from pub.dev
* Generates a strict `analysis_options.yaml` based on `flutter_lints`
* Replaces the project `README.md` with a ready-to-edit template
* Generates a comprehensive Material 3 theme system (AppColors, AppTextTheme, and AppTheme)
* Configures English and Arabic localization with `l10n.yaml` and `.arb` files
* Sets up a scalable routing system using `go_router` (AppRouter, AppRoutes, and modular route files)
* Requires internet access to fetch dependency versions

---

# 📋 Example Workflow

```bash
# Create project
flutter create ecommerce_app

# Move into project
cd ecommerce_app

# Initialize configuration
flutter_init_cli --state bloc

# Install dependencies
flutter pub get

# Run app
flutter run
```

---

# 🧪 Lint & Analyzer Rules

The CLI applies a strict and clean analyzer configuration focused on:

* Consistent code style
* Safer APIs
* Readability
* Maintainability
* Production-grade standards

---

# 🔧 Tech Stack

| Tool        | Purpose                         |
| ----------- | ------------------------------- |
| Dart CLI    | Command-line interface          |
| YAML Editor | Automatic pubspec modifications |
| Analyzer    | Static analysis & linting       |

---

# 📦 Project Structure

```txt
flutter_init_cli/
├── bin/
│   └── flutter_init_cli.dart
├── lib/
│   ├── services/
│   ├── utils/
│   ├── steps/
│   ├── init_context.dart
│   ├── init_step.dart
│   └── runner.dart
├── pubspec.yaml
└── README.md
```

---

# 🤝 Contributing

Contributions are welcome.

## Development Setup

```bash
git clone https://github.com/mohamedelesawy19/flutter_init_cli.git

cd flutter_init_cli

dart pub get
```

## Run Locally

```bash
dart run bin/flutter_init_cli.dart --path /path/to/your_flutter_app
```

## Analyze

```bash
dart analyze
```

## Format

```bash
dart format .
```

---

# 📄 License

```txt
MIT License © 2026 Mohamed Elesawy
```

---

<div align="center">

Built with ❤️ using Dart & Flutter

<br/>

[![Email](https://img.shields.io/badge/Email-moelesawy19%40gmail.com-EA4335?style=flat&logo=gmail&logoColor=white)](mailto:moelesawy19@gmail.com)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-Chat_Now-25D366?style=flat&logo=whatsapp&logoColor=white)](https://wa.me/201091460933)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mohamed-elesawy-070522257/)

</div>
