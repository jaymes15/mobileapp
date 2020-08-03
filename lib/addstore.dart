import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/stores.dart';

class addstore extends StatefulWidget{
  String token;
  addstore({ Key key,@required this.token}) : super(key : key);
  @override
  _addstoreState createState() => _addstoreState(token);

}


class _addstoreState extends State<addstore> {


  String token;
  String storename;
  String storemail;
  String phonenum;
  String contactname;
  String address;
  String city;
  String state;
  String zip;
  String country;
  String countrycode;

  _addstoreState(this.token);
  String url = "http://ojaapi.pythonanywhere.com/getallmerchants/";

  Future<String> addnewstoredata() async{

    var response = await http.post(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + token
      },
      body: jsonEncode({
        "name": "${storename}",
        "email": "${storemail}",
        "phone": "${phonenum}",
        "contact_name": "${contactname}",
        "address": "${address}",
        "city": "${city}",
        "state": "${state}",
        "zip": "${zip}",
        "country": "${country}",
        "country_code":"${countrycode}",
        "enabled": "Yes"
      }
      ),
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => store(token:token),
    ));




    return "Success";
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
            Text(""),
            TextField(
              autocorrect:true,
              autofocus:true,
              onChanged:(_val){

                storename = _val;


              },
              style: TextStyle(
                fontSize:20.0,
              ),
              decoration: InputDecoration(
                  hintText:"Store Name",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.all(15.0)
              ),

            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  storemail = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Store Mail",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  phonenum = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Phone Number",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  contactname = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Contact Name",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  address = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Address",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  city = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"City",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  state = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"State",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  country = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Country",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  countrycode = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Country Code",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextField(
                autocorrect:true,
                autofocus:true,

                onChanged:(_val){

                  zip = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Zip",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(15.0)
                ),

              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: MaterialButton(
                onPressed: (){
                  if (
                  country.isNotEmpty && countrycode.isNotEmpty && zip.isNotEmpty && storename.isNotEmpty && storemail.isNotEmpty && country.isNotEmpty && countrycode.isNotEmpty && zip.isNotEmpty && phonenum.isNotEmpty && state.isNotEmpty
                  ) {
                    addnewstoredata();
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
