import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oja_barcode/storedata.dart';
import 'dart:convert';
import 'package:oja_barcode/stores.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class addstore extends StatefulWidget{
  String token;
  addstore({ Key key,@required this.token}) : super(key : key);
  @override
  _addstoreState createState() => _addstoreState(token);

}


class _addstoreState extends State<addstore> {


  String token;
  String storename = "";
  String storemail = "";
  String phonenum = "";
  String contactname = "";
  String address = "";
  String city = "";
  String state = "";
  String zip = "";
  String country = "";
  String countrycode = "";
  var latitude;
  var longitude;
var error = "";
  _addstoreState(this.token);


  final TextEditingController _typeAheadController = TextEditingController();


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
        "latitude":"$latitude",
        "longitude":"$longitude",
        "enabled": "Yes"
      }
      ),
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => store(token:token),
    ));




    return "Success";
  }


  void displayerror(){
    print("hello");
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
                      hintText:"Store Name",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(15.0)
                  ),
                  controller: this._typeAheadController
              ),
              suggestionsCallback: (pattern)  {
                List<String> data = List();
                for (var i in StoreData.stores_product) {
                  if(data.contains(i['name'])){

                  }else{
                    data.add(i['name']);
                  }

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
                storename = this._typeAheadController.text;

              },
            ),





//            TextField(
//
//
//              autocorrect:true,
//              autofocus:true,
//              onChanged:(_val){
//
//                storename = _val;
//
//
//              },
//              style: TextStyle(
//                fontSize:20.0,
//              ),
//              decoration: InputDecoration(
//                  hintText:"Store Name",
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
                onPressed: () async{
                  storename = this._typeAheadController.text;
                  print(storename);

                  if (
                  country.isNotEmpty && countrycode.isNotEmpty && zip.isNotEmpty && storename.isNotEmpty && storemail.isNotEmpty && country.isNotEmpty && countrycode.isNotEmpty && zip.isNotEmpty && phonenum.isNotEmpty && state.isNotEmpty
                  ) {
                    final query = address;
                    var addresses = await Geocoder.local.findAddressesFromQuery(query);
                    var first = addresses.first;
                    latitude = first.coordinates.latitude;
                    longitude = first.coordinates.longitude;

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
