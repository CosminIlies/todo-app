import 'package:flutter/material.dart';
import 'package:todo_app/components/todo_card.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/services/database_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Todo App'),
          actions: [
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  enableDrag: true,
                  builder: (BuildContext context) {
                    return TodoModal();
                  }).then((value) {
                Navigator.pushReplacementNamed(context, '/main');
              });
            });
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: DatabaseService.streamTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                print("HAS DATA");
                print(snapshot.data);
                return ListView(
                    children:
                        snapshot.data?.map((e) => TodoCard(todo: e)).toList() ??
                            []);
              } else {
                print("NO DATA");
              }
            }

            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('An error occurred'));
            }
            return Container(); // Add a return statement here
          },
        ));
  }
}
