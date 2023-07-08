import 'package:flutter/material.dart';

import 'package:newsapp/standarts.dart' as standards;
import 'package:flutter/services.dart';
/// Flutter code sample for [TextField].

class ObscuredTextFieldSample extends StatelessWidget {
  String title;
  dynamic myController;
  dynamic cap;
  bool bigBox;


  ObscuredTextFieldSample(this.title, this.myController, this.cap, this.bigBox);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(standards.pading2),
      child: SizedBox(
        width: double.maxFinite,
        child: TextField(
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


