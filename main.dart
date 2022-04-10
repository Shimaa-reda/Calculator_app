import 'dart:html';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Calculator> createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  String equation_ = "0";
  String result = "0";
  String expression = "";
  //onpress_fun
  buttonPress(String buttonName) {
    setState(() {
      if (buttonName == "C") {
        equation_ = "0";
        result = "0";
      } else if (buttonName == "<x") {
        equation_ = equation_.substring(0, equation_.length - 1);
        if (equation_ == "") {
          equation_ = "0";
        }
      } else if (buttonName == "=") {
        expression = equation_;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation_ == "0") {
          equation_ = buttonName;
        } else {
          equation_ = equation_ + buttonName;
        }
      }
    });
  }

  //fun for buttons
  Widget button_fun(String buttonName, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
              color: Colors.white, style: BorderStyle.solid, width: 1),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPress(buttonName),
        child: Text(
          buttonName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation_,
              style: TextStyle(fontSize: 39.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 49.0),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      button_fun("C", 1, Colors.redAccent),
                      button_fun("<x", 1, Colors.blue),
                      button_fun("÷", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      button_fun("7", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("8", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("9", 1, Color.fromARGB(221, 54, 54, 54)),
                    ]),
                    TableRow(children: [
                      button_fun("4", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("5", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("6", 1, Color.fromARGB(221, 54, 54, 54)),
                    ]),
                    TableRow(children: [
                      button_fun("1", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("2", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("3", 1, Color.fromARGB(221, 54, 54, 54)),
                    ]),
                    TableRow(children: [
                      button_fun(".", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("0", 1, Color.fromARGB(221, 54, 54, 54)),
                      button_fun("00", 1, Color.fromARGB(221, 54, 54, 54)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      button_fun("×", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      button_fun("+", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      button_fun("-", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      button_fun("=", 2, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
