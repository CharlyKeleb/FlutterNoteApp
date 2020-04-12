import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:note_app/screens/note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          actions: <Widget>[
            IconButton(icon: Icon(Feather.search), onPressed: () {})
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Column(
                  children: <Widget>[
                    _buildCardItems('Today\'s Activity '  , 'Today have been going very fantastic..', context)
                  ],
                ),
              );
            },
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Feather.plus),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => Notes()
          ));
        },
      ),
    );
  }
  Widget _buildCardItems(String noteTitle, String note, context) {
    return  Container(
      height: 90,
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 20,
              child: Text(noteTitle,style: TextStyle(fontWeight: FontWeight.w600),),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: Column(
                children: <Widget>[
                  Text(note, style: TextStyle(fontSize: 13, color: Colors.grey),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
