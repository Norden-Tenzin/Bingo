import 'package:flutter/material.dart';
import 'colors.dart';
import 'dart:math';
import "ticket.dart";

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  int ticketcount = 0;
  var clicked = true;

  @override
  Widget build(BuildContext context) {
    void press() {
      setState(() {
        clicked = !clicked;
      });
    }

    void addticket() {
      setState(() {
        ticketcount++;
      });
    }

    List<Widget> tickets =
        new List.generate(ticketcount, (index) => new Ticket());

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
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  icon: Icon(
                    Icons.plus_one,
                    color: text,
                  ),
                  onPressed: addticket)
            ],
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: tickets,
          )),
    );
  }
}
