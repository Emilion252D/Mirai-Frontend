# Mirai App — Flutter

Beauty-tech приложение для 3D-примерки образов.

## 🚀 Запуск в VS Code

### 1. Установи Flutter
```bash
# macOS
brew install --cask flutter

# Windows — скачай с flutter.dev/docs/get-started/install/windows
```

### 2. Установи расширения VS Code
- **Dart** (Dart-Code.dart-code)
- **Flutter** (Dart-Code.flutter)

### 3. Открой проект
```bash
# В VS Code: File → Open Folder → выбери папку mirai_app
code .
```

### 4. Установи зависимости
```bash
flutter pub get
```

### 5. Запусти
```bash
# Запуск на Android эмуляторе / устройстве
flutter run

# Запуск в Chrome (веб)
flutter run -d chrome

# Запуск через VS Code: нажми F5 или Run → Start Debugging
```

---

## 📁 Структура проекта

```
mirai_app/
├── lib/
│   ├── main.dart                    # Точка входа
│   ├── theme/
│   │   └── mirai_theme.dart         # Цвета, шрифты, тема
│   ├── screens/
│   │   └── home_screen.dart         # 🏠 Главная страница
│   └── widgets/
│       ├── mirai_bottom_nav.dart    # Нижняя навигация
│       └── mirai_drawer.dart        # Боковое меню
├── .vscode/
│   ├── launch.json                  # Конфигурация запуска
│   └── settings.json                # Настройки VS Code
└── pubspec.yaml                     # Зависимости
```

---

## 🎨 Цветовая схема Mirai

| Название     | HEX       | Использование           |
|-------------|-----------|-------------------------|
| Violet      | #6C47C4   | Основной акцент, кнопки |
| Violet Light| #F0EDF8   | Фон карточек, иконок    |
| Violet Mid  | #DDD6F5   | Бордеры, разделители    |
| Violet Dark | #1A1430   | Тёмный фон, редактор    |
| BG          | #F7F5FC   | Фон страниц             |

---

## 📱 Экраны (в разработке)

- [x] **HomeScreen** — Главная (без модели / с кнопкой добавления)
- [ ] **EditorScreen** — Редактор 3D-образа
- [ ] **CatalogScreen** — Каталог стилей
- [ ] **RatingScreen** — Рейтинг образов
- [ ] **HistoryScreen** — История дизайнов
- [ ] **SettingsScreen** — Настройки
- [ ] **OnboardingScreen** — Онбординг

---

## 🔧 Используемые пакеты

| Пакет          | Версия | Назначение              |
|----------------|--------|-------------------------|
| google_fonts   | ^6.1.0 | Шрифт Inter             |
| flutter_svg    | ^2.0.9 | SVG-иконки              |
