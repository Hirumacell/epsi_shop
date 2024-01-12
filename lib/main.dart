import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'bo/cart.dart';

void main() {
  runApp(ChangeNotifierProvider(
      child: const MyApp(),
      create: (_)=> Cart()
  ));
}