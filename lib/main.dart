import 'package:flutter/material.dart';
import 'package:flutter_app/provider/app_config_provider.dart';
import 'package:flutter_app/screens/detetils_note_screen.dart';
import 'package:flutter_app/screens/update_note_screen.dart';
import 'package:flutter_app/them.dart';
import 'package:provider/provider.dart';

import 'screens/add_note_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppConfigProvider>(
      create: (context) {
        return AppConfigProvider();
      },
      child:  NotesApp(),
    ),
  );
}

class NotesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightThem,
      darkTheme: MyThemeData.darkThem,
      themeMode: provider.darkTheme?ThemeMode.dark:ThemeMode.light,
      routes: {
        MyNotes.routName: (context) => MyNotes(),
        AddNoteScreen.routName: (context) => AddNoteScreen(),
        DetailsNoteScreen.routName:(context)=>DetailsNoteScreen(),
        UpdateNoteScreen.routName:(context)=>UpdateNoteScreen(),
      },
      initialRoute: MyNotes.routName,
    );
  }
}
