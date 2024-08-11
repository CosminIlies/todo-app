import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
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
    return InkWell(
        onTap: () {
          setState(() {
            widget.todo.isDone = !widget.todo.isDone;
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
                  widget.todo.isDone ? Colors.green : Colors.grey,
                  widget.todo.isDone
                      ? Color.fromARGB(255, 36, 92, 38)
                      : Color.fromARGB(255, 97, 97, 97),
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
                      children: [
                        Text(widget.todo.title),
                        Text(widget.todo.priority == 1 ? 'High' : 'Low'),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('2d'),
                      ),
                    )
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
