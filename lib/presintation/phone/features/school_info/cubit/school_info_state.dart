part of 'school_info_cubit.dart';

sealed class SchoolInfoState extends Equatable {
  const SchoolInfoState();

  @override
  List<Object> get props => [];
}

final class SchoolInfoInitial extends SchoolInfoState {}

final class SchoolInfoLoading extends SchoolInfoState {}

final class SchoolInfoLoaded extends SchoolInfoState {
  final SchoolProfilepage schoolProfilePage;
  const SchoolInfoLoaded({required this.schoolProfilePage});
}

final class SchoolInfoError extends SchoolInfoState {
  final String message;
  const SchoolInfoError({required this.message});
}


final class FeedbackLoaded extends SchoolInfoState {
  final List<FeedbackContent> feedbackContents; 
  final bool hasMore;

  const FeedbackLoaded({required this.feedbackContents, required this.hasMore});

  @override
  List<Object> get props => [feedbackContents, hasMore];
}


