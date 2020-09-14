import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(App());
}

// Colors:
const text = const Color(0xffFFFFFF);
const background = const Color(0xff6F000A);
const primary = const Color(0xffCE0115);
const secondary = const Color(0xff92000E);

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
            appBar: AppBar(
              toolbarHeight: 50,
              backgroundColor: secondary,
              actions: [
                Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 15),
                    child: RaisedButton(
                        onPressed: reset,
                        color: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Icon(Icons.replay, color: text)))
              ],
            ),
            floatingActionButton: Container(
              width: 100,
              child: FloatingActionButton(
                onPressed: picker,
                child: Text("Next"),
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
              ),
            ),
            backgroundColor: background,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: background,
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
                            style: TextStyle(
                              color: text,
                              fontSize: 40,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            color: primary),
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
                        child: Text(
                          '$x',
                          style: TextStyle(
                            color: text,
                            fontSize: 15,
                          ),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 2,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: list[index].ballState == true
                              ? primary
                              : secondary,
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
                      color: secondary,
                      child: Container(
                        child: Text(
                          'Log',
                          style: TextStyle(
                            color: text,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    );
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
                        color: background,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 60),
                              child: Center(
                                child: Text(
                                  "$x",
                                  style: TextStyle(
                                    color: text,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              child: Center(
                                child: Text(
                                  "$logHolder",
                                  style: TextStyle(
                                    color: text,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 2,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: primary,
                              ),
                            ),
                          ],
                        ));
                  }, childCount: log.length),
                ),
              ],
            )));
  }
}
