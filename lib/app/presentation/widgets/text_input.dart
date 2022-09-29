import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final TextInputType type;

  const TextInput({
    required this.controller,    
    required this.type,
    required this.text,
    }
  );



  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(                
                hintText: text,
                border: InputBorder.none,
              ),
            ),
          );
  }
}