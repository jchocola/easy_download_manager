import 'package:easy_download_manager/presentation/downloads_page/widgets/4_status_category.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Downloads'),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(context) {
    return Column(
      children: [
       // FourStatusCategory(),
      ],
    );
  }
}
