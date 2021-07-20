import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .55,
                child: LinearProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('starting app'),
            )
          ],
        ),
      ),
    );
  }
}
