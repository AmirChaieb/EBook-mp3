// ignore_for_file: deprecated_member_use, unnecessary_this

import 'package:flutter/material.dart';


class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: this.color,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 7,
                                      offset: Offset(0, 0)
                                    )
                                  ]
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  this.text, style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              );
  }
}