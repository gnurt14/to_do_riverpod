import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:to_do_riverpod/utils/extensions.dart';
import 'package:to_do_riverpod/widgets/circle_container.dart';

import '../data/models/task.dart';

class TaskDetails extends StatelessWidget {
  final Task task;

  const TaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(0.3),
            child: Icon(
              task.category.icon,
              color: task.category.color,
            ),
          ),
          const Gap(16),
          Text(
            task.title,
            style: style.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            task.time,
            style: style.titleMedium,
          ),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('task to be completed on ${task.date}'),
                const Gap(5),
                Icon(
                  Icons.check_box,
                  color: task.category.color,
                ),
              ],
            ),
          ),
          const Gap(16),
          Divider(
            thickness: 1.5,
            color: task.category.color,
          ),
          const Gap(16),
          Text(
            task.note.trim().isEmpty
                ? 'There is no additional for this task'
                : task.note,
          ),
          const Gap(16),
          Visibility(
            visible: task.isCompleted,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('task completed'),
                Gap(5),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
