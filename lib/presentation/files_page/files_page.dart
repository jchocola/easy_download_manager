import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppAppBar(title: 'Files'),
      body: Text('FilePage'),
    );
  }
}
