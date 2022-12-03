import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: TodoList(),
      theme: ThemeData(
        brightness: Brightness.dark
      )
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<TodoList> {
  final List<String> todolist = <String>[];
  final List<String> completedlist = <String>[];
  final TextEditingController textEditer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-do List"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: ListView(
                children: _getItems()
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ListView(
                children: _getCompletedItems()
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: "Add item",
        child: Icon(
          Icons.add, 
          color: Colors.white
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey[800],
    );
  }

  void _addTodo(String title) {
    setState(() {
      todolist.add(title);
    });
    textEditer.clear();
  }

  void _deleteItem(String title) {
    setState(() {
      todolist.remove(title);
    });
  }

  void _completeItem(String title) {
    setState(() {
      completedlist.add(title);
      todolist.remove(title);
    });
  }
  
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(
        title, 
        style: TextStyle(
          color: Colors.white
        )
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.remove_circle, 
          color: Colors.red[800]
        ),
        onPressed: (() => _deleteItem(title))
      ),
      leading: IconButton(
        icon: Icon(
          Icons.done,
          color: Colors.green[700]
        ),
        onPressed: (() => _completeItem(title))
      )
    );
  }

  Widget _buildCompleteItem(String title) {
    return ListTile(
      title: Text(
        title, 
        style: TextStyle(
          color: Colors.grey,
          decoration: TextDecoration.lineThrough
        )
      )
    );
  }

  final ButtonStyle flatButtonStyleGreen = TextButton.styleFrom(
    foregroundColor: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.green,
  );

  final ButtonStyle flatButtonStyleRed = TextButton.styleFrom(
    foregroundColor: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.red,
  );

  Future<void> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text('Add a task', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: textEditer,
            decoration: const InputDecoration(
              hintText: 'Enter task here',
              hintStyle: TextStyle(color: Colors.white)
            ),
            style: TextStyle(color: Colors.white)
          ),
          actions: <Widget>[
            // add button
            TextButton(
              style: flatButtonStyleGreen,
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodo(textEditer.text);
              },
            ),
            // Cancel button
            TextButton(
              style: flatButtonStyleRed,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      } 
    );
  }

  List<Widget> _getItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (String title in todolist) {
      todoWidgets.add(_buildTodoItem(title));
    }
    return todoWidgets;
  }

  List<Widget> _getCompletedItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (String title in completedlist) {
      todoWidgets.add(_buildCompleteItem(title));
    }
    return todoWidgets;
  }
}