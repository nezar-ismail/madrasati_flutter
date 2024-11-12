part of 'edit_password_cubit.dart';

sealed class EditPasswordState extends Equatable {
  const EditPasswordState();

  @override
  List<Object> get props => [];
}

final class EditPasswordInitial extends EditPasswordState {}

final class EditPasswordLoading extends EditPasswordState {}

final class EditPasswordError extends EditPasswordState {
  final String message;
  const EditPasswordError({required this.message});
}

final class EditPasswordSuccess extends EditPasswordState {}

