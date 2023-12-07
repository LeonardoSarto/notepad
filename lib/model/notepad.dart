class Notepad {
  int? id;
  String title;
  String description;
  bool selected = false;

  Notepad({this.id, required this.title, required this.description});

  Notepad.create({this.id, this.title = '', this.description = ''});

  @override
  String toString() {
    return "Title: $title. Description: $description";
  }

  static Notepad fromJson(Map<dynamic, dynamic> json) {
    return Notepad(
        id: json['id'], title: json['title'], description: json['description']);
  }

}
