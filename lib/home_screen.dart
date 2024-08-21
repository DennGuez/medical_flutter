import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xff51A8FF),
/* double.infity hace que el cotainer ocupe todo el espacio */        
        width: double.infinity,
        height: 350,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Edi',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xffFFFFFF)
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Let's find\nyour top doctor!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
/* Eliminamos el border del Input */                
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                )
              ),
            )
          ],
        ),
      ),
    );
  }
} 