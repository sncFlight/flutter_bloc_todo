import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_bloc.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_event.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_state.dart';
import 'package:bloc_to_do/presentation/pages/tasks/view/snack_bar_content.dart';
import 'package:bloc_to_do/presentation/pages/tasks/widgets/task_card.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_loader.dart';

class TasksContent extends StatefulWidget {
  const TasksContent({super.key});

  @override
  State<TasksContent> createState() => _TasksContentState();
}

class _TasksContentState extends State<TasksContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: BlocConsumer<TasksBloc, TasksState>(
          listener: (BuildContext context, TasksState state) {
            if (state.snackBarMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.fixed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  content: SnackBarContent(message: state.snackBarMessage),
                ),
              );
            }
          },
          builder: (BuildContext context, TasksState state) {
            if (state.status == TasksStatus.failure) {
              return const Center(child: Text('Произошла ошибка при загрузке'));
            } else if (state.status == TasksStatus.success) {
              return _buildListView(state);
            } else if (state.status == TasksStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController..removeListener(_onScroll)..dispose();
    super.dispose();
  }

  Widget _buildListView(TasksState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index < state.tasks.length) {
            return TaskCard(
              task: state.tasks[index],
              onClicked: () => context.read<TasksBloc>().add(TaskClickedEvent(task: state.tasks[index])),
            );
          } else if (
            index >= state.tasks.length
            && state.status == TasksStatus.loadingMore
          ) {
            return const BottomLoader();
          } else {
            return const SizedBox.shrink();
          }
        },
        itemCount: state.hasReachedEnd
          ? state.tasks.length
          : state.tasks.length + 1,
        controller: _scrollController,
      ),
    );
  }

  // Method to check if the user has scrolled to the bottom of the list
  void _onScroll() {
    if (_isReachedBottom) {
      context.read<TasksBloc>().add(const FetchNextPageEvent());
    }
  }

  // Method to handle scrolling behavior and trigger events when reaching the bottom of the list
  bool get _isReachedBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }
}
