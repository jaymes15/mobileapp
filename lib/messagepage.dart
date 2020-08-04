import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/stores.dart';

class messagepage extends StatefulWidget{
  String message;
  messagepage({ Key key,@required this.message}) : super(key : key);
  @override
  _messagepageState createState() => _messagepageState(message);

}


class _messagepageState extends State<messagepage> {

  var message;
  _messagepageState(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OJA",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        elevation: 30.0,
        backgroundColor: Colors.blue,



      ),
      body:  Padding(
    padding: EdgeInsets.all(20.0),
    child: Center(
      child: Text(message),
    ),
      ),
    );
  }
}
