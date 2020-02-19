import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:spades/game_list_screen.dart';
import 'package:spades/create_game_screen.dart';
import 'package:spades/undefined_route_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (_) => GameListScreen());
    case CreateGameRoute:
      return MaterialPageRoute(builder: (_) => CreateGameScreen());
    default:
      return MaterialPageRoute(builder: (_) => UndefinedRouteScreen(name: settings.name));
  }
}

const String HomeRoute = '/';
const String CreateGameRoute = 'create-game';