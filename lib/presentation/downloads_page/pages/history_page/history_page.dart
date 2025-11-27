import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/di/DI.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/history_page/blocs/history_bloc.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider<HistoryBloc>(
      create: (context) => HistoryBloc(fl_dl: getIt<FlutterDownloaderRepositoryImpl>())..add(HistoryBlocEvent_load()),
      child: Scaffold(
        appBar: AppAppBar(title: l10n.downloadHistory, showLeading: true),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstant.containerPadding,
          children: [buildList(context)],
        ),
      ),
    );
  }

  Widget buildList(context) {
    return BlocBuilder<HistoryBloc, HistoryBlocState>(
      builder: (context, state) {
        if (state is HistoryBlocState_loaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.allTasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final task = state.allTasks[index];
              return HistoryCard(task: task,);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
