import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oja_barcode/storedata.dart';
import 'dart:convert';
import 'package:oja_barcode/stores.dart';
import 'package:oja_barcode/storeproduct.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'messagepage.dart';

class nullbarcode extends StatefulWidget{
  var storedata;
  nullbarcode({ Key key,@required this.storedata}) : super(key : key);
  @override
  _nullbarcodeState createState() => _nullbarcodeState(storedata);

}


class _nullbarcodeState extends State<nullbarcode> {

  var storedata;
  _nullbarcodeState(this.storedata);

  String token;
  var brand;
  var barcode;
  var name;
  var short_description;
  var stock_quantity;
  var min_stock_quantity;
  var weight;
  var unit;
  var regular_price;

  final TextEditingController _typeAheadController = TextEditingController();

  final TextEditingController _productnametypeAheadController =
  TextEditingController();


  var error = "Please Fill All Fields";


  String url = "http://ojaapi.pythonanywhere.com/product/";

  void producttostore() async{

    try {
      var response = await http.post(Uri.encodeFull("http://ojaapi.pythonanywhere.com/addproducttomerchant/"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Token " + storedata['token']
        },

        body: jsonEncode({


          "category_id": category,
          "merchant_id": int.parse(storedata['storeid']),
          "brand": "${brand}",
          "barcode": "N/A",
          "name": "${name}",
          "short_description": "${short_description}",
          "stock_quantity": stock_quantity,
          "min_stock_quantity": 2,
          "weight": weight,
          "unit": unit,
          "regular_price": regular_price

        }
        ),
      );

      var data = {
        "token": storedata['token'],
        "storeid": "${storedata['storeid']}"
      };
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => storeproduct(storedata: data),
      ));
    }catch(ex){
      setState(() {
        error = "${ex}";

      });
    }

  }




  List categories;
  String _selected;

  var category;
  void initState() {
    super.initState();

    this.getcategory();

  }

  void getcategory() async{
    String url = "http://ojaapi.pythonanywhere.com/getallcategory/";
    var response = await http.get(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + storedata['token']
      },

    );

    setState(() {
      var convertdatatojson = jsonDecode(response.body);
      categories = convertdatatojson;

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
              child:  Text("${error}"),
            ),
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                      hintText: "Brand",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(15.0)),
                  controller: this._typeAheadController),
              suggestionsCallback: (pattern) {
                List<String> data = List();
                for (var i in StoreData.stores_product) {
                  data.add(i['brand']);
                }
                data.retainWhere(
                        (s) => s.toLowerCase().contains(pattern.toLowerCase()));

                return data;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion;
                brand = this._typeAheadController.text;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child:DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child:DropdownButton<String>(
                    hint: new Text("Select Category"),
                    value: category,
                    isDense: true,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        category = newValue;
                      });

                    },
                    items:categories?.map((category) {
                      return new DropdownMenuItem<String>(
                        value: category['id'].toString(),
                        child: new Text(category['name'],
                            style: new TextStyle(color: Colors.black)),
                      );
                    })?.toList() ??
                        [],
                  ),
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
              child:   TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: InputDecoration(
                        hintText: "Name",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.all(15.0)),
                    controller: this._productnametypeAheadController),
                suggestionsCallback: (pattern) {
                  List<String> data = List();
                  for (var i in StoreData.stores_product) {
                    data.add(i['name']);
                  }
                  data.retainWhere(
                          (s) => s.toLowerCase().contains(pattern.toLowerCase()));

                  return data;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  this._productnametypeAheadController.text = suggestion;
                  name = this._productnametypeAheadController.text;
                },
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

                  stock_quantity = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Stock Quantity",
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

                  weight = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Weight",
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

                  unit = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Unit",
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

                  regular_price = _val;


                },
                style: TextStyle(
                  fontSize:20.0,
                ),
                decoration: InputDecoration(
                    hintText:"Regular Price",
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
                  brand = this._typeAheadController.text;
                  name = this._productnametypeAheadController.text;

                  producttostore();



                },
                color: Colors.indigoAccent,
                minWidth: 280.0,
                splashColor: Colors.red,
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,

                ),
                child:Text(
                    "Add Product To Store",
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

