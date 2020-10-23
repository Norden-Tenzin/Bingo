import 'dart:math';

// Ball
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

// Square
class Square {
  var squareNum;
  bool squareState = false;

  Square(this.squareNum);
}

class SquareListInit {
  var ticketlst = new List();

  List<dynamic> numlistmkr() {
    var lst = new List();
    for (int i = 1; i < 101; i++) {
      lst.add(i);
    }
    return lst;
  }

  List<dynamic> noisemkr() {
    var lst = new List();
    var rng = new Random();
    bool lstready = true;

    int checknoise(noiselst) {
      int count = 0;
      for (int i = 0; i < noiselst.length; i++) {
        if (noiselst[i] == "1") {
          count++;
        }
      }
      return count;
    }

    int countone(noiselst) {
      int count = 0;
      for (int i = 0; i < noiselst.length; i++) {
        if (count > 2) {
          break;
        } else {
          if (noiselst[i] == "1") {
            count++;
          } else if ((noiselst[i]) == "0") {
            count = 0;
          }
        }
      }
      return count;
    }

    int countzero(noiselst) {
      int count = 0;
      for (int i = 0; i < noiselst.length; i++) {
        if (count > 2) {
          break;
        } else {
          if (noiselst[i] == "0") {
            count++;
          } else if (noiselst[i] == "1") {
            count = 0;
          }
        }
      }
      return count;
    }

    while (lstready) {
      for (int i = 0; i < 9; i++) {
        int chance = rng.nextInt(9);
        if (chance > 4) {
          lst.add(1.toString());
        } else {
          lst.add(0.toString());
        }
      }
      if ((countone(lst) < 2) &&
          (countzero(lst) < 2) &&
          (checknoise(lst) == 5)) {
        return lst;
      }
      lst = new List();
    }
  }

  List<dynamic> lstmkr(numlst, noiselst) {
    var line = new List();
    var rng = new Random();
    var lstready = true;

    for (int i = 0; i < noiselst.length; i++) {
      if (noiselst[i] == "0") {
        line.add("");
      } else if (noiselst[i] == "1") {
        while (lstready) {
          int chance = rng.nextInt(numlst.length);
          if (numlst.contains(chance + 1)) {
            line.add(numlst[chance].toString());
            numlst.remove(chance + 1);
            lstready = false;
          }
        }
        lstready = true;
      }
    }
    return [line, numlst];
  }

  SquareListInit() {
    var numlst = numlistmkr();
    try {
      var noiselst = noisemkr();
      var output = lstmkr(numlst, noiselst);
      var line = output[0];
      for (int i = 0; i < line.length; i++) {
        ticketlst.add(new Square(line[i]));
      }
      line = [];

      var noiselst1 = noisemkr();
      var output1 = lstmkr(output[1], noiselst1);
      line = output1[0];
      for (int i = 0; i < line.length; i++) {
        ticketlst.add(new Square(line[i]));
      }
      line = [];

      var noiselst2 = noisemkr();
      var output2 = lstmkr(output1[1], noiselst2);
      line = output2[0];
      for (int i = 0; i < line.length; i++) {
        ticketlst.add(new Square(line[i]));
      }
      line = [];
    } catch (e) {
      print("error:  $e");
    }
  }
}
