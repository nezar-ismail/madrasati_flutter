part of 'student_home_cubit.dart';

sealed class StudentHomeState extends Equatable {
  const StudentHomeState();

  @override
  List<Object> get props => [];
}

final class StudentHomeInitial extends StudentHomeState {}

final class StudentHomeLoaded extends StudentHomeState {}

final class StudentHomeError extends StudentHomeState {
  final String message;

  const StudentHomeError({required this.message});
}

final class StudentHomeLoading extends StudentHomeState {}

