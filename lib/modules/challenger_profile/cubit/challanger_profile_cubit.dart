import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/models/user_model/user_model.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

import 'challanger_profile_repository.dart';

part 'challanger_profile_state.dart';

class ChallangerProfileCubit extends Cubit<ChallangerProfileState> {
  ChallangerProfileCubit() : super(ChallangerProfileLoading(true));
  static ChallangerProfileCubit get(context) => BlocProvider.of(context);
  late UserModel challenger;
  final ChallengerProfileRepository _challengerProfileRepository =
      ChallengerProfileRepository();
  Future<void> getAllDataChallenger(int id, {int page = 1}) async {
    if (await checkInternetConnecation()) {
      emit(ChallangerProfileLoading(page == 1));
      try {
        final responses = await Future.wait([
          _challengerProfileRepository.getProfileDataChallenger(id),
          _challengerProfileRepository.getChallengesByCreatorId(id),
        ]);
        log(responses[0].data.toString());
        // log(responses[1].data.toString());

        if (responses[0].data['status'] && !responses[1].data['status']) {
          challenger = UserModel.fromJson(responses[0].data);
          emit(ChallangerProfileSuccess());
        } else {
          emit(ChallangerProfileError(responses[0].data['message'] ?? ''));
        }
      } catch (e) {
        emit(ChallangerProfileError(e.toString()));

        rethrow;
      }
    } else {
      emit(ChallangerProfileError(AppStrings.checkInternet));
    }
  }
}
