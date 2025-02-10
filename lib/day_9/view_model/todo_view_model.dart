import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_9/model/task_model.dart';
import 'package:river_pod/day_9/utlis/hive_helper.dart';

/// StateNotifier and StateNotifierProvider
///
/// StateNotifier is a class that holds and manages state.
/// It notifies its listeners when the state changes.
/// StateNotifierProvider is a provider that creates a StateNotifier
/// and stores it in the ProviderScope.
/// It can be used to easily manage state in the widget tree.
///

class TaskViewModel extends StateNotifier<List<TaskModel>> {
  // TaskViewModel() : super(Hive.box<TaskModel>('tasks').values.toList());
  TaskViewModel() : super([]) {
    // use `super([])` and load the tasks in the constructor body.
    _loadTasks();
  }
  final HiveHelper<TaskModel> _hiveHelper = HiveHelper<TaskModel>('tasks');

  final id = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> addTask(String title, bool isCompleted) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final newTask = TaskModel(id: id, title: title, isCompleted: isCompleted);

    // await HiveHelper.addOrUpdateItem('tasks', newTask.id, newTask);
    await _hiveHelper.addOrUpdateItem(id, newTask);

    _loadTasks();
  }

  Future<void> updateTask(String id, bool isCompleted) async {
    final task = await _hiveHelper.getItem(id);
    // final task = await HiveHelper.getTask(id);

    if (task != null) {
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      // await HiveHelper.addOrUpdateItem('tasks', id, updateTask);
      await _hiveHelper.addOrUpdateItem(id, updatedTask);
      _loadTasks();
    }
  }

  Future<void> deleteTask(String id) async {
    // await HiveHelper.deleteItem('tasks', id);
    await _hiveHelper.deleteItem(id);
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = await _hiveHelper.getAllItems();
  }
}

final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<TaskModel>>((ref) {
  return TaskViewModel();
});
