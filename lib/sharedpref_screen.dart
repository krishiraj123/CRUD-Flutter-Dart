import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefPage extends StatefulWidget {
  const SharedPrefPage({super.key});

  @override
  State<SharedPrefPage> createState() => _SharedPrefPageState();
}

class _SharedPrefPageState extends State<SharedPrefPage> {
  String text = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }
  Future getValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      text = pref.getString("login")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController value = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Pref"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(text),
            CupertinoTextField(
              padding: EdgeInsets.all(15),
              controller: value,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString("login", value.text);
            }, child: Text("click"))
          ],
        ),
      )
    );
  }
}
