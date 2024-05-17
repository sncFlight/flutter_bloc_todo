import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

/// Widget for entering task title.
///
/// This widget provides a text input field for entering the title of a task.
class TitleInput extends StatelessWidget {
  final TextEditingController controller;

  const TitleInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Заголовок',
          hintStyle: GoogleFonts.raleway(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
          contentPadding: EdgeInsets.zero,
          isCollapsed: true,
        ),
        style: GoogleFonts.raleway(
          fontSize: 16,
          color: Colors.black87,
        ),
        controller: controller,
      ),
    );
  }
}
