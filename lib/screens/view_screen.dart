import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:note_app/database/note_helper.dart';
import 'package:note_app/model/note.dart';

class ViewScreen extends StatefulWidget {
  Note note;
  final bool isEdit;

  ViewScreen({Key key, this.note, this.isEdit = false})
      : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  FocusNode titleFocus = FocusNode();
  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.isEdit;
    super.initState();
  }

  updateNote() async{
    int edit = await NoteHelper().updateNote(
      Note.fromMap(
        {
          "id": widget.note.id,
          "title": _title.text,
          "content": _content.text,
        },
      ),
    );
    print(edit);
    Navigator.pop(context);
  }

  saveNote(){
    NoteHelper().saveNote(
      Note(
        "${_title.text}",
        "${_content.text}",
      ),
    ).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              _buildSaveEdit()
            ],
          ),
        ],
      ),
      body: isEdit ? _buildEdit() : _buildNoteDetails(),
    );
  }

  Widget _buildNoteDetails() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(
              widget.note.title,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            widget.note.content,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildEdit() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _title,
              focusNode: titleFocus,
              decoration: InputDecoration.collapsed(
                hintText: widget.note.title,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: _content,
              decoration: InputDecoration.collapsed(
                hintText: widget.note.content,
                hintStyle: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSaveEdit() {
    if(isEdit) {
      return IconButton(
        icon: Icon( Feather.check),
        onPressed: () async {
          await updateNote();
          setState(() {
            isEdit = !isEdit;
          });
        },
      );
    }else {
      return  IconButton(
        icon: Icon( Feather.edit_2),
        onPressed: () async {
          setState(() {
            _title.text = widget.note.title;
            _content.text = widget.note.content;
            isEdit = !isEdit;
            titleFocus.requestFocus();
          });
        },
      );
    }
  }
}
