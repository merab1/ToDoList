import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoModel> todoList = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView(
        children: todoList.map((TodoModel todoModel) {
          return TodoItem(todoModel: todoModel, onTodoChanged: handleToChange);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMyDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new todo item'),
          content: TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Type your task')),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                addTask(textEditingController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void handleToChange(TodoModel todoModel) {
    setState(() {
      todoModel.checked = !todoModel.checked;
    });
    
  }

  void addTask(String name) {
    setState(() {
      todoList.add(TodoModel(name: name, checked: false));
    });
    textEditingController.clear();
  }
}

class TodoModel {
  String name;
  bool checked;
  TodoModel({required this.name, required this.checked});
}

class TodoItem extends StatelessWidget {
  TodoModel todoModel;
  final onTodoChanged;
  TodoItem({required this.todoModel, required this.onTodoChanged});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todoModel.name,
        style: getTextStyle(todoModel.checked),
      ),
      leading: CircleAvatar(child: Text(todoModel.name[0])),
      onTap: () {
        onTodoChanged(todoModel);
      },
    );
  }

  TextStyle? getTextStyle(bool checked) {
    if (checked) {
      return TextStyle(
          color: Colors.black, decoration: TextDecoration.lineThrough);
    } else {
      return null;
    }
  }
}

//Todo App Stateless widget
//Todo List Stateful widget
//create model name; status
//add new todo task button
//show dialog