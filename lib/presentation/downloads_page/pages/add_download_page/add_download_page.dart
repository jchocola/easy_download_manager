import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_method.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/additional_parameter.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/download_type.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/saving_place.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/social_download_url_input.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/torrent_file_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/torrent_pick_file.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/http_download_url_input.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddDownloadPage extends StatelessWidget {
  const AddDownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppAppBar(title: l10n.addDownload, showLeading: true),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
              builder: (context, state) {
                if (state is AddDownloadBlocStateLoaded) {
                  switch (state.downloadMethod) {
                    case DOWNLOAD_METHOD.HTTP_HTTPS:
                      return HttpDownloadUrlInput();
                    case DOWNLOAD_METHOD.TORRENT:
                      return TorrentPickFile();
                    case DOWNLOAD_METHOD.SOCIAL:
                      return SocialDownloadUrlInput();
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            TorrentFileInfo(),
            DownloadType(),
            SavingPlace(),
            AdditionalParameter(),
            SizedBox(height: AppConstant.containerPadding * 3),
            Row(
              spacing: AppConstant.containerPadding,
              children: [
                Expanded(
                  flex: 1,
                  child: BigButton(
                    title: l10n.cancel,
                    withGradient: false,
                    icon: AppIcon.cancelIcon,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BigButton(
                    title: l10n.next,
                    withGradient: true,
                    icon: AppIcon.continueIcon,
                    onTap: () => context.push('/downloads/download_confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
