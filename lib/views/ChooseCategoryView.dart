import 'package:flutter/material.dart';
import 'package:quizz_ffvl/views/component/CategoryCard.dart';

class ChooseCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text('Catégorie ?'),
      ),
      body: ListView(
        children: [
          CategoryCard(
            imagePath: 'assets/images/meteo.jpeg',
            title: 'météo',
            category: 'météo',
          ),
          CategoryCard(
            imagePath: 'assets/images/mecavol.jpeg',
            title: 'mécavol',
            category: 'mécavol',
          ),
          CategoryCard(
            imagePath: 'assets/images/reglementation.jpg',
            title: 'règlementation',
            category: 'règlementation',
          ),
          CategoryCard(
            imagePath: 'assets/images/materiel.jpeg',
            title: 'matériel',
            category: 'matériel',
          ),
          CategoryCard(
            imagePath: 'assets/images/exam.jpeg',
            title: 'général',
            category: 'général',
          ),
        ],
      ),
    );
  }
}
