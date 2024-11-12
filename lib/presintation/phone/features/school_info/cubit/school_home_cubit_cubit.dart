import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:madrasati/data/hive/school/s_manger_box.dart';
import 'package:madrasati/data/hive/school/s_manger_field.dart';

part 'school_home_cubit_state.dart';

class SchoolHomeCubit extends Cubit<LocalSchoolManger?> {
  SchoolHomeCubit() : super(SMangerBox.getUser()){
    _initUserBoxListener();
  }


/// Initializes a listener on the `UserBox` to emit the current user state
/// whenever there are changes in the box. If the box is not open, it emits
/// an error state indicating that the user box is not open.
  void _initUserBoxListener() {
    final box = SMangerBox.box; // Use the public getter here

    // Ensure the box is opened before listening
    if (box.isOpen) {
      box.listenable().addListener(() {
        emit(SMangerBox.getUser());
      });
    } else {
      emitErrorState('User box is not open.');
    }
  }

  /// Handles emitting an error state by logging the message and emitting null.
  ///
  /// This is a temporary measure until proper error handling is implemented.
  ///
  /// [message] is the error message to log.
  void emitErrorState(String message) {
    // Handle error state or logging
    log('Error: $message');
    emit(null); // Emit null or handle according to your logic
  }

  @override
/// Closes the `UserProfileCubit`, ensuring that any listeners on the
/// `UserBox` are removed if the box is open, and then calls the
/// superclass's `close` method.
  Future<void> close() {
    final box = SMangerBox.box; // Use the public getter here
    if (box.isOpen) {
      box.listenable().removeListener(() {});
    }
    return super.close();
  }
}
