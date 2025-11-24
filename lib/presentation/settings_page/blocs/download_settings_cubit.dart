import 'package:easy_download_manager/core/providers/download_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'download_settings_state.dart';

class DownloadSettingsCubit extends Cubit<DownloadSettingsState> {
  DownloadSettingsCubit({required DownloadRepository repository})
      : _repository = repository,
        super(
          DownloadSettingsState(
            status: DownloadSettingsStatus.loading,
            defaultDirectory: repository.defaultDirectory,
            notificationsEnabled: repository.notificationsEnabled,
            wifiOnly: repository.wifiOnly,
          ),
        ) {
    loadSettings();
  }

  final DownloadRepository _repository;

  Future<void> loadSettings() async {
    emit(
      state.copyWith(
        status: DownloadSettingsStatus.ready,
        defaultDirectory: _repository.defaultDirectory,
        notificationsEnabled: _repository.notificationsEnabled,
        wifiOnly: _repository.wifiOnly,
      ),
    );
  }

  Future<void> updateDefaultDirectory(String? path) async {
    if (path == null || path.isEmpty) return;
    await _repository.setDefaultDirectory(path);
    emit(state.copyWith(defaultDirectory: path));
  }

  Future<void> toggleNotifications(bool value) async {
    await _repository.setNotificationsEnabled(value);
    emit(state.copyWith(notificationsEnabled: value));
  }

  Future<void> toggleWifiOnly(bool value) async {
    await _repository.setWifiOnly(value);
    emit(state.copyWith(wifiOnly: value));
  }
}

