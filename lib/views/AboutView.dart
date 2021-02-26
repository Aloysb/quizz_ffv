import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propros'),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Container(
        child: Column(
          children: [
            Text(
                "Ce QCM est non-officiel: il n'a pas été reconnu par la FFVL à l'heure actuelle."),
            Text(
                "En revanche, il est basé sur la liste de question officielle et est donc tout à fait adapté à l'entrainement pour l'obtention de votre brevet, ou simplement pour rafraîchir vos idées."),
            Text('Changelog'),
            Text('Version 0.1: Beta (version test)')
          ],
        ),
      ),
    );
  }
}
