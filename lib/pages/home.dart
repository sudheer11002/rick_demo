import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/helper_functions.dart';
import '../models/model_content.dart';

List<Content> entries_to_show = [];

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    List<Content> entries = await HelperFunctions.GetData();
    setState(() {
      entries_to_show = entries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var i in entries_to_show)
              Card(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(i.id.toString()),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(i.type.toString()),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(i.group_id.toString()),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(i.name),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
