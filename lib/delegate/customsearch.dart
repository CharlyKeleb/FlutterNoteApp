import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:note_app/model/note.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Note> notes = List();



  final listNotes;

  CustomSearchDelegate(this.listNotes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Feather.delete),onPressed: () {
        query = '';
      },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return (IconButton(
      icon: Icon(Feather.arrow_left),
      onPressed: () {
        close(context, null);
      },
    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Word must be longer than two letters."
            ),
          )
        ],
      );
    }
    return Center(child: CircularProgressIndicator(),);
  }

  @override
  Widget buildSuggestions(BuildContext context,) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            _buildCard(notes[index], context),
          ],
        );
        });
  }
  Widget _buildCard(Note note, context) {
    return   Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(note.title),
              Text(note.content)
            ],
          ),
        ),
      ),
    );
  }
}
