import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/addstore.dart';
import 'package:oja_barcode/storeproduct.dart';


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
    });
    return "Success";
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

                      Card(
                        child: new InkWell(
                          onTap:(){
                            var storedata = {"token":token,"storeid":"${data[index]['id']}"};
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => storeproduct(storedata:storedata),
                            ));

                          },
                          child: Container(
                            child:Text(data[index]['name']),
                            padding: EdgeInsets.all(20.0),
                          ),

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
