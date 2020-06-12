final String columnId = 'id';
final String columnTitle = "title";
final String columnUsername = 'username';
final String columnPassword = 'password';
final String columnNotes = 'notes';

class Password {
  int id;
  String title;
  String username;
  String passwd;
  String notes;

  Password({this.id, this.title, this.username, this.passwd, this.notes});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnUsername: username,
      columnPassword: passwd,
      columnNotes: notes,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Password.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    username = map[columnUsername];
    passwd = map[columnPassword];
    notes = map[columnNotes];
  }
}
