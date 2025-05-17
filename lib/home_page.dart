import 'package:flutter/material.dart';
import 'dart:math';
import 'models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _controller = TextEditingController();
  List<Todo> todoList = [];

  void _toggleTodo(Todo todo) {
    setState(() {
      todo.toggleDone();
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void _addTodo(String text) {
    if (text.isEmpty) return;
    setState(() {
      todoList.add(Todo(
        id: Random().nextDouble().toString(),
        text: text,
      ));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        labelText: 'Enter todo',
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () => _addTodo(_controller.text),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return ListTile(
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (value) => _toggleTodo(todo),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTodo(todo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
