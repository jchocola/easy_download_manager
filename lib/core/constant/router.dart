import 'package:easy_download_manager/main_page.dart';
import 'package:easy_download_manager/presentation/downloads_page/downloads_page.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/add_download_page.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/download_confirm_page.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/download_detail_page.dart';
import 'package:easy_download_manager/presentation/files_page/files_page.dart';
import 'package:easy_download_manager/presentation/settings_page/settings_page.dart';
import 'package:easy_download_manager/presentation/torrents_page/torrents_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/downloads',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        // --- ВЕТВЬ 1: (Downloads) ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/downloads',
              builder: (context, state) => const DownloadsPage(),
              routes: [
                GoRoute(
                  path: '/download_detail_page',
                  builder: (context, state) => const DownloadDetailPage(),
                ),

                 GoRoute(
                  path: '/add_download',
                  builder: (context, state) => const AddDownloadPage(),
                ),

                GoRoute(
                  path: '/download_confirm',
                  builder: (context, state) => const DownloadConfirmPage(),
                ),
              ],
            ),
          ],
        ),

        // --- ВЕТВЬ 2:  (Files) ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/files',
              builder: (context, state) => const FilesPage(),
            ),
          ],
        ),

        // --- ВЕТВЬ 3:  (Torrents) ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/torrents',
              builder: (context, state) => const TorrentsPage(),
            ),
          ],
        ),

        // --- ВЕТВЬ 3:  (Torrents) ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
