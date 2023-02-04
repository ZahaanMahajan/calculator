// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Icon iconDel = Icon(Icons.backspace);
  String displayNumber = "0";
  String equation = "0";
  String expression = "";

  buttonClicked(String numText) {
    setState(() {
      if (numText == "AC") {
        equation = "0";
        displayNumber = equation;
      } else if (numText == "DEL") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
        displayNumber = equation;
      } else if (numText == "=") {
        expression = equation;
        expression = expression.replaceAll('x', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          displayNumber = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          displayNumber = "Error";
        }
      } else {
        if (equation == "0") {
          equation = numText;
        } else {
          equation = equation + numText;
          displayNumber = equation.substring(0, equation.length - 1);
        }
        displayNumber = equation;
      }
    });
  }

  Widget numButton(String numText, Color numColor, Color textColor) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: numColor,
          fixedSize: const Size(0, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
            side: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        onPressed: () => buttonClicked(numText),
        child: Text(
          numText,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 28,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Calculator',
          style: TextStyle(
            height: 3,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    displayNumber,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton('AC', Colors.grey, Colors.black),
              numButton('DEL', Colors.grey, Colors.black),
              numButton('(', Colors.grey, Colors.black),
              numButton(')', Colors.orange, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton('7', Colors.grey.shade800, Colors.white),
              numButton('8', Colors.grey.shade800, Colors.white),
              numButton('9', Colors.grey.shade800, Colors.white),
              numButton('x', Colors.orange, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton('4', Colors.grey.shade800, Colors.white),
              numButton('5', Colors.grey.shade800, Colors.white),
              numButton('6', Colors.grey.shade800, Colors.white),
              numButton('+', Colors.orange, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton('1', Colors.grey.shade800, Colors.white),
              numButton('2', Colors.grey.shade800, Colors.white),
              numButton('3', Colors.grey.shade800, Colors.white),
              numButton('-', Colors.orange, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton('0', Colors.grey.shade800, Colors.white),
              numButton('.', Colors.grey.shade800, Colors.white),
              numButton('/', Colors.grey.shade800, Colors.white),
              numButton('=', Colors.orange, Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
