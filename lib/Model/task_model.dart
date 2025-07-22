class Task {
  static const String collectionpath = 'task';
  String? title;
  String? id;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Task.fromFireStore(Map<String, dynamic> date) {
    id = date['id'];
    title = date['title'];
    description = date['description'];
    isDone = date['isDone'];
    dateTime = DateTime.fromMillisecondsSinceEpoch(date['dateTime']);
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'dateTime': dateTime?.millisecondsSinceEpoch
    };
  }
}
