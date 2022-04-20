import 'package:flutter/material.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';

class EmergencyCallPage extends StatefulWidget {
  const EmergencyCallPage({Key? key}) : super(key: key);

  @override
  State<EmergencyCallPage> createState() => _EmergencyCallPageState();
}

class _EmergencyCallPageState extends State<EmergencyCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: const Text("Emergency"),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
