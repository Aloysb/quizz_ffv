import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/views/Home.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/QuizView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
  Controller();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFVL QCM Entrainement',
      home: HomeView(),
      color: Colors.white,
    );
  }
}
