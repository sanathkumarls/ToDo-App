import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String title;
  final void Function(bool?) onChanged;
  final void Function() onDelete;

  TaskTile({required this.title, required this.isChecked, required this.onChanged, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        child: Icon(Icons.delete_forever),
        onTap: onDelete,
      ),
      title: Text(
        title,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
