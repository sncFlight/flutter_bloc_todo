import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_bloc.dart';
import 'package:bloc_to_do/presentation/pages/tasks/view/tasks_bottom_sheet_content.dart';

class TasksFloatingActionButton extends StatelessWidget {
  const TasksFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () => _showModalBottomSheet(context),
      child: const Icon(
        color: Colors.white,
        Icons.add,
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    final TasksBloc tasksBloc = context.read<TasksBloc>();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: tasksBloc,
          child: const TasksBottomSheetContent(),
        );
      },
    );
  }
}