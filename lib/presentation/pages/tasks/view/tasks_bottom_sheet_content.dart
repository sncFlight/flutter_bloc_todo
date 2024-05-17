import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_bloc.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_event.dart';
import 'package:bloc_to_do/presentation/pages/tasks/widgets/add_task_button.dart';
import 'package:bloc_to_do/presentation/pages/tasks/widgets/description_input.dart';
import 'package:bloc_to_do/presentation/pages/tasks/widgets/title_input.dart';

/// Widget representing the content of a bottom sheet for adding tasks.
class TasksBottomSheetContent extends StatefulWidget {
  const TasksBottomSheetContent({super.key});

  @override
  State<TasksBottomSheetContent> createState() => _TasksBottomSheetContentState();
}

class _TasksBottomSheetContentState extends State<TasksBottomSheetContent> {
  TextEditingController? descriptionController;
  TextEditingController? titleController;

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: '');
    titleController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TitleInput(controller: titleController ?? TextEditingController()),
              const SizedBox(height: 12),
              DescriptionInput(controller: descriptionController ?? TextEditingController()),
              const SizedBox(height: 12),
              AddTaskButton(onPressed: () {
                if (titleController?.text.isEmpty ?? true) {
                  return;
                }

                context.read<TasksBloc>().add(AddNewTaskEvent(
                  title: titleController?.text ?? '',
                  description: descriptionController?.text ?? '',
                ));
                Navigator.pop(context);
              }),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}