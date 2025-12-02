import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TorrentPickFile extends StatelessWidget {
  const TorrentPickFile({super.key});

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
              Icon(
                AppIcon.seedIcon,
                color: theme.colorScheme.secondaryContainer,
              ),
              Text(l10n.torrent, style: theme.textTheme.titleMedium),
            ],
          ),

          Text(l10n.pickTorrentFile, style: theme.textTheme.bodySmall),

          pickedTorrentFile(context),

          BigButton(
            withGradient: true,
            icon: AppIcon.pickIcon,
            title: l10n.selectFile,
            onTap: () => context.read<AddDownloadBloc>().add(
              AddDownloadBlocEvent_PickTorrentFile(),
            ),
          ),
        ],
      ),
    );
  }

  Widget pickedTorrentFile(context) {
    final theme = Theme.of(context);
    return BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
      builder: (context, state) {
        if (state is AddDownloadBlocStateLoaded) {
          if (state.torrentFile != null) {
            return ListTile(
              subtitle: Text(
                state.torrentFile!.path,
                style: theme.textTheme.bodySmall,
              ),
              trailing: IconButton(
                onPressed: () => context.read<AddDownloadBloc>().add(
                  AddDownloadBlocEvent_RemoveTorrentFile(),
                ),
                icon: Icon(AppIcon.deleteIcon),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
