import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/uitls/helper_widgets.dart';
import 'package:todo_app/uitls/validation.dart';

class TodoModal extends StatefulWidget {
  TodoModel? todo;

  TodoModal({super.key, this.todo});

  @override
  State<TodoModal> createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  int priority = 0;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  String? titleError;
  String? descriptionError;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      priority = widget.todo!.priority;
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      dueDateController.text = widget.todo!.dueDate.toString();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    // priorityController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    // DateTime? _pickedDate = await showDatePicker(
    //     context: context, firstDate: DateTime.now(), lastDate: DateTime(2040));
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040));

    TimeOfDay? _pickedTime = await showTimePicker(
        context: context, initialTime: const TimeOfDay(hour: 0, minute: 0));

    if (_pickedDate != null) {
      setState(() {
        dueDateController.text = DateTime(
          _pickedDate.year,
          _pickedDate.month,
          _pickedDate.day,
          _pickedTime!.hour,
          _pickedTime.minute,
        ).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.todo == null ? 'Add Todo' : 'Edit Todo',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold)),
              widget.todo != null
                  ? IconButton(
                      onPressed: () {
                        DatabaseService.deleteTodo(widget.todo!.id)
                            .then((value) {
                          Navigator.pop(context, 'Todo Deleted');
                        });
                      },
                      icon: const Icon(Icons.delete),
                      iconSize: 35,
                      color: Colors.red,
                    )
                  : SizedBox(),
            ],
          ),
          addVerticalSpace(20),
          TextField(
            decoration: InputDecoration(
              errorText: titleError,
              border: OutlineInputBorder(),
              labelText: 'Title',
              hintText: 'Enter title',
            ),
            controller: titleController,
          ),
          addVerticalSpace(20),
          TextField(
            decoration: InputDecoration(
              errorText: descriptionError,
              border: OutlineInputBorder(),
              labelText: 'Description',
              hintText: 'Enter description',
            ),
            controller: descriptionController,
          ),
          addVerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Priority: '),
              DropdownButton<int>(
                  items: const [
                    DropdownMenuItem(
                      child: Text('High'),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text('Normal'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('Low'),
                      value: 0,
                    ),
                  ],
                  value: priority,
                  underline: Container(
                    height: 2,
                  ),
                  onChanged: (val) {
                    setState(() {
                      priority = val!;
                    });
                  }),
            ],
          ),
          addVerticalSpace(20),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Due Date',
              hintText: 'Enter due date',
            ),
            readOnly: true,
            controller: dueDateController,
            onTap: () {
              _selectDate();
            },
          ),
          addVerticalSpace(20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                titleError = validateTitle(titleController.text);
                descriptionError =
                    validateDescription(descriptionController.text);
              });
              if (titleError != null || descriptionError != null) {
                return;
              }

              if (widget.todo == null) {
                widget.todo = TodoModel(
                  id: '',
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: priority,
                  dueDate: DateTime.parse(dueDateController.text),
                  isDone: false,
                );
                DatabaseService.createNewTodo(widget.todo!);
              } else if (widget.todo != null) {
                widget.todo!.title = titleController.text;
                widget.todo!.description = descriptionController.text;
                widget.todo!.priority = priority;
                widget.todo!.dueDate = DateTime.parse(dueDateController.text);
                DatabaseService.updateTodo(widget.todo!);
              }

              Navigator.pop(context, 'Todo Added');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
