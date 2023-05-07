import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context) {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final ref= database.reference();
  final thresholdValue=TextEditingController();
  final pNameController= TextEditingController();
  final maxCap = TextEditingController();
  final productKey = TextEditingController();
  return new AlertDialog(


    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller:pNameController,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Enter product name',
              hintText: 'What is in the container?'
          ),
        ),
        TextField(
          controller:maxCap,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Enter the maximum capacity(kg)',
              hintText: 'How much it can hold?'
          ),
        ),
        TextField(
          controller:thresholdValue,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Threshold value(Kg)',
              hintText: 'When you want to get notified?'
          ),
        ),
        TextField(
          controller: productKey,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Enter variable code',
              hintText: 'Written in the box'
          ),
        )
      ],
    ),
    actions: <Widget>[
      new FlatButton(

        onPressed: () {
          String loc=productKey.text;
          ref.child('variableApp/$loc').set(<String, String>{
            "Product": "" + pNameController.text,
            "MaxCap": "" + maxCap.text,
            "ProductKey": "" + productKey.text,
            "threshold":""+ thresholdValue.text,
            "CurrentVal": "0.00",

          });
          //then
          pNameController.clear();
          maxCap.clear();
          productKey.clear();
          thresholdValue.clear();
          Navigator.of(context).pop();

        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Add'),
      ),
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
    ),
  );
}
