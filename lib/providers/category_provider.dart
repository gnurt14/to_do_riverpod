import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/utils/task_category.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategory>((ref){
  return TaskCategory.education;
});