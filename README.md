# Easy Download Manager

Easy Download Manager is a Flutter application focused on Android that lets you
queue, pause/resume, and monitor large file downloads with persistent history
and local notifications.

## Features

- HTTP/HTTPS download client with pause, resume, cancel, and progress reporting
- Persistent download queue backed by `shared_preferences` so tasks survive app restarts
- Local notifications (via `flutter_local_notifications`) for success/failure updates
- Download list with Active / Completed / Others tabs powered by BLoC
- Configurable default download directory and notification toggles inside Settings

## Getting Started

```bash
flutter pub get
flutter run -d <device_id>
```

> Android requires storage and notification permissions. The manifest already
> declares them; the first run will prompt the user automatically.

## Android Notes

- Uses scoped storage friendly paths (Downloads/EDM/\*) by default. You can pick
  another folder in `Settings → Quick switches`.
- Notifications rely on `flutter_local_notifications`; make sure to grant
  POST_NOTIFICATIONS on Android 13+.
- Foreground downloads use `HttpClient`; servers must support HTTP range headers
  for the best pause/resume experience.

## Smoke Test Checklist

1. Launch the app, tap **Add download**, enter a direct file URL, and confirm.
2. Verify the download appears under **Active** with live progress.
3. Pause and resume the task from the card controls.
4. Cancel a task and ensure it moves to **Others**.
5. Complete a download and confirm it lands in **Completed** and a notification appears.
6. Change the default folder in **Settings** and start a new download to confirm the new path is used.
