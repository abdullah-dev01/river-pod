import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:river_pod/day_9/model/task_model.dart';

class TaskViewModel extends StateNotifier<List<TaskModel>> {
  TaskViewModel() : super(Hive.box<TaskModel>('tasks').values.toList());

  final _taskBox = Hive.box<TaskModel>('tasks');
  final id = DateTime.now().millisecondsSinceEpoch.toString();

  void addTask(String title, bool isCompleted) {
    final newTask = TaskModel(id: id, title: title, isCompleted: isCompleted);
    _taskBox.put(newTask.id, newTask);
    state = _taskBox.values.toList();
  }

  void updateTask(String id, bool isCompleted) {
    final task = _taskBox.get(id);
    if (task != null) {
      final updateTask = task.copyWith(isCompleted: isCompleted);
      _taskBox.put(id, updateTask);
      state = _taskBox.values.toList();
    }
  }

  void deleteTask(String id) {
    _taskBox.delete(id);
    state = _taskBox.values.toList();
  }

  init() async {
    
  }
}

final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<TaskModel>>((ref) {
  return TaskViewModel();
});
