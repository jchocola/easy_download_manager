import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/f4_statistic_bloc.dart';
import 'package:easy_download_manager/widget/status_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FourStatusCategory extends StatelessWidget {
  const FourStatusCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<F4StatisticBloc, F4StatisticBlocState>(
      builder: (context, state) {
        if (state is F4StatisticBlocState_Loaded) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: StatusCategoryCard(
                      label: l10n.active,
                      count: state.activeTasks.toString(),
                      withGradient: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: StatusCategoryCard(
                      label: l10n.completed,
                      count: state.completeTasks.toString(),
                      color: theme.colorScheme.scrim,
                      icon: AppIcon.completedIcon,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: StatusCategoryCard(
                      label: l10n.errors,
                      count: state.errorTasks.toString(),
                      color: theme.colorScheme.error,
                      icon: AppIcon.errorIcon,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: StatusCategoryCard(
                      label: l10n.onPause,
                      count: state.pausedTasks.toString(),
                      color: theme.colorScheme.tertiaryFixed,
                      icon: AppIcon.pauseIcon,
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
    );
  }
}
