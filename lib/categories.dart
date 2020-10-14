import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/addstore.dart';
import 'package:oja_barcode/editcategory.dart';
import 'package:oja_barcode/storedata.dart';
import 'package:oja_barcode/storeproduct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'addcategory.dart';


class categories extends StatefulWidget{
  String token;
  categories({ Key key,@required this.token}) : super(key : key);
  @override
  _categoriesState createState() => _categoriesState(token);

}


class _categoriesState extends State<categories> {
  String token;

  _categoriesState(this.token);
  String url = "http://ojaapi.pythonanywhere.com/getallmerchants/";

  List data;

  @override
  void initState(){
    super.initState();
    this.getcategory();
  }

  void getcategory() async{
    String url = "http://ojaapi.pythonanywhere.com/getallcategory/";
    var response = await http.get(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + token
      },

    );

    setState(() {
      var convertdatatojson = jsonDecode(response.body);
      data = convertdatatojson;
      StoreData.categories = data;

    });

  }
  void deletealert(int storeid){
    _onDeleteAlertPressed(context,storeid);
  }

  Future<void> deletecategory(int categoryid) async{

    var url = "http://ojaapi.pythonanywhere.com/getcategories/${categoryid}";
    var response = await http.delete(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + token
      },
    );
    getcategory();

    Navigator.pop(context);

  }


  _onDeleteAlertPressed(context,int categoryid) {


    Alert(
      context: context,
      title: "OJA",
      desc: "Are You Sure You Want To Delete This Category.",
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          color: Colors.red,
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async{
            deletecategory(categoryid);
          },
          width: 120,
        )
      ],

    )
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "OJA Categories",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        elevation: 30.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => addcategory(token:token),
              ));

            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[



                      GestureDetector(
                        onTap:(){



                        },
                        child: Card(

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(data[index]['name'],
                                    style:TextStyle(

                                      fontSize: 20.0,
                                    ),
                                  ),

                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('EDIT',
                                        style:TextStyle(

                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        var categorydata = {'token':token,'category':data[index]};


                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => editcategory(categorydata:categorydata),
                                        ));
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('DELETE',
                                        style:TextStyle(
                                          color:Colors.red,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        deletealert(data[index]['id']);

                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  )
              ),
            );
          }
      ),
    );
  }
}


