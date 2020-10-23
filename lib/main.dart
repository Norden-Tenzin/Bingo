import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import "colors.dart";
import "numPicker.dart";
import 'routes.dart';
import 'home.dart';
import 'numPicker.dart';
import 'ticketPage.dart';

void main() {
  runApp(App());
}

enum ScreenOrientation {
  portraitOnly,
  landscapeOnly,
  rotating,
}

// This function helps to build RouteSettings object for the orientation
RouteSettings rotationSettings(
    RouteSettings settings, ScreenOrientation rotation) {
  return RouteSettings(name: settings.name, arguments: rotation);
}

// NavigatorObserver which tracks the orientation
class NavigatorObserverWithOrientation extends NavigatorObserver {
  @override
  void didPop(Route route, Route previousRoute) {
    if (previousRoute.settings.arguments is ScreenOrientation) {
      _setOrientation(previousRoute.settings.arguments);
    } else {
      // Portrait-only is the default option
      _setOrientation(ScreenOrientation.portraitOnly);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (route.settings.arguments is ScreenOrientation) {
      _setOrientation(route.settings.arguments);
    } else {
      _setOrientation(ScreenOrientation.portraitOnly);
    }
  }
}

// Set orientation
void _setOrientation(ScreenOrientation orientation) {
  List<DeviceOrientation> orientations;
  switch (orientation) {
    case ScreenOrientation.portraitOnly:
      orientations = [
        DeviceOrientation.portraitUp,
      ];
      break;
    case ScreenOrientation.landscapeOnly:
      orientations = [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
    case ScreenOrientation.rotating:
      orientations = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
  }
  SystemChrome.setPreferredOrientations(orientations);
}

class App extends StatelessWidget {
  final _observer = NavigatorObserverWithOrientation();

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.home) {
      return MaterialPageRoute(builder: (context) => Home());
    } else if (settings.name == AppRoutes.numgen) {
      return MaterialPageRoute(
        builder: (context) => NumPicker(),
        settings: rotationSettings(settings, ScreenOrientation.portraitOnly),
      );
    } else if (settings.name == AppRoutes.ticket) {
      return MaterialPageRoute(
        builder: (context) => TicketPage(),
        settings: rotationSettings(settings, ScreenOrientation.portraitOnly),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Orientation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _onGenerateRoute,
      navigatorObservers: [_observer],
    );
  }
}
