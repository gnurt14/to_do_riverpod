import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/config/routes/route_location.dart';
import 'package:to_do_riverpod/providers/date_provider.dart';
import 'package:to_do_riverpod/utils/utils.dart';
import 'package:to_do_riverpod/widgets/display_list_of_task.dart';
import 'package:to_do_riverpod/widgets/display_white_text.dart';

import '../data/models/task.dart';
import '../providers/task/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
    const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completedTasks = _completedTasks(taskState.tasks, ref);
    final inCompletedTasks = _inCompletedTasks(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Helpers.selectDate(context, ref),
                      child: DisplayWhiteText(
                        text: DateFormat.yMMMd().format(selectedDate),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const DisplayWhiteText(
                      text: 'My Todo List',
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTask(
                      tasks: inCompletedTasks,
                    ),
                    const Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineMedium,
                    ),
                    DisplayListOfTask(
                      tasks: completedTasks,
                    ),
                    const Gap(30),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(
                          text: 'Add new task',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _completedTasks(List<Task> tasks, WidgetRef ref){
    final selectedDate = ref.watch(dateProvider);
    final List<Task> filteredTasks = [];
    for(var task in tasks){
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
        if(isTaskDay && task.isCompleted){
          filteredTasks.add(task);
        }
    }
    return filteredTasks;
  }

  List<Task> _inCompletedTasks(List<Task> tasks, WidgetRef ref){
    final selectedDate = ref.watch(dateProvider);
    final List<Task> filteredTasks = [];
    for(var task in tasks){
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
      if(isTaskDay &&!task.isCompleted){
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
