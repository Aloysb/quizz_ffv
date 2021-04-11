import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/model/main_model.dart';
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
                    height: 700.0,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/hero.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 700,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 700,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.1, 0.6],
                      ),
                    ),
                  ),
                  Container(
                    height: 500,
                    padding: EdgeInsets.only(top: 120.0),
                    child: Text('QCM FFVL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'BebasNeue',
                          fontSize: 100.0,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1.0,
                      offset: Offset(0, -2),
                    )
                  ],
                  color: Colors.black,
                ),
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
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseCategoryView(
                                cards: Controller.getOptions('category'),
                              ),
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
