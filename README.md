# Web Summarist 🌐✨

A Flutter application that allows users to summarize web URLs and manage a list of recently accessed
links. The project follows **Clean Architecture** principles and leverages **Riverpod** for state
management.

---

## 📌 Features

- **URL Summary:** Submit a URL and get a summarized version of the webpage content.
  ⚠️ **Note:** Currently uses mock data; real summary functionality is not yet implemented.
- **Recently Viewed URLs:** Automatically saves successfully summarized URLs for quick access.
- **Manage URLs:** View all saved URLs and delete any unwanted ones.
- **Instant Updates:** Changes in saved URLs reflect immediately without restarting the app.
- **Undo Delete:** Undo a deletion of a URL for better user experience.
- **Elegant UI:** Clean, responsive, and user-friendly interface.
- **Localization Support:** Multilingual support using Flutter's `gen-l10n` package.

---

## 🛠 Technologies & Packages Used

- **Flutter & Dart**
- **Riverpod** for state management
- **SharedPreferences** for local storage
- **GoRouter** for navigation
- **Flutter Gen L10n** for localization
- **Clean Architecture** principles

---

Clean Architecture:

Presentation Layer: Widgets, Pages, StateNotifiers (ViewModels)

Domain Layer: Business logic, enums, use cases

Data Layer: Repositories, API integration

## ⚙️ Prerequisites / Environment Setup

- Flutter SDK: >= 3.0.0
- Dart SDK: >= 3.0.0
- Any IDE with Flutter support (VS Code, Android Studio, etc.)

## 🧩 Quick Start

```bash
git clone 
cd web_summarist
flutter pub get
flutter run
```

## 💡 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Open a Pull Request

🙋‍♂️ Author
Fatemeh Azimi
GitHub: https://github.com/fatemehsazimi