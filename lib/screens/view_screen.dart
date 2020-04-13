import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ViewScreen extends StatefulWidget {
  final note;
  final noteTitle;
  final bool isTapped;



  const ViewScreen({Key key, this.note, this.noteTitle, this.isTapped}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Feather.edit_2), onPressed: () {}),
              IconButton(icon: Icon(Feather.trash_2), onPressed: () {}),
            ],
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
                  border: Border.all(color: Colors.grey[500], width: 0.4)),
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNoteDetails() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Center(
            child: Text(widget.noteTitle, style: TextStyle(fontWeight: FontWeight.w700),),
          ),
        ),
        SizedBox(height: 20,),
        Text(widget.note, style: TextStyle(fontSize: 16),),
      ],
    );
  }
  Widget _buildEdit() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: widget.noteTitle, hintStyle: TextStyle(fontWeight: FontWeight.w700), ),
            ),
          )
        ),
        SizedBox(height: 20,),
       TextField(
         decoration: InputDecoration.collapsed(hintText: widget.note, hintStyle: TextStyle(fontWeight: FontWeight.w700)),
       )
      ],
    );

  }
}
