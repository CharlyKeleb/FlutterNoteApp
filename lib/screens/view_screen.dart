import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ViewScreen extends StatefulWidget {
  final note;
  final noteTitle;
  final bool isEdit;



  const ViewScreen({Key key, this.note, this.noteTitle, this.isEdit = false}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.isEdit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                    isEdit
                        ? Feather.check
                        : Feather.edit_2
                ),
                onPressed: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
              ),
              IconButton(icon: Icon(Feather.trash_2), onPressed: () {}),
            ],
          ),
        ],
      ),
      body: isEdit
          ? _buildEdit()
          : _buildNoteDetails(),
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: widget.noteTitle, hintStyle: TextStyle(fontWeight: FontWeight.w700), ),
            ),
          ),
          SizedBox(height: 20,),
         TextField(
           decoration: InputDecoration.collapsed(hintText: widget.note, hintStyle: TextStyle(fontWeight: FontWeight.w700)),
         )
        ],
      ),
    );
  }
}
