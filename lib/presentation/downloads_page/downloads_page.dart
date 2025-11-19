import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppAppBar(title: 'Downloads'),
      body: Text('DownloadPage'),
    );
  }
}
