import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppAppBar(title: 'Settings'),
      body: Text('Setting page'),
    );
  }
}
