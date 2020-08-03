import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oja_barcode/stores.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OJA",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApi(),
    );
  }
}
class MyApi extends StatefulWidget {
  @override
  _MyApiState createState() => _MyApiState();
}

class _MyApiState extends State<MyApi> {

  String username;
  String password;
  String token;
  String expiry;
  String error = "";



  Future<void> logindata() async {
    var res = await http.post("http://ojaapi.pythonanywhere.com/api/login/",
        body: jsonEncode({"username": "${username}", "password": "${password}"}),
        headers: {'Content-type': 'application/json'}
    );
    var response = jsonDecode(res.body);
    if(response['token'].toString().isNotEmpty && response['expiry'].toString().isNotEmpty){
      setState(() {
        token = response['token'].toString();
        expiry =response['expiry'].toString();
        error;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => store(token:token),
      ));
    }else{

      setState(() {
        error = response['non_field_errors'].toString();
      });
    }


  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "OJA",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        elevation: 30.0,
        backgroundColor: Colors.blue,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(error),
          Container(
            width: 400,
            height: 300,
            child:Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child:Card(
                color: Colors.white,
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical:20.0,
                        horizontal: 10.0,
                      ),
                      child:  TextField(
                        autocorrect:true,
                        autofocus:true,
                        onChanged:(_val){

                          username = _val;


                        },
                        style: TextStyle(
                          fontSize:20.0,
                        ),
                        decoration: InputDecoration(
                            hintText:"Username",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(15.0)
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical:15.0,
                        horizontal: 10.0,
                      ),
                      child:
                      TextField(
                        autocorrect:true,
                        obscureText: true,
                        autofocus:true,
                        onChanged:(_val){

                          password = _val;


                        },
                        style: TextStyle(
                          fontSize:20.0,
                        ),
                        decoration: InputDecoration(
                            hintText:"Password",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(15.0)
                        ),

                      ),
                    ),
                    MaterialButton(
                      onPressed: (){

                        if (username.isNotEmpty && password.isNotEmpty){
                          logindata();
                        }
                        else{

                        }
                      },
                      color: Colors.brown,
                      minWidth: 320.0,
                      splashColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,

                      ),
                      child:Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,

                          )
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}