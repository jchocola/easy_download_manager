import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/additional_parameter.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/download_type.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/saving_place.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/add_download_page/widgets/url_input.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddDownloadPage extends StatelessWidget {
  const AddDownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppAppBar(title: 'Добавить загрузку', showLeading: true),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: AppConstant.containerPadding/2 , horizontal: AppConstant.containerPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            UrlInput(),
            DownloadType(),
            SavingPlace(),
            AdditionalParameter(),
            SizedBox(height: AppConstant.containerPadding*3,),
            Row(
              spacing: AppConstant.containerPadding,
              children: [
                Expanded(flex: 1, child: BigButton(title: 'Cancel',withGradient: false,icon: AppIcon.cancelIcon,)),
                 Expanded(flex: 1, child: BigButton(title: 'Next',withGradient: true,icon: AppIcon.continueIcon, onTap: () => context.push('/downloads/download_confirm'),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
