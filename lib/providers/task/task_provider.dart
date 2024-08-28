import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/providers/providers.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref){
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});