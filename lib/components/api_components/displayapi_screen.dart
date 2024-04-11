import 'package:databaseapi/api/API.dart';
import 'package:databaseapi/components/api_components/add_detailapi_screen.dart';
import 'package:flutter/material.dart';

class DisplayAPIPage extends StatefulWidget {
  const DisplayAPIPage({super.key});

  @override
  State<DisplayAPIPage> createState() => _DisplayAPIPageState();
}

class _DisplayAPIPageState extends State<DisplayAPIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddDetialAPIPage()))
              .then((value) {
              setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Display Page"),
      ),
      body: FutureBuilder(
        future: MyApi().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              foregroundImage:
                                  NetworkImage(snapshot.data![index]["image"]),
                              maxRadius: 30,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(snapshot.data![index]["name"]),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  MyApi()
                                      .deleteData(snapshot.data![index]["id"]);
                                });
                              },
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => AddDetialAPIPage(
                                    id: snapshot.data![index]["id"],
                                    name: snapshot.data![index]["name"],
                                    image: snapshot.data![index]["image"],
                                  ),
                                )).then((value) {
                                    setState(() {});
                                });
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
