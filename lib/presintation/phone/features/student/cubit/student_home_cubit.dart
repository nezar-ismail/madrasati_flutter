import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';

part 'student_home_state.dart';

class UserProfileCubit extends Cubit<LocalStudent?> {
  UserProfileCubit() : super(UserBox.getUser()) {
    _initUserBoxListener();
  }

  void _initUserBoxListener() {
    final box = UserBox.box; // Use the public getter here

    // Ensure the box is opened before listening
    if (box.isOpen) {
      box.listenable().addListener(() {
        emit(UserBox.getUser());
      });
    } else {
      emitErrorState('User box is not open.');
    }
  }

  void emitErrorState(String message) {
    // Handle error state or logging
    log('Error: $message');
    emit(null); // Emit null or handle according to your logic
  }

  @override
  Future<void> close() {
    final box = UserBox.box; // Use the public getter here
    if (box.isOpen) {
      box.listenable().removeListener(() {});
    }
    return super.close();
  }
}
