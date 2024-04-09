import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUI{
  customTf(String text ,TextEditingController controller,){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        maxLines: null,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none
        ),
      ),
    );
  }
  customTf1(String text ,TextEditingController controller,){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        maxLines: null,
        // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none
        ),
      ),
    );
  }
}