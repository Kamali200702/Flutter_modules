import 'package:flutter/material.dart';

class settingspage extends StatefulWidget {
  const settingspage({super.key});

  @override
  State<settingspage> createState() => _settingspageState();
}

class _settingspageState extends State<settingspage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('settingspage'
          )),
    );
  }
}
