import 'package:flutter/material.dart';
import 'package:random_word_generator/random_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Random Word Generator',
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new RandomWords()
    );
  }
}