part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SchoolAlreadyLogin extends SplashState {}

final class UserLoggedOut extends SplashState {}

final class SplashLoading extends SplashState {}

final class InternetError extends SplashState {}

final class SplashError extends SplashState {}

final class InternetConnected extends SplashState {}

final class StudentAlreadyLogin extends SplashState {}

final class GuestAlreadyLogin extends SplashState {}

final class Loading extends SplashState {}