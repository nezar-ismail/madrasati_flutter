part of 'home_cubit.dart';

abstract class SchoolState extends Equatable {
  const SchoolState();

  @override
  List<Object> get props => [];
}

class SchoolInitial extends SchoolState {}

class SchoolLoading extends SchoolState {}

class SchoolLoaded extends SchoolState {
  final List<Widget> schools; // Store widgets for displaying
  final bool hasMore;

  const SchoolLoaded({required this.schools, required this.hasMore});

  @override
  List<Object> get props => [schools, hasMore];
}

class SchoolError extends SchoolState {
  final String message;

  const SchoolError(this.message);

  @override
  List<Object> get props => [message];
}
