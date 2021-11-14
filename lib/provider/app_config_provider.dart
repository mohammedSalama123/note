
import 'package:flutter/material.dart';
import 'package:flutter_app/db/cache_helper.dart';
import 'package:flutter_app/db/database_provider.dart';
import 'package:flutter_app/model/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppConfigProvider extends ChangeNotifier {

  DatabaseHelper? helper;

  final String key='theme';
  late SharedPreferences prefs;
   bool darkTheme=false;
  initPrefs() async {
      prefs  = await SharedPreferences.getInstance();
  }
  AppConfigProvider(){
    darkTheme=false;
    loadFromPrefs();
  }

  toggleTheme(){
    darkTheme=!darkTheme;
    saveToPrefs();
    notifyListeners();
  }

  loadFromPrefs() async {
    await initPrefs();
    darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }
  saveToPrefs() async {
    await initPrefs();
    prefs.setBool(key, darkTheme);
  }

  // ThemeMode appTheme = ThemeMode.light;
  //
  // bool isLightMode() {
  //   return appTheme == ThemeMode.light;
  // }
  //
  //
  // void changeTheme(ThemeMode mode) {
  //   if (mode == appTheme) {
  //     return;
  //   }
  //   appTheme = mode;
  //   notifyListeners();
  // }
  var allNotes=[];
  var items=[];

  getNotes()async{
     DatabaseHelper.instance.allTodo();
     helper=DatabaseHelper();
     getNotes;
     helper?.allTodo().then((notes){
         allNotes=notes!;
         items=allNotes;
         notifyListeners();
       });

     notifyListeners();
  }

  addNote(NotesModel note){
    helper?.createTodo(note);
    print('note add succesfully');
    notifyListeners();
  }
  // void fileterserch(String query) {
  //   var dummysearchList = allNotes;
  //   if (query.isNotEmpty) {
  //     var dummyListData = [];
  //     dummysearchList.forEach((item) {
  //       var note = NotesModel.fromMap(item);
  //       if (note.title!.toLowerCase().contains(query.toLowerCase())||note.content!.toLowerCase().contains(query.toLowerCase()) ) {
  //         dummyListData.add(item);
  //       }
  //
  //         items = [];
  //         items.addAll(dummyListData);
  //       return;
  //     });
  //   } else {
  //
  //       items = [];
  //       items = allNotes;
  //
  //   }
  //   notifyListeners();
  // }


 Future delete( int id )async{
  await  DatabaseHelper.instance.delete(id);
    notifyListeners();
  }
  deleteNote(int id){
     DatabaseHelper.instance.delete(id);
    print('$id deleted succesfully');
    notifyListeners();
  }
  uptate(NotesModel? note){

    helper?.update(note!);
    helper?.createTodo(note!);
    notifyListeners();

  }

}