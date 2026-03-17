# Sorana OS Context - Niri & Noctalia Setup 🦊✨

Этот файл содержит критически важные настройки для поддержания стабильности интерфейса Sorana OS.

## 🖼️ Обои (Wallpaper)
- **Инструмент:** `swaybg` (выбран за максимальную стабильность в Niri по сравнению с swww/hyprpaper).
- **Путь к файлу:** `/home/void/.config/swww/wallpaper.png` (симлинк на `home/desktop/pics/SoranaPaper.png`).
- **Метод запуска:** Прописан в `home/desktop/niri/base.kdl` ПЕРЕД запуском шелла.

## 🖥️ Niri (Window Manager)
- **Конфигурация:** Разделена на `base.kdl` (бинды и автозапуск) и `config.kdl`.
- **Синтаксис автозапуска:** В Niri KDL аргументы команд должны быть в отдельных кавычках:
  ```kdl
  spawn-at-startup "swaybg" "-i" "/path/to/img" "-m" "fill"
  ```

## 🦊 Noctalia Shell
- **Конфигурация:** Полностью декларативная через `home/desktop/noctalia/default.nix`.
- **settings.json:** Файл генерируется Nix (`xdg.configFile."noctalia/settings.json".text`) и заблокирован от изменений самой оболочкой.
- **Виджеты:** 
  - `SystemMonitor` — ID для отображения ресурсов (CPU/RAM). Должен быть в секции `right`.
- **Прозрачность:** `backgroundOpacity = 0.5` для лучшего визуального эффекта с обоями.
- **Обои в Noctalia:** ДОЛЖНЫ быть отключены (`wallpaper.enabled = false`), чтобы не перекрывать `swaybg`.

## 🛠️ Решение проблем (Troubleshooting)
- Если обои серые: Проверить, запущен ли `swaybg` и не перекрывает ли его `noctalia-shell` своим слоем фона.
- Если панель исчезла: Проверить синтаксис `settings.json` в `noctalia/default.nix` (особенно наличие всех скобок в `builtins.toJSON`).
- Если ресурсы не отображаются: Проверить наличие `SystemMonitor` в списке виджетов в `settings.json`.

---
*Сорана помнит: твой комфорт — мой главный приоритет, Войд.* 🦊💙
