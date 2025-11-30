import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialDownloadUrlInput extends StatefulWidget {
  const SocialDownloadUrlInput({super.key});

  @override
  State<SocialDownloadUrlInput> createState() => _SocialDownloadUrlInputState();
}

class _SocialDownloadUrlInputState extends State<SocialDownloadUrlInput> {
  late final TextEditingController urlController;

  @override
  void initState() {
    urlController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

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
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(
                AppIcon.socialIcon,
                color: theme.colorScheme.secondaryContainer,
              ),
              Text('Social Downloads', style: theme.textTheme.titleMedium),
            ],
          ),

          Text(
            l10n.enterTheLinkToTheFileForDownload,
            style: theme.textTheme.bodySmall,
          ),

          SizedBox(height: AppConstant.containerPadding),
          Text('Supported Social Platforms', style: theme.textTheme.titleSmall),
          SizedBox(height: AppConstant.containerPadding),
          SupportedSocials(),

          SizedBox(height: AppConstant.containerPadding * 2),

          Text(l10n.url, style: theme.textTheme.titleSmall),

          BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
            builder: (context, state) {
              if (state is AddDownloadBlocStateLoaded) {
                urlController.text = state.downloadUrl;
                return Input(
                  hintText: AppConstant.socialUrlHintText,
                  controller: urlController,
                  onChanged: (value) => context.read<AddDownloadBloc>().add(
                    AddDownloadBlocEvent_ChangeDownloadUrl(value: value),
                  ),
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

class SupportedSocials extends StatelessWidget {
  const SupportedSocials({super.key});

  final List<String> socials = const [
    'Facebook',
    'Instagram',
    'YouTube',
    'Twitter',
    'Dailymotion',
    'Vimeo',
    'VK',
    'SoundCloud',
    'TikTok',
    'Reddit',
    'Threads',
  ];

  final List<Color> colors = const [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.lightBlue,
    Colors.orange,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.orangeAccent,
    Colors.green,
    Colors.deepOrange,
    Colors.pink,
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: AppConstant.containerPadding / 2,
      runSpacing: AppConstant.containerPadding / 2,
      children: socials
          .map(
            (social) => Chip(
              side: BorderSide(
                color: colors[socials.indexOf(social)].withOpacity(0.5),
              ),
              backgroundColor: colors[socials.indexOf(social)].withOpacity(0.1),
              label: Text(
                social,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: colors[socials.indexOf(social)],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
