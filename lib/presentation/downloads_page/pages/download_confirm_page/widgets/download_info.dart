import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadInfo extends StatelessWidget {
  const DownloadInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
      builder: (context, state) {
        if (state is AddDownloadBlocStateLoaded) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstant.containerPadding,
              vertical: AppConstant.containerPadding / 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstant.borderRadius),
              color: theme.colorScheme.onPrimary,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: AppConstant.containerPadding,
                  children: [
                    ContainerWithBorderColor(withGradient: true),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppConstant.containerPadding,
                      children: [
                        Text(l10n.fileName, style: theme.textTheme.bodySmall),
                        Text(
                          state.fileName,
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: AppConstant.containerPadding * 2),

                Text(l10n.httpHttps, style: theme.textTheme.bodySmall),

                Text(
                  state.downloadUrl,
                  style: theme.textTheme.titleMedium!.copyWith(
                    letterSpacing: 2.5,
                  ),
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
