import 'package:flutter/material.dart';

import 'package:newsapp/standarts.dart' as standards;
import 'package:flutter/services.dart';
/// Flutter code sample for [TextField].

class ObscuredTextFieldSample extends StatelessWidget {
  String title;
  dynamic myController;
  dynamic cap;
  bool bigBox;
  bool edit;


  ObscuredTextFieldSample(this.title, this.myController, this.cap, this.bigBox, this.edit);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(standards.pading2),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          style: TextStyle(color: standards.black),
          enabled: edit,
          inputFormatters: [
                LengthLimitingTextInputFormatter(cap),
          ],
          keyboardType: TextInputType.multiline,
          minLines:bigBox? 5 : 1,
          maxLines:bigBox? 10 : 2,
          controller: myController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: title,
          ),
        ),
      ),
    );
  }
}


