import 'package:databaseapi/api/API.dart';
import 'package:flutter/material.dart';

class AddDetialAPIPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  const AddDetialAPIPage({super.key,this.id = "",this.name = "",this.image = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsGM3-nZ2yIDv3AdX3UQ2mFj441vCq-ukROA&s"});

  @override
  State<AddDetialAPIPage> createState() => _AddDetialAPIPageState();
}

class _AddDetialAPIPageState extends State<AddDetialAPIPage> {
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();
  List<dynamic>? data = null;

  Future<void> getData() async {
    data = await MyApi().getData();
  }

  bool? checkForUnique(String text) {
    for (var i in data!) {
      if (i['name'].toString().toLowerCase() == text.toLowerCase()) {
        return false;
      }
    }
    return true;
  }

  bool? checkForUniqueAndUpdate(String text) {
    for (var i in data!) {
      if (i['name'].toString() == text) {
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
    name.text = widget.name;
    image.text = widget.image;
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
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter the name";
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
                  hintText: "Name",
                  labelText: "Name"
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: image,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  hintText: "Image",
                  labelText: "Image"
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    if (widget.name.isEmpty && checkForUnique(name.text)!) {
                      MyApi().insertData({
                        "name": name.text,
                        "image":image.text,
                      });
                    }
                    if (widget.image.isNotEmpty &&
                        checkForUniqueAndUpdate(image.text)!) {
                      MyApi().updateData(widget.id, {
                        "name": name.text,
                        "image": image.text,
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                        Text(widget.name.isEmpty ? "Added" : "Updated")));
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(widget.name.isEmpty ? "Add" : "Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
