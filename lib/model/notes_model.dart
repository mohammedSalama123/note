
class NotesModel{
  int? id;
  String? title;
  String? content;
  String? dateTime;

  NotesModel(this.id,{required this.title, required this.content, required this.dateTime});
 NotesModel.withId(dynamic obj){
  id=obj['id'];
  title=obj['title'];
  content=obj['content'];
  dateTime=obj['dateTime'];
 }


  NotesModel.fromMap(Map<dynamic,dynamic> data){
       id=data['id'];
        title=data['title'];
       content=data['content'];
       dateTime=data['dateTime'];

  }
 Map<String,Object?>toMap(){
    final map=Map<String,dynamic>();
    if(id !=null){
      map['id']= id;
    }
   return {
     'id':id,
     "title":title,
     "content":content,
     "dateTime":dateTime,
   };
 }
}