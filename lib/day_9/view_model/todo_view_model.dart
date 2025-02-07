import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:river_pod/day_9/model/task_model.dart';
import 'package:river_pod/day_9/utlis/hive_helper.dart';

class TaskViewModel extends StateNotifier<List<TaskModel>> {
  // TaskViewModel() : super(Hive.box<TaskModel>('tasks').values.toList());
  TaskViewModel() : super([]) {
    // Using `super(Hive.box<TaskModel>('tasks').values.toList())` will not work
    // because the box may not be open yet. So we use `super([])` and load the
    // tasks in the constructor body.
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = HiveHelper.getAllItems('tasks');
  }

  final _taskBox = Hive.box<TaskModel>('tasks');
  final id = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> addTask(String title, bool isCompleted) async {
    // if (!Hive.isBoxOpen('tasks')) {
    //   debugPrint("Hive box 'tasks' is not open. Cannot add task.");
    //   return;
    // }

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final newTask = TaskModel(id: id, title: title, isCompleted: isCompleted);

    // _taskBox.put(newTask.id, newTask);
    await HiveHelper.addOrUpdateItem('tasks', newTask.id, newTask);

    // state = _taskBox.values.toList();
    _loadTasks();
  }

  Future<void> updateTask(String id, bool isCompleted) async {
    // final task = _taskBox.get(id);
    final task = await HiveHelper.getTask(id);

    if (task != null) {
      final updateTask = task.copyWith(isCompleted: isCompleted);
      // _taskBox.put(id, updateTask);
      await HiveHelper.addOrUpdateItem('tasks', id, updateTask);
      // state = _taskBox.values.toList();
      _loadTasks();
    }
  }

  Future<void> deleteTask(String id) async {
    // _taskBox.delete(id);
    await HiveHelper.deleteItem('tasks', id);
    // state = _taskBox.values.toList();
    _loadTasks();
  }
}

final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<TaskModel>>((ref) {
  return TaskViewModel();
});
