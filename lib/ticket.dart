import 'package:bingo/colors.dart';
import 'package:flutter/material.dart';
import 'helper.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  var ticketholder = new SquareListInit();
  var ticketState = true;
  @override
  Widget build(BuildContext context) {
    void click(index) {
      print("ijdijawd");
      setState(() {
        if (ticketholder.ticketlst[index].squareNum != "") {
          ticketholder.ticketlst[index].squareState =
              !ticketholder.ticketlst[index].squareState;
        }
      });
    }

    void reroll() {
      setState(() {
        ticketholder = new SquareListInit();
      });
    }

    void close() {
      setState(() {
        ticketState = false;
      });
    }

    return ticketState
        ? Container(
            height: 187,
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Colors.black,
                        ),
                        onPressed: reroll),
                    IconButton(
                        icon: Icon(
                          Icons.clear_sharp,
                          color: Colors.black,
                        ),
                        onPressed: close)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: GridView.count(
                      crossAxisCount: 9,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      shrinkWrap: true,
                      children: List.generate(27, (index) {
                        var sqaureNum = ticketholder.ticketlst[index].squareNum;
                        var sqaureState =
                            ticketholder.ticketlst[index].squareState;
                        return InkWell(
                            onTap: () => click(index),
                            child: Container(
                                margin: EdgeInsets.all(1),
                                child: Center(
                                  child: Text(
                                    "$sqaureNum",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: (sqaureState ? squareon : squareoff),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                )));
                      })),
                )
              ],
            ))
        : Container();
  }
}
