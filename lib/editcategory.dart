import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oja_barcode/categories.dart';
import 'dart:convert';
import 'package:oja_barcode/stores.dart';

class editcategory extends StatefulWidget{
  var categorydata;
  editcategory({ Key key,@required this.categorydata}) : super(key : key);
  @override
  _editcategoryState createState() => _editcategoryState(categorydata);

}


class _editcategoryState extends State<editcategory> {

  _editcategoryState(this.categorydata);
  var categorydata;
  var categoryname;
  var error = "";

  void initState(){
    print(categorydata['category']);

    categoryname = categorydata['category']['name'];
  }



  Future<String> editstoredata() async{
    String url = "http://ojaapi.pythonanywhere.com/getcategories/${categorydata['category']['id']}";

    var response = await http.put(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + categorydata['token']
      },
      body: jsonEncode({
        "name": "${categoryname}",
        "image":"wwww",
        "enabled": "Yes"

      }
      ),
    );
    
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => categories(token:categorydata['token']),
    ));




    return "Success";
  }


  void displayerror(){

    setState(() {
      error = "Please Fill All Fields";
    });
  }
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
        child:ListView(
          children: <Widget>[
            Center(
              child:  Text("Please Fill All Fields"),
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText: "Category Name",
                labelStyle: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              initialValue: categorydata['category']['name'],
              onChanged: (_value){
                categoryname = _value;
              },
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: MaterialButton(
                onPressed: (){

                  editstoredata();

                },
                color: Colors.indigoAccent,
                minWidth: 280.0,
                splashColor: Colors.red,
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,

                ),
                child:Text(
                    "Edit Category",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,

                    )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
