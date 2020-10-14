import 'package:flutter/material.dart';
import 'package:oja_barcode/stores.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import 'editproduct.dart';

class SearchResult extends StatefulWidget {

  var storedata;
  SearchResult({ Key key,@required this.storedata}) : super(key : key);

  @override
  _SearchResultState createState() => _SearchResultState(storedata);
}

class _SearchResultState extends State<SearchResult> {

  var storedata;
  _SearchResultState(this.storedata);

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = storedata['product'];
  }

  void deletealert(int productid){
    _onDeleteAlertPressed(context,productid);
  }

  Future<void> deleteproduct(int productid) async{

    var url = "http://ojaapi.pythonanywhere.com/product/${productid}";
    var response = await http.delete(Uri.encodeFull(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Token " + storedata['token']
      },
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => store(token:storedata['token']),
    ));


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
      appBar: AppBar(
        title: Text("Searched Result"),
      ),
      body: ListView(
           children: <Widget>[
              Container(
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
                                      "Product Name:${data['brand']}\nBarcode:${data['barcode']}\nName:${data['name']}\nStock Quantity:${data['stock_quantity']}\nMin Stock Quantity:${data['min_stock_quantity']}\nWeight:${data['weight']}\nUnit:${data['unit']}\nRegular Price:${data['regular_price']}"
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
                                      onPressed: () {
                                        var productdata = {'token':storedata['token'],'product':data};
                                        print(productdata);

                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => editproduct(productdata:productdata),
                                        ));
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('DELETE',
                                        style:TextStyle(
                                          color:Colors.red,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onPressed: () {

                                        deletealert(data['id']);
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
              ),
            ]
        ),
    );

  }
}
