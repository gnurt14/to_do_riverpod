import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/providers/providers.dart';
import 'package:to_do_riverpod/utils/app_alerts.dart';
import 'package:to_do_riverpod/utils/utils.dart';
import 'package:to_do_riverpod/widgets/common_container.dart';
import 'package:to_do_riverpod/widgets/task_detail.dart';
import 'package:to_do_riverpod/widgets/task_tile.dart';

import '../data/models/task.dart';

class DisplayListOfTask extends ConsumerWidget {
  final bool isCompleted;
  final List<Task> tasks;

  const DisplayListOfTask({
    super.key,
    this.isCompleted = false,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = isCompleted ? 0.3 : 0.25;
    final emptyTaskMessage = isCompleted
        ? 'There is no completed task yet'
        : 'There is no task todo';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    AppAlerts.showDeleteAlertDialog(
                      context,
                      ref,
                      task,
                    );
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return TaskDetails(task: task);
                      },
                    );
                  },
                  child: TaskTile(
                    task: task,
                    onCompleted: (value) async {
                      await ref
                          .read(taskProvider.notifier)
                          .updateTask(task)
                          .then((value) {
                        AppAlerts.displaySnackBar(
                            context,
                            task.isCompleted
                                ? 'Task is completed'
                                : 'Task is inCompleted');
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
