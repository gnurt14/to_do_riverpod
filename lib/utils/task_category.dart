import 'package:flutter/material.dart';

enum TaskCategory{
  education(Icons.school, Colors.redAccent),
  health(Icons.favorite, Colors.pink),
  home(Icons.home, Colors.green),
  others(Icons.calendar_month, Colors.lightGreen),
  personal(Icons.person, Colors.blue),
  shopping(Icons.shopping_bag, Colors.purple),
  social(Icons.people, Colors.teal),
  travel(Icons.flight, Colors.deepOrange),
  work(Icons.work, Colors.amber);

  static TaskCategory stringToCategory(String name){
    try{
      return TaskCategory.values.firstWhere(
          (category) => category.name == name
      );
    } catch (e){
      return TaskCategory.education;
    }
  }

  final IconData icon;
  final Color color;
  const TaskCategory(this.icon, this.color);
}