import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
      
    @override
    List<Object?> get props => [
      id,
      title,
      description,
      isCompleted,
    ];
}
