import 'package:flutter/material.dart';

class AboutUi extends StatefulWidget {
  const AboutUi({super.key});

  @override
  State<AboutUi> createState() => _AboutUiState();
}

class _AboutUiState extends State<AboutUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Body Health Calculator',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(
                  height: 20
                ),
                Image.asset(
                  'assets/images/calculator.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20),
                Text(
                  'คำนวณหาค่าดัชนีมวลกาย (BMI)',
                ),
                SizedBox(
                  height: 10),
                Text(
                  'คำนวณหาปริมาณแคลอรี่ที่ร่างกายต้องการในแต่ละวัน (BMR)',
                ),
                SizedBox(
                  height: 20),
          
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  'https://app.sau.ac.th/hubfs/logosau-01.png',
                  width: 80,
                ),
                Text(
                  'Developed by Gojo Satoru',
                  style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
