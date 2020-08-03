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
    var url = "http://ojaapi.pythonanywhere.com/searchproductbybarcode/"+scan;
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


            var data = {"token":storedata['token'],"storeid":"${storedata['storeid']}" };
            print(data);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => producttostore(storedata:data,res:convertdatatojson),
            ));


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
        actions: <Widget>[
          IconButton(
            onPressed: (){
              var data = {"token":storedata['token'],"storeid":"${storedata['storeid']}"};
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => addproduct(storedata:data),
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
                      Text(message),


                      Card(
                          child: Container(
                            child:Text("Product Name:${data[index]['brand']}\nBarcode:${data[index]['barcode']}"),
                            padding: EdgeInsets.all(20.0),
                          )
                      ),
                    ],
                  )
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  _scanQR,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

