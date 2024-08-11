import 'package:flutter/material.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/uitls/helper_widgets.dart';

class TodoCard extends StatefulWidget {
  TodoModel todo;

  TodoCard({super.key, required this.todo});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    List<Color> bgColors = Theme.of(context).brightness == Brightness.light
        ? [
            Color.fromARGB(255, 210, 240, 211),
            Color.fromARGB(255, 149, 179, 150),
            Color.fromARGB(255, 218, 155, 155),
            Color.fromARGB(255, 167, 83, 83)
          ]
        : [
            Color.fromARGB(255, 105, 212, 109),
            Color.fromARGB(255, 46, 124, 48),
            Color.fromARGB(255, 179, 69, 69),
            Color.fromARGB(255, 104, 21, 21)
          ];

    return InkWell(
        onTap: () {
          setState(() {
            widget.todo.isDone = !widget.todo.isDone;
            DatabaseService.updateTodo(widget.todo);
          });
        },
        child: Card(
          // color: widget.todo.isDone ? Colors.green : Colors.grey,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  widget.todo.isDone
                      ? bgColors[0]
                      : widget.todo.isOverdue()
                          ? bgColors[2]
                          : Theme.of(context).primaryColor,
                  widget.todo.isDone
                      ? bgColors[1]
                      : widget.todo.isOverdue()
                          ? bgColors[3]
                          : Theme.of(context).primaryColorDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.todo.title),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.todo.priorityColor(),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            widget.todo.priorityStr(),
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(!widget.todo.isDone
                              ? widget.todo.dueDateStr()
                              : 'Done'),
                        ),
                      ),
                      IconButton(
                        color: Theme.of(context).colorScheme.secondary,
                        icon: const Icon(Icons
                            .edit_document), // Wrap Icons.edit_document with Icon widget
                        onPressed: () {
                          final res = showModalBottomSheet<String>(
                              isScrollControlled: true,
                              context: context,
                              enableDrag: true,
                              builder: (BuildContext context) {
                                return TodoModal(todo: widget.todo);
                              }).then((value) {
                            Navigator.pushReplacementNamed(context, '/main');
                          });
                        },
                      )
                    ])
                  ],
                ),
                addVerticalSpace(20),
                Text(widget.todo.description),
              ],
            ),
          ),
        ));
  }
}
