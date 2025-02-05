import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_9/model/task_model.dart';
import 'package:river_pod/day_9/view_model/todo_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Tasks'),
          const SizedBox(height: 20),
          const AddTaskForm(),
          const SizedBox(height: 20),
          const TaskList(),
        ],
      ),
    );
  }
}

class AddTaskForm extends ConsumerWidget {
  const AddTaskForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter task',
          ),
          controller: controller,
          onSubmitted: (value) {
            ref
                .read(taskViewModelProvider.notifier)
                .addTask(controller.text, false);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: ref.watch(taskViewModelProvider).length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: ref.watch(taskViewModelProvider)[index],
          );
        },
      ),
    );
  }
}

class TaskTile extends ConsumerWidget {
  final TaskModel task;
  const TaskTile({required this.task, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(task.title),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          ref.read(taskViewModelProvider.notifier).updateTask(task.id, value!);
        },
      ),
      onLongPress: () {
        ref.read(taskViewModelProvider.notifier).deleteTask(task.id);
      },
    );
  }
}
