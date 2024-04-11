import 'package:databaseapi/components/database_components/add_data.dart';
import 'package:databaseapi/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddDetailPage())).then((value){
          setState(() {});
        });
      },child: Icon(Icons.add),),
        appBar: AppBar(
          title: Text("Display Page"),
        ),
        body: FutureBuilder(
          future: MyDatabase().copyPasteAssetFileToRoot(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: MyDatabase().getData(),
                builder: (context, snapshot1) {
                  if (snapshot1.hasData) {
                    return ListView.builder(
                        itemCount: snapshot1.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    snapshot1.data![index]["title"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                                IconButton(
                                    onPressed: () {
                                      MyDatabase().deleteData(
                                          snapshot1.data![index]["id"]);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddDetailPage(
                                                    index: snapshot1.data![index]["id"],
                                                    value: snapshot1.data![index]["title"],
                                                  ))).then((value){
                                        setState(() {});
                                      });
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Text("Failed to load Data"),
              );
            }
          },
        ));
  }
}
