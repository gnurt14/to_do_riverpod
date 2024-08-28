import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/providers/task/task_state.dart';

import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';

class TaskNotifier extends StateNotifier<TaskState>{
  final TaskRepository _repository;
  TaskNotifier(this._repository): super(const TaskState.initial()){
    getTasks();
  }

  Future<void> createTask(Task task) async{
    try{
      await _repository.createTask(task);
      getTasks();
    } catch (e){
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async{
    try{
      final isCompleted = !task.isCompleted;
      final updateTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updateTask);
      getTasks();
    } catch (e){
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async{
    try{
      await _repository.deleteTask(task);
      getTasks();
    } catch (e){
      debugPrint(e.toString());
    }
  }

  void getTasks() async{
    try{
      final tasks = await _repository.getAllTask();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}