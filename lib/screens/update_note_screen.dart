import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/db/database_provider.dart';
import 'package:flutter_app/model/notes_model.dart';
import 'package:flutter_app/provider/app_config_provider.dart';
import 'package:flutter_app/screens/add_note_screen.dart';
import 'package:flutter_app/screens/detetils_note_screen.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class UpdateNoteScreen extends StatefulWidget {
  static const String routName = 'UpdateNotesScreen';
  NotesModel? note;
  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController titleController=TextEditingController();

  TextEditingController contentController=TextEditingController();
  String? dateTime;
  NotesModel? note;

  DatabaseHelper? helper;
  addNote(NotesModel note){
    helper?.createTodo(note);
    print('note add succesfully');
  }
  uptate(NotesModel? note){
    helper?.update(note!);
  }

  @override
  void initState() {

      helper=DatabaseHelper();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   var provider=Provider.of<AppConfigProvider>(context);
    var args=ModalRoute.of(context)!.settings.arguments as NotesModel;
    titleController.text=args.title!;
    contentController.text=args.content!;

   String dateTime= formatDate(DateTime.now(), [' ', HH, ':', nn ,' ', am, '\n\n',dd, '/', mm, '/', yyyy]);
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,


          title: Text(
            "Update Notes",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.more_vert,
                  ),
                  const SizedBox(
                    width: 30,
                  ),

                  IconButton(
                      icon: const Icon(
                        Icons.save,
                      ),
                      onPressed: () {


                          NotesModel note=NotesModel(args.id,title: titleController.text, content: contentController.text, dateTime:dateTime);
                          setState(() {
                            helper?.update(note);
                             dateTime=args.dateTime!;
                          });
                          // provider.uptate(note);
                        Navigator.pushNamedAndRemoveUntil(context,MyNotes.routName, (route) => false,arguments: NotesModel(args.id, title: titleController.text, content: contentController.text, dateTime: args.dateTime));
                      }
                  ),
                ],
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(dateTime,style: Theme.of(context).textTheme.bodyText1,),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: titleController,
              // onChanged: (value){
              //   setState(() {
              //     value=args.title;
              //   });
              // },
              style: Theme.of(context).textTheme.bodyText1,
              decoration: const InputDecoration(
                  hintText: "Title",

                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  )),
            ),
            TextFormField(
              controller: contentController,

              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Content",

                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.red, style: BorderStyle.none),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  )),
            ),
          ],
        ),
      ),

    );
  }
}
