import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(App());
}

class Ball {
  int ballNum;
  bool ballState = false;

  Ball(this.ballNum);
}

class BallListInit {
  var ballList = [];
  BallListInit() {
    for (int i = 0; i < 100; i++) {
      ballList.add(new Ball(i + 1));
    }
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var templist = BallListInit();
  var list = [];
  var log = [];

  @override
  Widget build(BuildContext context) {
    //calc

    list.addAll(templist.ballList);

    void picker() {
      bool hit = false;
      var rng = new Random();
      var random = rng.nextInt(100);
      while (!hit && log.length < 100) {
        if (list[random].ballState == false) {
          setState(() {
            list[random].ballState = true;
            log.add(random + 1);
          });
          hit = !hit;
        } else {
          random = rng.nextInt(100);
        }
      }
      hit = false;
    }

    void reset() {
      int i = 0;
      while (i < 100) {
        setState(() {
          list[i].ballState = false;
          log = [];
        });

        i++;
      }
    }

    var curr = 0;
    var len = log.length - 1;

    if (len < 0) {
      curr = 0;
    } else {
      curr = log[len];
    }

    return MaterialApp(
        home: Scaffold(
            floatingActionButton: Container(
              width: 100,
              child: FloatingActionButton(
                onPressed: picker,
                child: Text("Next >"),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  bottom: PreferredSize(
                    // Add this code
                    preferredSize: Size.fromHeight(60.0), // Add this code
                    child: Text(''), // Add this code
                  ),
                  pinned: true,
                  expandedHeight: 180.0,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            "$curr",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            color: Colors.red),
                      )),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      int x = index + 1;

                      return Container(
                        alignment: Alignment.center,
                        child: Text('$x'),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 2,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: list[index].ballState == true
                              ? Colors.red
                              : Colors.grey,
                        ),
                      );
                    },
                    childCount: 100,
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.center,
                        color: Colors.grey[600],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Log:',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              FlatButton(
                                child: Text("Reset"),
                                onPressed: reset,
                                color: Colors.red,
                              ),
                            ]));
                  }, childCount: 1),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    int x = index + 1;
                    int logHolder = log[index];
                    return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        color: Colors.grey[300],
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(right: 50),
                              child: Center(
                                child: Text(
                                  "$x",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500].withOpacity(0.5),
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.grey[500],
                              ),
                            ),
                            Container(child: Text("$logHolder")),
                          ],
                        ));
                  }, childCount: log.length),
                ),
              ],
            )));
  }
}
