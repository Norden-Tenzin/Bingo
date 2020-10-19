import 'package:flutter/material.dart';
import "colors.dart";
import 'dart:math';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  var clicked = true;

  @override
  Widget build(BuildContext context) {
    void press() {
      setState(() {
        clicked = !clicked;
      });
    }

    return MaterialApp(
      home: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            title: Text("Ticket"),
            toolbarHeight: 50,
            backgroundColor: secondary,
            leading: Container(
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: text),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: GridView.count(
              crossAxisCount: 9,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              shrinkWrap: true,
              children: List.generate(27, (index) {
                return Center(
                    child: Container(
                        margin: EdgeInsets.only(left: 5, top: 10, right: 5),
                        child: Center(
                            child: FlatButton(
                          height: 100,
                          onPressed: press,
                          child: Text(
                            "2",
                            style: TextStyle(color: text, fontSize: 30),
                          ),
                        )),
                        decoration: BoxDecoration(
                          color: (clicked == true ? primary : secondary),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        )));
              }))),
    );
  }
}
