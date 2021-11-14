import 'package:flutter/material.dart';
import 'package:flutter_app/db/database_provider.dart';
import 'package:flutter_app/model/notes_model.dart';
import 'package:flutter_app/provider/app_config_provider.dart';
import 'package:flutter_app/screens/notes_item_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'add_note_screen.dart';

class MyNotes extends StatefulWidget {
  static const String routName = 'MyNotesScreen';

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  DatabaseHelper? helper;
  Database? db;

  getNotes() async {
    final notes = await DatabaseHelper.instance.allTodo();

    return notes;
  }

  NotesModel? notesModel;

  var allNotes = [];
  var items = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    setState(() {
      helper = DatabaseHelper();
      getNotes;
      helper?.allTodo().then((notes) {
        setState(() {
          allNotes = notes!;
          items = allNotes;
        });
      });
    });
    super.initState();
  }

  void fileterserch(String query) {
    var dummysearchList = allNotes;
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummysearchList.forEach((item) {
        var note = NotesModel.fromMap(item);
        if (note.title!.toLowerCase().contains(query.toLowerCase()) ||
            note.content!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        setState(() {
          items = [];
          items.addAll(dummyListData);
        });
        return;
      });
    } else {
      setState(() {
        items = [];
        items = allNotes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    allNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'My Notes',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    provider.darkTheme
                        ? provider.toggleTheme()
                        : provider.toggleTheme();
                  },
                  child: provider.darkTheme
                      ? const Icon(Icons.light)
                      : const Icon(
                          Icons.dark_mode,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (value) {
              fileterserch(value);
            },
            style: Theme.of(context).textTheme.bodyText1,
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "search",
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {

                    helper?.allTodo().then((notes) {
                      setState(() {
                        allNotes = notes!;
                        items = allNotes;
                      });
                  });

                });
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: NotesItem(
                        items[index]['title'],
                        items[index]['content'],
                        items[index]['dateTime'],
                        items[index]['id']),
                  );
                },
                itemCount: items.length,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddNoteScreen.routName,
          );
        },
        elevation: 20,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
