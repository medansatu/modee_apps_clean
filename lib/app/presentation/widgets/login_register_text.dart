import 'package:flutter/material.dart';

class LoginRegisterText extends StatelessWidget {
  final String text1;
  final String text2;
  // final String routeName;

  LoginRegisterText({
    required this.text1,
    required this.text2,
    // required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushReplacementNamed(routeName);
                    },
                    child: Text(
                      text2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationThickness: 4,
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}