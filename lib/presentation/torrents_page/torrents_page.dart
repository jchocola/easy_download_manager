import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/di/DI.dart';
import 'package:easy_download_manager/domain/repository/local_torent_db.dart';
import 'package:easy_download_manager/flutter_foreground_task.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/torrents_page/blocs/torrent_task_bloc.dart';
import 'package:easy_download_manager/presentation/torrents_page/widgets/all_active_comple_torrent.dart';
import 'package:easy_download_manager/widget/advice_card.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TorrentsPage extends StatelessWidget {
  const TorrentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<TorrentTaskBloc>(
          create: (context) =>
              TorrentTaskBloc(localDb: getIt<LocalTorrentDB>())
                ..add(TorrentTaskBlocEvent_load()),
        ),
      ],
      child: Scaffold(
        appBar: AppAppBar(title: l10n.torrents),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),

      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            AdviceCard(
              title: l10n.note,
              subtitle: l10n
                  .atTheMomentYouCanDownloadOneTorrentAtATimeWeReWorkingOnAddingSupportForMultipleSimultaneousDownloadsComingSoon,
            ),
            AdviceWhenForegroundTaskRunning(),
            ActiveCompletedAllTorrent(),
          ],
        ),
      ),
    );
  }
}

class AdviceWhenForegroundTaskRunning extends StatelessWidget {
  const AdviceWhenForegroundTaskRunning({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder(
      stream: isServiceRunning(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return AdviceCard(
            title: l10n.note,
            subtitle: l10n
                .ifDownloadsAreNotProgressingStopTheForegroundDeleteADownloadAndRestartIt,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
