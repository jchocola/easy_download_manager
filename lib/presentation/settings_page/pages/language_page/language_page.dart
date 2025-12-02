import 'package:easy_download_manager/app_config.bloc.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/utils/language_convert.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context));
  }

  Widget buildBody(context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: AppLocalizations.supportedLocales.map((locale) {
            return BlocBuilder<AppConfigBloc, AppConfigBlocState>(
              builder: (context, state) {
                if (state is AppConfigBloacState_Loaded) {
                  return ListTile(
                    onTap: () => context.read<AppConfigBloc>().add(
                          AppConfigBlocEvent_changeLocale(
                              locale: locale.languageCode),
                        ),
                    title: Text(
                      LanguageConverter(languageCode: locale.languageCode),
                    ),
                    trailing: state.locale == locale.languageCode
                        ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
                        : null,
                  );
                } else {
                  return SizedBox();
                }
              },
            );
            ;
          }).toList(),
        ),
      ),
    );
  }
}
