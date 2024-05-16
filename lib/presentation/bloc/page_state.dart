import 'package:equatable/equatable.dart';

enum PageStatus {
  initial,
}

class PageState extends Equatable {
  final PageStatus status;
  final List<Task> tasks
  
  
  
  @override
  List<Object?> get props => throw UnimplementedError();

}