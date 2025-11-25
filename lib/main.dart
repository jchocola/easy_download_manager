import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_download_manager/core/constant/router.dart';
import 'package:easy_download_manager/core/di/DI.dart';
import 'package:easy_download_manager/core/providers/global_providers.dart';
import 'package:easy_download_manager/core/theme/dark_theme.dart';
import 'package:easy_download_manager/core/theme/light_theme.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/data/repository/permission_handler_repository_impl.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/main_page.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';

var logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloaderRepositoryImpl.instance
      .initPlugin(); // init downloader plugin

  await DI(); // DI

  await PermissionHandlerRepositoryImpl.instance.notificationRequest();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // USE FOR GLOBAL PROVIDERS
      providers: [
        BlocProvider(
          create: (context) => AddDownloadBloc(
            flutterDownloader: getIt<FlutterDownloaderRepositoryImpl>(),
          )..add(AddDownloadBlocEvent_Init()),
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
    );
  }
}
