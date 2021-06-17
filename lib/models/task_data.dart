import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';
import 'package:localstore/localstore.dart';

class TaskData extends ChangeNotifier {

  List<Task> _tasks = [];

  final _db = Localstore.instance;

  final String id = "myid";

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  int get pendingTaskCount{
    int count = 0;
    for(Task task in _tasks){
      if(task.isDone == false)
        count++;
    }
    return count;
  }

  void addTask(Task newTask) async{
    _tasks.add(newTask);
    _saveToLocal();
    notifyListeners();
  }

  void toggleTask(Task task){
    task.toggleDone();
    _saveToLocal();
    notifyListeners();
  }

  void removeTask(Task task){
    _tasks.remove(task);
    _saveToLocal();
    notifyListeners();
  }

  void _saveToLocal() async{
    await _db.collection("todo").doc(id).set({"task" : _tasks});
  }

  void fromLocal() async{
    try{
      Map<String,dynamic>? data = await _db.collection("todo").doc(id).get();
      for(var task in data!['task']){
        _tasks.add(Task(name: task!["name"], isDone: task!["isDone"]?? false));
      }

    }catch(e)
    {
      print(e);
    }
    notifyListeners();
  }

}
