import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spades/routes.dart';

class GameListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Game List')
      ),
      body: Center(
        child: Text("game list")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateGameRoute);
        },
        tooltip: 'Create Game',
        child: Icon(Icons.add),
      ),
    );
    
  }
}