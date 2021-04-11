import 'package:flutter/material.dart';

import 'package:quizz_ffvl/views/Home.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const QuizAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              Future<void> _showMyDialog() async {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Quitter le QCM'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                                'En quittant le QCM, votre progression sera perdue.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                            child: Text(
                              'Continuer',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        TextButton(
                          child: Text(
                            'Quitter',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeView(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              }

              _showMyDialog();
            },
          );
        },
      ),
    );
  }
}
