import 'package:flutter/material.dart';
import 'package:todo_app/components/todo_card.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/model/todo_model.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  TodoModel todo = TodoModel(
      id: 1,
      title: 'Title',
      description: 'Description',
      priority: 1,
      dueDate: DateTime.now(),
      isDone: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Todo App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                enableDrag: true,
                builder: (BuildContext context) {
                  return TodoModal();
                });
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(children: [
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
          TodoCard(todo: todo),
        ]));
  }
}
