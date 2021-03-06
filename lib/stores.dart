import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/addstore.dart';
import 'package:oja_barcode/editstore.dart';
import 'package:oja_barcode/storedata.dart';
import 'package:oja_barcode/storeproduct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class store extends StatefulWidget{
  String token;
  store({ Key key,@required this.token}) : super(key : key);
  @override
  _storeState createState() => _storeState(token);

}


class _storeState extends State<store> {
  String token;

  _storeState(this.token);
  String url = "http://ojaapi.pythonanywhere.com/getallmerchants/";

  List data;

  @override
  void initState(){
    super.initState();
    this.getjsondata();
    this.getallproducts();
  }


  Future<String> getallproducts() async{
    var response = await http.get("http://ojaapi.pythonanywhere.com/allproducts/",
      headers: {
        "Content-type": "application/json"
      },

    );

//    print(response.body);
    setState(() {
      var convertdatatojson = jsonDecode(response.body);
      var data = convertdatatojson;
      StoreData.stores_product = data;



    });
    return "Success";
  }






  Future<String> getjsondata() async{
    var response = await http.get(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + token
      },

    );

//    print(response.body);
    setState(() {
      var convertdatatojson = jsonDecode(response.body);
      data = convertdatatojson;
      StoreData.stores_data = data;


    });
    return "Success";
  }

  void deletealert(int storeid){
    _onDeleteAlertPressed(context,storeid);
  }

  Future<void> deleteproduct(int storeid) async{

    var url = "http://ojaapi.pythonanywhere.com/getmerchant/${storeid}";
    var response = await http.delete(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + token
      },
    );
    getjsondata();
    Navigator.pop(context);

  }


  _onDeleteAlertPressed(context,int storeid) {


    Alert(
      context: context,
      title: "OJA",
      desc: "Are You Sure You Want To Delete This Store.",
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
            deleteproduct(storeid);
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
          "OJA",
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
                builder: (context) => addstore(token:token),
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
                                                var storedata = {"token":token,"storeid":"${data[index]['id']}"};
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => storeproduct(storedata:storedata),
                                                ));

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
                                        var storedata = {'token':token,'store':data[index]};


                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => editstore(storedata:storedata),
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


//child:Text(data[index]['name']),
//onTap:(){
//                            var storedata = {"token":token,"storeid":"${data[index]['id']}"};
//                            Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => storeproduct(storedata:storedata),
//                            ));
//
//                          },