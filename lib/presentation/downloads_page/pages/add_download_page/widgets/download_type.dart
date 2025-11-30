import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_method.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/download_type_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadType extends StatelessWidget {
  const DownloadType({super.key});

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
              Icon(AppIcon.settingIcon, color: theme.colorScheme.secondary),
              Text(l10n.downloadType, style: theme.textTheme.titleMedium),
            ],
          ),
          Text(
            l10n.selectHowYouWantToDownloadTheFile,
            style: theme.textTheme.bodySmall,
          ),

          BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
            builder: (context, state) {
              if (state is AddDownloadBlocStateLoaded) {
                return Column(
                  children: [
                    DownloadTypeCard(
                      title: l10n.httpHttps,
                      subtitle: l10n.directDownloadFromWebServer,
                      icon: AppIcon.downloadTypeHttpIcon,
                      value: state.downloadMethod == DOWNLOAD_METHOD.HTTP_HTTPS,
                      onTap: () => context.read<AddDownloadBloc>().add(AddDownloadBlocEvent_ChangeDownloadMethod(method: DOWNLOAD_METHOD.HTTP_HTTPS)),
                    ),
                    DownloadTypeCard(
                      title: l10n.torrent,
                      subtitle: l10n.downloadingViaTorrentProtocol,
                      icon: AppIcon.downloadTypeTorrentIcon,
                      value: state.downloadMethod == DOWNLOAD_METHOD.TORRENT,
                      onTap: () => context.read<AddDownloadBloc>().add(AddDownloadBlocEvent_ChangeDownloadMethod(method: DOWNLOAD_METHOD.TORRENT)),
                    ),
                    // DownloadTypeCard(
                    //   title: l10n.cloud,
                    //   subtitle: l10n.downloadingFromCloudServices,
                    //   icon: AppIcon.downloadTypeCloudIcon,
                    //   value: state.downloadMethod == DOWNLOAD_METHOD.CLOUD,
                    //    onTap: () => context.read<AddDownloadBloc>().add(AddDownloadBlocEvent_ChangeDownloadMethod(method: DOWNLOAD_METHOD.CLOUD)),
                    // ),
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
}
