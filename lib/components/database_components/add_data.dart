import 'package:databaseapi/database/database.dart';
import 'package:flutter/material.dart';

class AddDetailPage extends StatefulWidget {
  final int index;
  final String value;

  const AddDetailPage({super.key, this.index = -1, this.value = ""});

  @override
  State<AddDetailPage> createState() => _AddDetailPageState();
}

class _AddDetailPageState extends State<AddDetailPage> {
  TextEditingController input = TextEditingController();
  List<Map<String, dynamic>>? data = null;

  Future<void> getData() async {
    data = await MyDatabase().getData();
  }

  bool? checkForUnique(String text) {
    for (var i in data!) {
      if (i['title'].toString().toLowerCase() == text.toLowerCase()) {
        return false;
      }
    }
    return true;
  }

  bool? checkForUniqueAndUpdate(String text) {
    for (var i in data!) {
      if (i['title'].toString() == text) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    input.text = widget.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: input,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter the value";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    if (widget.value.isEmpty && checkForUnique(input.text)!) {
                      MyDatabase().insertData({
                        "title": input.text,
                      });
                    }
                    if (widget.value.isNotEmpty &&
                        checkForUniqueAndUpdate(input.text)!) {
                      MyDatabase().updateData(widget.index, {
                        "title": input.text,
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(widget.value.isEmpty ? "Added" : "Updated")));
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(widget.value.isEmpty ? "Add" : "Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
