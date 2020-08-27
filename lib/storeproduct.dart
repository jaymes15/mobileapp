import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oja_barcode/addproducttostore.dart';
import 'dart:convert';
import 'package:oja_barcode/addstore.dart';
import 'package:oja_barcode/addproduct.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:oja_barcode/producttostore.dart';
import 'package:oja_barcode/messagepage.dart';
import 'stores.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class storeproduct extends StatefulWidget{
  var storedata;
  storeproduct({ Key key,@required this.storedata}) : super(key : key);
  @override
  _storeproductState createState() => _storeproductState(storedata);

}


class _storeproductState extends State<storeproduct> {
  var storedata;
  _storeproductState(this.storedata);
  List data;
  var storename;
  var name;
  var scanresult;
  var scanerror;
  var message ="";

  @override
  void initState(){
    super.initState();
    this.getstoreproductdata();
  }




  Future<String> getstoreproductdata() async{
    String store_id = storedata['storeid'];
    String url = "http://ojaapi.pythonanywhere.com/getallproductbymerchant/"+store_id;
    var response = await http.get(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + storedata['token']
      },

    );
    setState(() {
      var convertdatatojson = jsonDecode(response.body);
      data = convertdatatojson;
    });

    return "Success";
  }



  Future _scanQR() async{
    try{
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        scanresult = qrResult.rawContent;
      });
      searchBarcode(scanresult);
    }
    on PlatformException catch(ex){
      if(ex.code == BarcodeScanner.cameraAccessDenied){
        setState(() {
          scanerror = "Camera Permission Was Denied";
        });
      }else{
        setState(() {
          scanerror = "$ex";
        });
      }
    }catch(ex){
      setState(() {
        scanerror = "$ex";
      });
    }

  }

  Future searchBarcode(String scan) async{
    var url = "http://ojaapi.pythonanywhere.com/searchproductbybarcode/${scan}/${storedata['storeid']}";
    var response = await http.get(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + storedata['token']
      },
    );

    var convertdatatojson = jsonDecode(response.body);
    if(convertdatatojson.isEmpty){
      var data = {"token":storedata['token'],"storeid":"${storedata['storeid']}",'barcode':"${scan}"};
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => addproducttostore(storedata:data),
      ));
    }
    else{

              if(convertdatatojson['message'] == "product exist in store"){
                 message = convertdatatojson['message'];
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => messagepage(message:message),
                ));

              }
              else{

                var data = {"token":storedata['token'],"storeid":"${storedata['storeid']}" };
                print(data);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => producttostore(storedata:data,res:convertdatatojson),
                ));

              }



    }
  }

  void deletealert(int productid){
    _onDeleteAlertPressed(context,productid);
  }

  Future<void> deleteproduct(int productid) async{

    var url = "http://ojaapi.pythonanywhere.com/deleteproduct/${productid}";
    var response = await http.delete(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + storedata['token']
      },
    );
    getstoreproductdata();
    Navigator.pop(context);

  }



  _onDeleteAlertPressed(context,int productid) {


    Alert(
      context: context,
      title: "OJA",
      desc: "Are You Sure You Want To Delete This Product.",
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
            deleteproduct(productid);
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
      drawer: Drawer(
        child:ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('OJA ADD PRODUCT OPTIONS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Product Manually',
                style: TextStyle(
                  fontSize: 15.0
                ),
                ),
                onTap: () {
                  var data = {"token":storedata['token'],"storeid":"${storedata['storeid']}"};
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => addproduct(storedata:data),
                  ));

                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Add Product Using Scanner',
                  style: TextStyle(
                      fontSize: 15.0
                  ),
                ),
                onTap:  _scanQR,
              ),
              ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Back To OJA Stores',
                  style: TextStyle(
                      fontSize: 15.0
                  ),
                ),
                onTap:  (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => store(token:storedata['token']),
                  ));
                },
              ),

              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Close Drawer',
                  style: TextStyle(
                      fontSize: 15.0
                  ),
                ),
                onTap:  (){
                  Navigator.pop(context);
                },
              ),
            ],
        ),

      ),
      appBar: AppBar(
        title: Text(
          "OJA",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        centerTitle: true,
        elevation: 30.0,
        backgroundColor: Colors.blue,
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

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text
                                  (
                                    "Product Name:${data[index]['brand']}\nBarcode:${data[index]['barcode']}\nName:${data[index]['name']}\nStock Quantity:${data[index]['stock_quantity']}\nMin Stock Quantity:${data[index]['min_stock_quantity']}\nWeight:${data[index]['weight']}\nUnit:${data[index]['unit']}\nRegular Price:${data[index]['regular_price']}"
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
                                    onPressed: () {/* ... */},
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
                                      //deleteproduct(data[index]['id']);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
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

