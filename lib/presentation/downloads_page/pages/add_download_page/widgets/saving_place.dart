import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/save_place.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingPlace extends StatelessWidget {
  const SavingPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(AppIcon.folderIcon, color: theme.colorScheme.secondary),
              Text(l10n.storageLocation, style: theme.textTheme.titleMedium),
            ],
          ),

          Text(l10n.selectWhereToSaveTheFile, style: theme.textTheme.bodySmall),

          Text(l10n.fileName, style: theme.textTheme.bodyMedium),
          Input(
            hintText: 'example',
            onChanged: (value) => context.read<AddDownloadBloc>().add(
              AddDownloadBlocEvent_ChangeFileName(value: value),
            ),
          ),

          Text(l10n.saveFolder, style: theme.textTheme.bodyMedium),
          BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
            builder: (context, state) {
              if (state is AddDownloadBlocStateLoaded) {
                return Text(state.savePath, style: theme.textTheme.bodySmall);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),

          Text(l10n.quickSelection, style: theme.textTheme.bodySmall),

          BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
            builder: (context, state) {
              if (state is AddDownloadBlocStateLoaded) {
                return Column(
                  spacing: AppConstant.containerPadding,
                  children: [
                    Row(
                      spacing: AppConstant.containerPadding,
                      children: [
                        Expanded(
                          child: _customButton(
                            context,
                            selected: state.savePlace == SAVE_PLACE.DOWNLOADS,
                            title: 'Downloads',
                            icon: AppIcon.downloadIcon,
                            onTap: () => context.read<AddDownloadBloc>().add(
                              AddDownloadBlocEvent_ChangeSavePlace(
                                savePlace: SAVE_PLACE.DOWNLOADS,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _customButton(
                            context,
                            title: 'Documents',
                            icon: AppIcon.folderIcon,
                            selected: state.savePlace == SAVE_PLACE.DOCUMENTS,
                            onTap: () => context.read<AddDownloadBloc>().add(
                              AddDownloadBlocEvent_ChangeSavePlace(
                                savePlace: SAVE_PLACE.DOCUMENTS,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      spacing: AppConstant.containerPadding,
                      children: [
                        Expanded(
                          child: _customButton(
                            context,
                            title: 'Videos',
                            icon: AppIcon.videoIcon,
                            selected: state.savePlace == SAVE_PLACE.VIDEOS,
                            onTap: () => context.read<AddDownloadBloc>().add(
                              AddDownloadBlocEvent_ChangeSavePlace(
                                savePlace: SAVE_PLACE.VIDEOS,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _customButton(
                            context,
                            title: 'Musics',
                            icon: AppIcon.musicIcon,
                            selected: state.savePlace == SAVE_PLACE.MUSICS,
                            onTap: () => context.read<AddDownloadBloc>().add(
                              AddDownloadBlocEvent_ChangeSavePlace(
                                savePlace: SAVE_PLACE.MUSICS,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _customButton(
    context, {
    bool selected = false,
    IconData icon = Icons.add,
    String title = 'title',
    void Function()? onTap,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.containerPadding),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.tertiaryFixed),
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          color: selected
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.onPrimary,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppConstant.containerPadding,
            children: [
              Icon(icon),
              Text(title, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
