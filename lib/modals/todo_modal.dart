import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/uitls/helper_widgets.dart';

class TodoModal extends StatefulWidget {
  TodoModel? todo;

  TodoModal({super.key, this.todo});

  @override
  State<TodoModal> createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.todo == null ? 'Add Todo' : 'Edit Todo',
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          addVerticalSpace(20),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
              hintText: 'Enter title',
            ),
            controller: TextEditingController(text: widget.todo?.title),
            onChanged: (value) {
              widget.todo?.title = value;
            },
          ),
          addVerticalSpace(20),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
              hintText: 'Enter description',
            ),
            controller: TextEditingController(text: widget.todo?.description),
            onChanged: (value) {
              widget.todo?.description = value;
            },
          ),
          addVerticalSpace(20),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Priority',
              hintText: 'Enter priority',
            ),
            controller:
                TextEditingController(text: widget.todo?.priority.toString()),
            onChanged: (value) {
              widget.todo?.priority = int.parse(value);
            },
          ),
          addVerticalSpace(20),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Due Date',
              hintText: 'Enter due date',
            ),
            controller:
                TextEditingController(text: widget.todo?.dueDate.toString()),
            onChanged: (value) {
              widget.todo?.dueDate = DateTime.parse(value);
            },
          ),
          addVerticalSpace(20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, widget.todo);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
