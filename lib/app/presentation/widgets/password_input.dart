import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;  
  final String text;

  const PasswordInput({
    required this.controller,    
    required this.text,
    }
  );
 

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
   var showPass = true;
   void visibility(){
    setState(() {
      showPass = !showPass;
    });
   }
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
              controller: widget.controller,
              keyboardType: TextInputType.visiblePassword,
              obscureText: showPass,
              decoration: InputDecoration(
                hintText: widget.text,
                border: InputBorder.none,
                suffixIcon: IconButton(icon: showPass ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),                
                onPressed: visibility)
              ),
            ),
          );
  }
}