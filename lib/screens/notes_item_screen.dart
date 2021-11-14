import 'package:flutter/material.dart';
import 'package:flutter_app/db/database_provider.dart';
import 'package:flutter_app/model/notes_model.dart';
import 'package:flutter_app/provider/app_config_provider.dart';
import 'package:flutter_app/screens/detetils_note_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/them.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesItem extends StatefulWidget {
  String title;
  String dateTime;
  String content;
  int id;

  NotesItem(
    this.title,
    this.content,
    this.dateTime,
    this.id,
  );

  @override
  State<NotesItem> createState() => _NotesItemState();
}

class _NotesItemState extends State<NotesItem> {
  DatabaseHelper? helper;
  Database? db;

  Future getNotes() async {
    DatabaseHelper.instance.allTodo();
    helper = DatabaseHelper();
    await helper?.allTodo();

    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      helper = DatabaseHelper();
      DatabaseHelper.instance.allTodo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          actions: [
            IconSlideAction(
              color: Colors.transparent,
              iconWidget: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    boxShadow: ([
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.delete,
                    ),
                    Text(
                      'Delete',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              onTap: () {
                //

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        // title: const Text('Delete!!'),
                        content: const Text('Are yo sure you want delete this note ?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel',style: TextStyle(color:Colors.red,fontSize: 16),),
                          ),
                          TextButton(
                            onPressed: () {
                              helper?.delete(widget.id);
                              Navigator.pop(context);

                            },
                            child: const Text('OK',style: TextStyle(color:Colors.green,fontSize: 16)),
                          ),
                        ],
                      );
                    });

                // helper?.delete(widget.id);


                //
              },
            ),
          ],
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailsNoteScreen.routName,
                  arguments: NotesModel(widget.id,
                      title: widget.title,
                      content: widget.content,
                      dateTime: widget.dateTime));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(20),

                  child: Text(widget.dateTime,
                      style: Theme.of(context).textTheme.bodyText1),
                  decoration: BoxDecoration(
                    color: provider.darkTheme
                        ? MyThemeData.darkBackground2
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: ([
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                  ),
                ),
                // SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: provider.darkTheme
                          ? MyThemeData.darkBackground2
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: ([
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.content,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
