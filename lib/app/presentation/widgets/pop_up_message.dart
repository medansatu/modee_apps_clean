import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopUpMessage extends StatelessWidget {
  final String text;
  final String buttonText;
  final String message;

  PopUpMessage({
    required this.text,
    required this.buttonText,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  title: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      color: Theme.of(context).accentColor,
                                    ),
                                    height: 50,
                                    width: 311,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 16, 0, 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            text,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            padding:
                                                EdgeInsets.only(bottom: 16),
                                            color: Colors.white,
                                            icon: Icon(
                                              Icons.close,
                                              size: 20,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  titlePadding: const EdgeInsets.all(0),
                                  content: 
                                  Text(message, style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
                                  actions: [
                                    Container(
                                        child: OutlinedButton(
                                      child: Text(buttonText,
                                        style: TextStyle(
                                            fontSize: 14, color: Theme.of(context).accentColor),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24)),
                                        side: BorderSide(color: Theme.of(context).accentColor),
                                      ),
                                    ))
                                  ],
                                );
  }
}