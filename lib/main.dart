import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AmoleGame()));

class AmoleGame extends StatefulWidget {
  @override
  _AmoleGameState createState() => _AmoleGameState();
}

class _AmoleGameState extends State<AmoleGame> {
  double m = 1.0, bal = 500.0;
  bool play = false;
  Timer? t;

  void start() {
    if (bal < 10) return;
    setState(() { bal -= 10; play = true; m = 1.0; });
    double crash = 1.0 + Random().nextDouble() * 5;
    t = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() { m += 0.05; if (m >= crash) { t?.cancel(); play = false; } });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("AMOLEBET"), backgroundColor: Colors.green, actions: [Center(child: Text("ETB ${bal.toStringAsFixed(2)}  "))]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${m.toStringAsFixed(2)}x", style: TextStyle(fontSize: 80, color: play ? Colors.red : Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: play ? () { t?.cancel(); setState(() { bal += 10 * m; play = false; }); } : start,
              style: ElevatedButton.styleFrom(backgroundColor: play ? Colors.orange : Colors.red, minimumSize: Size(200, 60)),
              child: Text(play ? "CASH OUT" : "BET 10 ETB", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}