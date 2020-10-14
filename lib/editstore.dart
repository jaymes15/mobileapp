import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/stores.dart';
import 'package:geocoder/geocoder.dart';

class editstore extends StatefulWidget{
  var storedata;
  editstore({ Key key,@required this.storedata}) : super(key : key);
  @override
  _editstoreState createState() => _editstoreState(storedata);

}


class _editstoreState extends State<editstore> {

  _editstoreState(this.storedata);
  var storedata;
  var storename = "";
  var storemail = "";
  var phonenum = "";
  var contactname = "";
  var address = "";
  var city = "";
  var state = "";
  var zip = "";
  var country = "";
  var latitude;
  var longitude;
  var countrycode = "";
  var error = "";

  void initState(){

    storename = storedata['store']['name'];
    storemail = storedata['store']['email'];
    phonenum = storedata['store']['phone'];
    contactname = storedata['store']['contact_name'];
    address = storedata['store']['address'];
    city = storedata['store']['city'];
    state = storedata['store']['state'];
    zip = storedata['store']['zip'];
    country = storedata['store']['country'];
    countrycode = storedata['store']['country_code'];
  }



  Future<String> editstoredata() async{
    print(latitude);
    String url = "http://ojaapi.pythonanywhere.com/getmerchant/${storedata['store']['id']}";

    var response = await http.put(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + storedata['token']
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
    print(response.body);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => store(token:storedata['token']),
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
                labelText: "Store Name",
                labelStyle: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              initialValue: storedata['store']['name'],
              onChanged: (_value){
                storename = _value;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child:  TextFormField(
                decoration: InputDecoration(
                  labelText: "Store Mail",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['email'],
                onChanged: (_value){
                  storemail = _value;

                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child:  TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['phone'],
                onChanged: (_value){
                  phonenum = _value;

                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child:  TextFormField(
                decoration: InputDecoration(
                  labelText: "Contact Name",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['contact_name'],
                onChanged: (_value){
                  contactname = _value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child:  TextFormField(
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['address'],
                onChanged: (_value){
                  address = _value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child:  TextFormField(
                decoration: InputDecoration(
                  labelText: "City",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['city'],
                onChanged: (_value){
                  city = _value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "State",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['state'],
                onChanged: (_value){
                  state = _value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Country",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['country'],
                onChanged: (_value){
                  country = _value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Country Code",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['country_code'],
                onChanged: (_value){
                  countrycode = _value;

                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Zip",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: storedata['store']['zip'],
                onChanged: (_value){
                  zip = _value;

                },
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: MaterialButton(
                onPressed: () async{


                  // From a query
                  final query = address;
                  var addresses = await Geocoder.local.findAddressesFromQuery(query);
                  var first = addresses.first;
                  
                  latitude = first.coordinates.latitude;
                  longitude = first.coordinates.longitude;


                  editstoredata();

                },
                color: Colors.indigoAccent,
                minWidth: 280.0,
                splashColor: Colors.red,
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,

                ),
                child:Text(
                    "Edit Store",
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
