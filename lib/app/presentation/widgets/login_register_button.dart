import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  
  // final String routeName;

  LoginRegisterButton({
    required this.text,
    required this.action,
    // required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          action();
          // Navigator.of(context).pushReplacementNamed(routeName);
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: const Color.fromRGBO(255, 130, 201, 1),
        ),
      ),
    );
  }
}
