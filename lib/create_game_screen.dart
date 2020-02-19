import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGameScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Game')
      ),
      body: Center(
        child: Text("Create game!")
      ),
    );
    
  }

}