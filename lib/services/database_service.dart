import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/auth_service.dart';

class DatabaseService {
  static final CollectionReference _usersCollections =
      FirebaseFirestore.instance.collection('users');

  static Future<void> storeFCMToken(String token) async {
    try {
      _usersCollections.doc(AuthService.user!.uid).set({'fcmToken': token});
    } catch (e) {
      print(e);
    }
  }

  static Future<String> getFCMToken() async {
    final snapshot = await _usersCollections.doc(AuthService.user!.uid).get();
    return (snapshot.data() as Map<String, dynamic>)['fcmToken'];
  }

  static Future<void> createNewTodo(TodoModel todo) async {
    try {
      _usersCollections.doc(AuthService.user!.uid).collection("todo").add({
        'title': todo.title,
        'description': todo.description,
        'priority': todo.priority,
        'dueDate': todo.dueDate,
        'isDone': todo.isDone,
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateTodo(TodoModel todo) async {
    try {
      _usersCollections
          .doc(AuthService.user!.uid)
          .collection("todo")
          .doc(todo.id)
          .update({
        'title': todo.title,
        'description': todo.description,
        'priority': todo.priority,
        'dueDate': todo.dueDate,
        'isDone': todo.isDone,
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteTodo(String id) async {
    try {
      _usersCollections
          .doc(AuthService.user!.uid)
          .collection("todo")
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  static Future<void> toggleTodoStatus(TodoModel todo) async {
    try {
      _usersCollections
          .doc(AuthService.user!.uid)
          .collection("todo")
          .doc(todo.id)
          .update({'isDone': !todo.isDone});
    } catch (e) {
      print(e);
    }
  }

  static Future<List<TodoModel>> streamTodos() async {
    final snapshot = await _usersCollections
        .doc(AuthService.user!.uid)
        .collection("todo")
        .orderBy('priority', descending: true)
        .get();

    print(snapshot.docs);

    return snapshot.docs.map((e) => TodoModel.fromSnapshot(e)).toList();
  }
}
