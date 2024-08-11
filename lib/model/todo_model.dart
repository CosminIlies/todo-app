class TodoModel {
  int id;
  String title;
  String description;
  int priority;
  DateTime dueDate;
  bool isDone;

  TodoModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.dueDate,
      required this.isDone});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      dueDate: DateTime.parse(json['dueDate']),
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'isDone': isDone,
    };
  }
}
