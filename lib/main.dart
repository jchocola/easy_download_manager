import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_download_manager/core/constant/router.dart';
import 'package:easy_download_manager/core/providers/download_repository.dart';
import 'package:easy_download_manager/core/services/download_client.dart';
import 'package:easy_download_manager/core/services/notification_service.dart';
import 'package:easy_download_manager/core/theme/dark_theme.dart';
import 'package:easy_download_manager/core/theme/light_theme.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await notificationService.initialize();
  final downloadClient = DownloadClient();
  final downloadRepository =
      await DownloadRepository.create(
    client: downloadClient,
    notificationService: notificationService,
  );
  runApp(MyApp(downloadRepository: downloadRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.downloadRepository});

  final DownloadRepository downloadRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: downloadRepository,
      child: MultiBlocProvider(

        // USE FOR GLOBAL PROVIDERS
        providers: [
          BlocProvider(
            create: (context) => AddDownloadBloc(
              downloadRepository: context.read<DownloadRepository>(),
            )..add(
                AddDownloadBlocEvent_Init(),
              ),
          ),
        ],
        child: AdaptiveTheme(
          light: appLightTheme,
          dark: appDarkTheme,
          initial: AdaptiveThemeMode.dark,
          builder: (theme, darkTheme) => MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('vi'),
            debugShowCheckedModeBanner: false,
            title: 'EDM',
            theme: theme,
            darkTheme: darkTheme,
            routerConfig: router,
            // home: const MainPage(),
          ),
        ),
      ),
    );
  }
}
