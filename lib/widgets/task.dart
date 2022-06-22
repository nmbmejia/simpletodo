import 'package:flutter/material.dart';
import 'package:simpleflutter/widgets/colors.dart';

// ignore: must_be_immutable
class TaskWidget extends StatelessWidget {
  String task;
  bool completed;
  Function onChanged;

  TaskWidget(this.task, this.completed, this.onChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: AppColors.textLight,
            ),
            child: CheckboxListTile(
              enableFeedback: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                task,
                style: TextStyle(
                    color: completed ? AppColors.textLight : AppColors.text,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w300,
                    decoration: (completed == true)
                        ? TextDecoration.lineThrough
                        : null),
              ),
              secondary: completed
                  ? const Text('')
                  : Text(
                      "ALL DAY",
                      style: TextStyle(
                        color: completed ? AppColors.textLight : AppColors.text,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
              autofocus: false,
              activeColor: AppColors.textLight,
              checkColor: Colors.white70,
              selected: completed,
              value: completed,
              onChanged: (bool? value) {
                onChanged();
              },
            ),
          ),
        ),
      ),
    );
  }
}
