import 'package:cat_to_do_list/app.dart';
import 'package:cat_to_do_list/core/di/app_dependencies.dart';
import 'package:cat_to_do_list/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dependencies = AppDependencies();
  
  runApp(ToDoApp(dependencies: dependencies));
}
