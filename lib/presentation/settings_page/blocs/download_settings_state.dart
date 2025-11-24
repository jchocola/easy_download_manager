part of 'download_settings_cubit.dart';

enum DownloadSettingsStatus { initial, loading, ready }

class DownloadSettingsState extends Equatable {
  const DownloadSettingsState({
    this.status = DownloadSettingsStatus.initial,
    this.defaultDirectory,
    this.notificationsEnabled = true,
    this.wifiOnly = false,
  });

  final DownloadSettingsStatus status;
  final String? defaultDirectory;
  final bool notificationsEnabled;
  final bool wifiOnly;

  bool get isReady => status == DownloadSettingsStatus.ready;

  DownloadSettingsState copyWith({
    DownloadSettingsStatus? status,
    String? defaultDirectory,
    bool? notificationsEnabled,
    bool? wifiOnly,
  }) {
    return DownloadSettingsState(
      status: status ?? this.status,
      defaultDirectory: defaultDirectory ?? this.defaultDirectory,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      wifiOnly: wifiOnly ?? this.wifiOnly,
    );
  }

  @override
  List<Object?> get props => [
        status,
        defaultDirectory,
        notificationsEnabled,
        wifiOnly,
      ];
}

