import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int randomNumber = 0;
  TextEditingController textController = TextEditingController();
  String feedbackMessage = '';
  bool guessedRight = false;

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    setState(() {
      randomNumber = Random().nextInt(100) + 1;
      print('Număr generat: $randomNumber');
      textController.clear();
      feedbackMessage = '';
      guessedRight = false;
    });
  }

  void checkNumber() {
    int userNumber = int.tryParse(textController.text) ?? 0;

    if (userNumber < randomNumber) {
      setState(() {
        feedbackMessage = 'You tried $userNumber. Try higher';
      });
    } else if (userNumber > randomNumber) {
      setState(() {
        feedbackMessage = 'You tried $userNumber. Try lower';
      });
    } else {
      setState(() {
        feedbackMessage = 'You guessed right! The number was $randomNumber.';
        guessedRight = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You guessed right!'),
            content: Text('The number was $randomNumber.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: Text('Try Again'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void resetGame() {
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess my number'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I am thinking of a number between 1 and 100.',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  'It is your turn to guess my number!',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedbackMessage,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Try a number!',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: textController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (guessedRight) {
                        resetGame();
                      } else {
                        checkNumber();
                      }
                    },
                    child: Text(guessedRight ? 'Reset' : 'Guess'),
                  ),
                  if (guessedRight)
                    SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}