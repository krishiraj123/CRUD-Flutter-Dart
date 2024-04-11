import 'package:flutter/material.dart';

class EqualPartPage extends StatefulWidget {
  const EqualPartPage({super.key});

  @override
  State<EqualPartPage> createState() => _EqualPartPageState();
}

class _EqualPartPageState extends State<EqualPartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Equal Blocks"),),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Block(Colors.greenAccent, "Block 1")),
                Expanded(child: Block(Colors.red, "Block 2")),
                Expanded(child: Block(Colors.yellow, "Block 3")),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Block(Colors.purple, "Block 4")),
                Expanded(child: Block(Colors.blueAccent, "Block 5")),
                Expanded(child: Block(Colors.orange, "Block 6")),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Block(Colors.blueGrey, "Block 7")),
                Expanded(child: Block(Colors.pink, "Block 8")),
                Expanded(child: Block(Colors.brown, "Block 9")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Block(Color color,String text){
  return Container(
    color: color,
    child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontSize: 18),)),
  );
}
