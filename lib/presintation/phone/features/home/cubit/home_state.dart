part of 'home_cubit.dart';

abstract class SchoolPagingState extends Equatable {
  const SchoolPagingState();

  @override
  List<Object> get props => [];
}

class SchoolInitial extends SchoolPagingState {}

class SchoolLoading extends SchoolPagingState {}

class SchoolLoaded extends SchoolPagingState {
  final List<Widget> schools; // Store widgets for displaying
  final bool hasMore;

  const SchoolLoaded({required this.schools, required this.hasMore});

  @override
  List<Object> get props => [schools, hasMore];
}

class SchoolError extends SchoolPagingState {
  final String message;

  const SchoolError(this.message);

  @override
  List<Object> get props => [message];
}
