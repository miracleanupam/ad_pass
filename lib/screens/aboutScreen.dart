import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final TextStyle style = TextStyle(
    color: Colors.white70,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About ADPass'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'This app is a Password Store.',
                style: style,
              ),
              Text(
                'Store as many passwords as you want!',
                style: style,
              ),
              Text(
                'Until your storage runs out! :P',
                style: style,
              ),
              Text(
                'This totally works offline',
                style: style,
              ),
              Text(
                'Change your phone? Export from old and import in New!',
                style: style,
              ),
              Text(
                'This app was made for learnign purposes!',
                style: style,
              ),
              Spacer(),
              FlatButton.icon(
                label: Text('AD'),
                onPressed: () {},
                icon: Icon(Icons.copyright),
              )
            ]),
      ),
    );
  }
}
