import 'package:flutter/material.dart';
import 'package:flutter_app/db/database_provider.dart';
import 'package:flutter_app/provider/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import '../model/notes_model.dart';
import 'package:date_format/date_format.dart';

class AddNoteScreen extends StatefulWidget {
  static const String routName = 'AddNotesScreen';

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  String title = '';

  String content = '';
  int? id;
  DatabaseHelper? helper;

  addNote(NotesModel note) {

    helper?.createTodo(note);
    // helper?.createDatabase();
    // helper?.update(note);
    print('note add succesfully ');
  }

  @override
  void initState() {
    helper = DatabaseHelper();
    helper?.allTodo();

    super.initState();
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    String dateTime = formatDate(DateTime.now(),
        [' ', HH, ':', nn, ' ', am, '\n', dd, '/', mm, '/', yyyy]);
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Add Notes",
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
                        NotesModel note = NotesModel(id = id, title: title, content: content, dateTime: dateTime);

                        if(!formKey.currentState!.validate()){
                          return ;
                        }
                        else {
                          addNote(note);
                          Navigator.pushNamedAndRemoveUntil(
                              context, MyNotes.routName, (route) => false);
                        }}),
                ],
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateTime,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                validator: (text) {
                  if (text==null||text.isEmpty) {
                    return 'Please enter note title';
                  }
                  return null;
                },
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
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter note content';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Content",
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red, style: BorderStyle.none),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
void validition(){
  if(!formKey.currentState!.validate()){
    return ;
  }
}
}
