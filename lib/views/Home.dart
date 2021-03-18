import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizz_ffvl/views/AboutView.dart';
import 'package:quizz_ffvl/views/ChooseCategoryView.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 500.0,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/hero.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.grey[900], Colors.transparent],
                        stops: [0.1, 0.6],
                      ),
                    ),
                  ),
                  Container(
                    height: 500,
                    padding: EdgeInsets.only(top: 120.0),
                    child: Text(
                      'QCM FFVL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        fontSize: 100.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[900],
                width: 250.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Text(
                          'Démarrer QCM',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.orange[900],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseCategoryView(),
                            ),
                          );
                        },
                      ),
                      RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.grey[500],
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Text(
                          'À propos',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
