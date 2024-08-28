import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/data/data.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref){
  return TaskDatasource();
});