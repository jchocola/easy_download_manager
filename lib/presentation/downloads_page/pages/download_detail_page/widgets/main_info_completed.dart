import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainInfoCompleted extends StatelessWidget {
  const MainInfoCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PickedTaskBloc, PickedTaskBlocState>(
      builder: (context, state) {
        if (state is PickedTaskBlocState_loaded) {
          return Container(
            padding: EdgeInsets.all(AppConstant.containerPadding),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(AppConstant.borderRadius),
            ),
            child: Column(
              spacing: AppConstant.containerPadding,
              children: [
                Text(state.task.filename ?? 'Unknown', style: theme.textTheme.titleMedium),
                Divider(),

                _customInfo(
                  title: 'Size',
                  value: '7.92 GB',
                  icon: AppIcon.sizeIcon,
                ),
                _customInfo(
                  title: 'Created',
                  value: DateTime.fromMillisecondsSinceEpoch(state.task.timeCreated).toString().substring(0,16),
                  icon: AppIcon.calendarIcon,
                ),
                _customInfo(
                  title: 'Directory',
                  value: state.task.savedDir,
                  icon: AppIcon.pathIcon,
                ),
                _customInfo(
                  title: 'Type',
                  value: 'Файл',
                  icon: AppIcon.typeFileIcon,
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class _customInfo extends StatelessWidget {
  const _customInfo({
    super.key,
    this.title = 'title',
    this.value = 'value',
    this.icon = Icons.abc,
  });
  final String title;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.containerPadding,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.onTertiary),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          flex: 2,
          child: Text(value, style: theme.textTheme.titleSmall),
        ),
      ],
    );
  }
}
