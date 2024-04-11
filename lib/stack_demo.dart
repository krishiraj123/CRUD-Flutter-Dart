import 'package:flutter/material.dart';

class StackDemo extends StatefulWidget {
  const StackDemo({super.key});

  @override
  State<StackDemo> createState() => _StackDemoState();
}

class _StackDemoState extends State<StackDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack Demo"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsGM3-nZ2yIDv3AdX3UQ2mFj441vCq-ukROA&s",
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              "Thala For a Reason 7",
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
