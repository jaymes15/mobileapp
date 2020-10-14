import 'package:flutter/material.dart';
import 'package:oja_barcode/storedata.dart';

import 'addproduct.dart';
import 'nullbarcode.dart';


Widget optionsBottomSheet(BuildContext context){

  return Container(
    color: Color(0xff757575),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(20.0) ,
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(

          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product Manually',
                style: TextStyle(
                    fontSize: 15.0
                ),
              ),
              onTap: () {
                var data = StoreData.data;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => addproduct(storedata:data),
                ));

              },
            ),
            Divider(
              height: 20.0,
              thickness: 1.0,
            ),

            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product Manually(N/A)',
                style: TextStyle(
                    fontSize: 15.0
                ),
              ),
              onTap: () {
                var data = StoreData.data;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => nullbarcode(storedata:data),
                ));

              },
            ),
          ],
        ),
      ),
    ),
  );

}