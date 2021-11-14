import 'package:flutter/material.dart';
import 'package:flutter_app/db/database_provider.dart';
import 'package:flutter_app/model/notes_model.dart';
import 'package:flutter_app/screens/update_note_screen.dart';

import 'home_screen.dart';

class DetailsNoteScreen extends StatefulWidget {
  static const String routName = 'DetailsNoteScreen';

  @override
  State<DetailsNoteScreen> createState() => _DetailsNoteScreenState();
}

class _DetailsNoteScreenState extends State<DetailsNoteScreen> {
  DatabaseHelper? helper;

  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)!.settings.arguments as NotesModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title!),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, UpdateNoteScreen.routName,arguments: NotesModel(args.id, title: args.title, content: args.content, dateTime: args.dateTime));
          }, icon: Icon(Icons.edit),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,


          children: [
            Text('created at ${args.dateTime}',style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.right,),
            SizedBox(
              height: 8,
            ),
            Text(args.content!,style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DatabaseHelper.instance.delete(args.id!);

          showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (context) {
                return AlertDialog(
                  // title: const Text('Delete!!'),
                  content: const Text('Are yo sure you want delete this note ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel',style: TextStyle(color:Colors.red,fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () {
                        DatabaseHelper.instance.delete(args.id!);
                        Navigator.pushNamedAndRemoveUntil(context, MyNotes.routName, (route) => false);
                      },
                      child: const Text('OK',style: TextStyle(color:Colors.green,fontSize: 16)),
                    ),
                  ],
                );
              });
        },
        elevation: 20,
        child: const Icon(
          Icons.delete,
        ),
      ),
    );

  }
}
