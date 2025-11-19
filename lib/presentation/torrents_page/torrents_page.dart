import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';

class TorrentsPage extends StatelessWidget {
  const TorrentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Torrents'),
      body: Text('Torrent page'),
    );
  }
}
