import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc_to_do/data/source/local_storage.dart';
import 'package:bloc_to_do/data/task_repository_impl.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';
import 'package:bloc_to_do/domain/usecases/add_task.dart';
import 'package:bloc_to_do/domain/usecases/get_tasks.dart';
import 'package:bloc_to_do/domain/usecases/remove_task.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_bloc.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_event.dart';
import 'package:bloc_to_do/presentation/pages/tasks/view/tasks_content.dart';
import 'package:bloc_to_do/presentation/pages/tasks/view/tasks_floating_action_button.dart';

class TasksPage extends StatefulWidget {
  final SharedPreferences sharedPref;

  const TasksPage({
    super.key,
    required this.sharedPref,
  });
  
  @override
  State<StatefulWidget> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin {
  LocalStorage? localStorage;
  TasksRepository? tasksRepository;
  GetTasks? getTasks;
  AddTask? addTask;
  RemoveTask? removeTask;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    tasksRepository = TasksRepositoryImpl(dataSource: LocalStorage(sharedPref: widget.sharedPref));
    addTask = AddTask(repository: tasksRepository!);
    getTasks = GetTasks(repository: tasksRepository!);
    removeTask = RemoveTask(repository: tasksRepository!);

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // initializing locale info for date
    initializeDateFormatting('ru', null).then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color appBarColor = Color(0xFF8E2DE2);
    const Color backgroundColor = Color(0xFF4A00E0);

    final List<Color> gradientColors = [
      appBarColor,
      backgroundColor,
    ];

    return BlocProvider(
      create: (context) => TasksBloc(
        getTasks: getTasks!,
        addTask: addTask!,
        removeTask: removeTask!,
      )..add(const LoadFirstPageEvent()),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: appBarColor,
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  'Добрый день!\n${_getFormattedDate()}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const TasksContent(),
              ),
            ),
          ],
        ),
        floatingActionButton: const TasksFloatingActionButton(),
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d MMMM', 'ru');
    return formatter.format(now);
  }
}




