import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/models/school_models/schoolPage/school_profile_page.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

part 'school_info_state.dart';

class SchoolInfoCubit extends Cubit<SchoolInfoState> {
  final SchoolService _schoolService ;
  SchoolInfoCubit(this._schoolService) : super(SchoolInfoInitial());

  Future<void> getSchoolInfo( {required String schoolId}) async {
    emit(SchoolInfoLoading());
    try {
      final response = await _schoolService.getSchoolById(schoolId: schoolId, token: await SecureStorageApi().getAccessToken()??'');
    if (response is SchoolProfilepage) {
      emit(SchoolInfoLoaded(schoolProfilePage: response));
    } else {
      emit(SchoolInfoError(message: response.toString()));
    }
    }catch (e) {
      logError(e.toString());
      emit(SchoolInfoError(message: e.toString()));
    }    
  }
}
