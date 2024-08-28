import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/config/routes/route_location.dart';
import 'package:to_do_riverpod/data/data.dart';
import 'package:to_do_riverpod/providers/date_provider.dart';
import 'package:to_do_riverpod/providers/providers.dart';
import 'package:to_do_riverpod/utils/app_alerts.dart';
import 'package:to_do_riverpod/utils/helpers.dart';
import 'package:to_do_riverpod/widgets/common_text_field.dart';
import 'package:to_do_riverpod/widgets/select_date_time.dart';

import '../widgets/select_category.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();

  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new task'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Task title',
                hintText: 'Task title',
                controller: _titleController,
              ),
              const Gap(16),
              const SelectDateTime(),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
              CommonTextField(
                title: 'Note',
                hintText: 'Task note',
                maxLines: 9,
                controller: _noteController,
              ),
              const Gap(100),
              ElevatedButton(
                onPressed: _createTask,
                child: const Text(
                  'Save',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        note: note,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        category: category,
        isCompleted: false,
      );

      await ref.read(taskProvider.notifier).createTask(task).then((value){
        AppAlerts.displaySnackBar(context, 'Task created successfully!');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackBar(context, 'Title can\'t be empty');
    }
  }
}
