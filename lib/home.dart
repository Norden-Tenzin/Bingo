import 'package:flutter/material.dart';
import "colors.dart";
import "routes.dart";
import 'dart:math';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Center(child: Text("Tambola")),
          toolbarHeight: 50,
          backgroundColor: secondary,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 60,
                margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height) / 4),
                child: RaisedButton(
                  color: secondary,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.numgen);
                  },
                  child: Text("Number Generator",
                      style: TextStyle(fontSize: 18, color: text)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 60,
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: secondary,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.ticket);
                  },
                  child: Text("Tickets",
                      style: TextStyle(fontSize: 18, color: text)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
