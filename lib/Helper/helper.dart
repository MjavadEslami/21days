import 'package:flutter/material.dart';

navigatorPush({context, screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

massanger({context, text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(fontFamily: 'iranYekan', fontSize: 18),
    ),
    duration: const Duration(seconds: 3),
  ));
}
