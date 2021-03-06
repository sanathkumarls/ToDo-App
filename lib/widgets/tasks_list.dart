import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final task = taskData.tasks[index];
          return TaskTile(
            title: task.name,
            isChecked: task.isDone,
            onChanged: (checkboxState) => taskData.toggleTask(task),
            onDelete: () => taskData.removeTask(task)
          );
        },
        itemCount: taskData.taskCount,
      );
    });
  }
}
