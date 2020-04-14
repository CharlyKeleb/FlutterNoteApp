import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/components/fade_in.dart';
import 'package:note_app/components/fade_side.dart';
import 'package:note_app/screens/note_screen.dart';
import 'package:note_app/screens/view_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
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
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                icon: (Feather.edit),
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewScreen()));
                },
              ),
              IconSlideAction(
                icon: (Feather.trash_2),
                color: Colors.red,
              )
            ],
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: index < 9
                  ? FadeIn(
                      delay: 2,
                      child: _buildCardItems('Today\'s Activity ',
                          'Today have been going very fantastic..', context),
                    )
                  : _buildCardItems('Today\'s Activity ',
                      'Today have been going very fantastic..', context),
            ),
          );
        },
      ),
      floatingActionButton: FadeSide(
        delay: 11,
        child: FloatingActionButton(
          child: Icon(Feather.plus),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Notes()));
          },
        ),
      ),
    );
  }

  Widget _buildCardItems(String noteTitle, String note, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ViewScreen()));
      },
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width - 10,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                left: 20,
                child: Text(
                  noteTitle,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Column(
                  children: <Widget>[
                    Text(
                      note,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
