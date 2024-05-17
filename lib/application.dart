import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc_to_do/presentation/pages/tasks/view/tasks_page.dart';

class Application extends StatelessWidget {
  final SharedPreferences sharedPref;

  const Application({
    super.key,
    required this.sharedPref,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            bodyLarge: GoogleFonts.raleway(),
          ),
        ),
        routes: {
          '/': (context) => TasksPage(sharedPref: sharedPref),
        },
        initialRoute: '/',
      ),
    );
  }
}
