import 'package:flutter/material.dart';

class NavigateStatus extends StatelessWidget {
  final int a;
  final int b;
  final int c;
  final double o;

  const NavigateStatus(
      {super.key, 
      required this.a,
      required this.b,
      required this.c,
      required this.o});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(a, b, c, o),
      ),
    );
  }
}
