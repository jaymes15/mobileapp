import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oja_barcode/categories.dart';
import 'package:oja_barcode/storedata.dart';
import 'dart:convert';
import 'package:oja_barcode/stores.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class addcategory extends StatefulWidget{
  String token;
  addcategory({ Key key,@required this.token}) : super(key : key);
  @override
  _addcategoryState createState() => _addcategoryState(token);

}


class _addcategoryState extends State<addcategory> {


  String token;
  String name;
  var error = "";
  _addcategoryState(this.token);
  String url = "http://ojaapi.pythonanywhere.com/getallcategories/";

  final TextEditingController _typeAheadController = TextEditingController();

  Future<String> addnewcatedorydata() async{
    print(name);
    var response = await http.post(Uri.encodeFull(url),

      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + token
      },
      body: jsonEncode({
        "name": "${name}",
        "image":"wwww",
        "enabled": "Yes"
      }
      ),
    );

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => categories(token:token),
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

            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  style: TextStyle(
                    fontSize:20.0,

                  ),
                  decoration: InputDecoration(
                      hintText:"Name",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(15.0)
                  ),
                  controller: this._typeAheadController
              ),
              suggestionsCallback: (pattern)  {
                List<String> data = List();
                for(var i in StoreData.categories){
                  data.add(i['name']);
                }
                data.retainWhere((s) =>   s.toLowerCase().contains(pattern.toLowerCase()));

                return data;
              },
              itemBuilder: (context, suggestion) {


                return ListTile(

                  title: Text(suggestion),

                );
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion;
                name = this._typeAheadController.text;

              },
            ),

//            TextField(
//              autocorrect:true,
//              autofocus:true,
//              onChanged:(_val){
//
//                name = _val;
//
//
//              },
//              style: TextStyle(
//                fontSize:20.0,
//              ),
//              decoration: InputDecoration(
//                  hintText:"Category Name",
//                  border: InputBorder.none,
//                  filled: true,
//                  fillColor: Colors.grey[200],
//                  contentPadding: EdgeInsets.all(15.0)
//              ),
//
//            ),

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: MaterialButton(
                onPressed: (){
                  name = this._typeAheadController.text;

                  if(name != null){
                    addnewcatedorydata();
                  }else{


                  }
                },
                color: Colors.indigoAccent,
                minWidth: 280.0,
                splashColor: Colors.red,
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,

                ),
                child:Text(
                    "Add Store",
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
