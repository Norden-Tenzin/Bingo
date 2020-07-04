import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: Container(
              width: 100,
              child: FloatingActionButton(
              onPressed: () {},

              child: Text("Next >"),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),),
            ),
            ),
            
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
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
                            "num",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            color: Colors.red),
                      )),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: Text('List Item $index'),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
