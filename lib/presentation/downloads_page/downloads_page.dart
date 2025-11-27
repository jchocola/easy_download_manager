import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/di/DI.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/active_downloading_tasks_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/complete_tasks_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/download_tab_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/f4_statistic_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/other_tasks_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/history_page/blocs/history_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/4_status_category.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/active_completed_all.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/add_download.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>  DownloadTabBloc()..add(DownloadTabBlocEvent_SetInitValue())),
        BlocProvider(create: (context)=> F4StatisticBloc(flutter_dl: getIt<FlutterDownloaderRepositoryImpl>())..add(F4StatisticBlocEvent_Load())),
        BlocProvider(create: (context)=> CompleteTasksBloc(flutter_downloader: getIt<FlutterDownloaderRepositoryImpl>())..add(CompleteTaskBlocEvent_load())),
         BlocProvider(create: (context)=> OtherTasksBloc(flutter_downloader: getIt<FlutterDownloaderRepositoryImpl>())..add(OtherTaskBlocEvent_load())),
        BlocProvider(create: (context)=> ActiveDownloadingTasksBloc()..add(ActiveDownloadingTasksEvent_Load())),
         

      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppAppBar(
            title: l10n.downloads,
            showActions: true,
            actionIcon: AppIcon.historyIcon,
            onActionTapped: () => context.push('/downloads/history'),
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [FourStatusCategory(), AddDownload(), ActiveCompletedAll()],
        ),
      ),
    );
  }
}
