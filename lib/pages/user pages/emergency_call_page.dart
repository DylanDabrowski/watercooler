import 'package:flutter/material.dart';
import 'package:watercooler/widgets/big_text.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';

import '../../utils/colors.dart';

class EmergencyCallPage extends StatefulWidget {
  const EmergencyCallPage({Key? key}) : super(key: key);

  @override
  State<EmergencyCallPage> createState() => _EmergencyCallPageState();
}

class _EmergencyCallPageState extends State<EmergencyCallPage> {
  TextEditingController message = TextEditingController();

  sendEmergencyMessage() {
    print("emregency message pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigText(text: "Emergency Admin Message"),
              const Icon(
                Icons.warning,
                size: 150,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: message,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MESSEGE',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  sendEmergencyMessage();
                },
                style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: AppColors.textColor,
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 40, right: 40)),
                child: const Text("SEND"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
