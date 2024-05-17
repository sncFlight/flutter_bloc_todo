import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

/// Widget for entering task description.
///
/// This widget provides a text input field for entering the description of a task.
class DescriptionInput extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionInput({
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
        controller: controller,
        maxLines: null,
        style: GoogleFonts.raleway(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: 'Описание',
          hintStyle: GoogleFonts.raleway(
            fontSize: 16,
            color: Colors.grey.shade500,
          ),
          border: InputBorder.none,
          isCollapsed: true,
        ),
      ),
    );
  }
}
