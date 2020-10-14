import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oja_barcode/stores.dart';
import 'package:oja_barcode/storeproduct.dart';

import 'messagepage.dart';

class editproduct extends StatefulWidget{
  var productdata;
  editproduct({ Key key,@required this.productdata}) : super(key : key);
  @override
  _editproductState createState() => _editproductState(productdata);

}


class _editproductState extends State<editproduct> {

  var productdata;
  _editproductState(this.productdata);

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


  var error = "Please Fill All Fields";


  String url = "http://ojaapi.pythonanywhere.com/product/";

  void editproducttostore() async{

    try {
      var response = await http.put(Uri.encodeFull("http://ojaapi.pythonanywhere.com/product/${productdata['product']['id']}"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Token " + productdata['token']
        },

        body: jsonEncode({


            "category_id": category,
            "merchant_id": productdata['product']['merchant_id'],
            "brand": "${brand}",
            "barcode": "${barcode}",
            "name": "${name}",
            "short_description": "${short_description}",
            "stock_quantity": stock_quantity,
            "min_stock_quantity": min_stock_quantity,
            "weight": weight,
            "unit": unit,
            "regular_price": regular_price

        }
        ),
      );
      
      var data = {
        "token": productdata['token'],
        "storeid": "${productdata['product']['merchant_id']}"
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

         brand = productdata['product']['brand'];
         barcode = productdata['product']['barcode'];
        name = productdata['product']['name'];
        short_description = productdata['product']['short_description'];
        stock_quantity = productdata['product']['stock_quantity'];
        min_stock_quantity = productdata['product']['min_stock_quantity'];
        weight = productdata['product']['weight'];
        unit = productdata['product']['unit'];
        regular_price = productdata['product']['regular_price'];
        if(productdata['product']['category_id'] != null){
          category=  productdata['product']['category_id'].toString();
        }
  }

  void getcategory() async{
    String url = "http://ojaapi.pythonanywhere.com/getallcategory/";
    var response = await http.get(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + productdata['token']
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
            TextFormField(
              decoration: InputDecoration(
                labelText: "Brand",
                labelStyle: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              initialValue: productdata['product']['brand'],
              onChanged: (_value){
                brand = _value;


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
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 0.0
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Barcode",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['barcode'],
                onChanged: (_value){
                  barcode = _value;

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
                  labelText: "Name",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['name'],
                onChanged: (_value){
                  name = _value;

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
                  labelText: "Stock Quantity",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['stock_quantity'].toString(),
                onChanged: (_value){
                  stock_quantity = _value;

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
                  labelText: "Min Stock Quantity",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['min_stock_quantity'].toString(),
                onChanged: (_value){
                  min_stock_quantity = _value;

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
                  labelText: "Weight",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['weight'].toString(),
                onChanged: (_value){
                  weight = _value;
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
                  labelText: "Unit",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['unit'].toString(),
                onChanged: (_value){
                  unit = _value;

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
                  labelText: "Regular Price",
                  labelStyle: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                initialValue: productdata['product']['regular_price'].toString(),
                onChanged: (_value){
                  regular_price = _value;


                },
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: MaterialButton(
                onPressed: (){

                    editproducttostore();




                },
                color: Colors.indigoAccent,
                minWidth: 280.0,
                splashColor: Colors.red,
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,

                ),
                child:Text(
                    "Edit Product",
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

