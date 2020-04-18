import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:note_app/components/fade_in.dart';
import 'package:note_app/components/fade_side.dart';
import 'package:note_app/database/note_helper.dart';
import 'package:note_app/delegate/customsearch.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/screens/note_screen.dart';
import 'package:note_app/screens/view_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<Note> notes = List();
  bool loading = true;

  getNotes(){
    notes.clear();
    setState(() {
      loading = true;
    });
    NoteHelper().getNotes().then((value){
      print(value);
      value.forEach((element) {
        notes.add(Note.fromMap(element));
      });
      setState(() {
        loading = false;
      });
    });
  }



  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: FadeSide(
          delay: 1,
          child: Text('Notes'),
        ),
        actions: <Widget>[
          FadeSide(
            delay: 2,
            child: IconButton(
              icon: Icon(Feather.search),
              onPressed: () {
                showSearch(
                  context:  context,
                  delegate: CustomSearchDelegate(context),
                );
              },
            ),
          ),
        ],
      ),
      body: loading?Center(child: CircularProgressIndicator()):notes.isEmpty
          ? Center(child: Text("No notes"))
          : ListView.builder(
        itemCount: notes.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ObjectKey(notes[index].id),
            background: stackBehindDismiss(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async{
              await NoteHelper().deleteNote(notes[index].id);
              notes.removeAt(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: _buildCardItems(notes[index], context),
            ),
          );
        },
      ),
      floatingActionButton: FadeSide(
        delay: 11,
        child: FloatingActionButton(
          child: Icon(Feather.plus),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Notes(),
              ),
            ).then((value) => getNotes());
          },
        ),
      ),
    );
  }

  Widget _buildCardItems(Note note, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ViewScreen(
              note: note,
            ),
          ),
        ).then((value) => getNotes());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  note.title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),

                SizedBox(height: 5,),

                Text(
                  note.content,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


