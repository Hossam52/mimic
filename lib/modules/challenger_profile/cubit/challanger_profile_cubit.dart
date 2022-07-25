
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/models/enums/challengesUser.dart';
import 'package:mimic/models/user_model/user_model.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

import 'challanger_profile_repository.dart';

part 'challanger_profile_state.dart';

class ChallangerProfileCubit extends Cubit<ChallangerProfileState> {
  ChallangerProfileCubit() : super(ChallangerProfileLoading(true));
  static ChallangerProfileCubit get(context) => BlocProvider.of(context);
  int selectedFilter =
      ChallengesUserEnum.created.index; //0 to created and 1 to joined
  int pageCreated = 1;
  int pageJoined = 1;
  late UserModel challenger;
  late ChallengesModel challengesModel;
  late ChallengesModel challengeJoinedsModel;
  List<Challange> challengesCreatedByUser = [];
  List<Challange> challengesJoinedByUser = [];
  int? challangerId;
  final ChallengerProfileRepository _challengerProfileRepository =
      ChallengerProfileRepository();
  Future<void> getAllDataChallenger(dynamic id, {int page = 1}) async {
    if (await checkInternetConnecation()) {
      emit(ChallangerProfileLoading(page == 1));
      try {
        final responseChallanger =
            await _challengerProfileRepository.getProfileDataChallenger(id);
        //log(responseChallanger.data.toString());
        if (responseChallanger.data['status']) {
          challenger = UserModel.fromJson(responseChallanger.data);
          challangerId = challenger.user.id;
          final responses = await Future.wait([
            _challengerProfileRepository
                .getChallengesByCreatorId(challangerId!),
            _challengerProfileRepository.getChallangeJoinedById(challangerId!),
          ]);
          // log(responses[1].data.toString());

          if (responses[0].data['status'] && responses[1].data['status']) {
            //created
            challengesModel = ChallengesModel.fromJson(responses[0].data);
            challengesCreatedByUser.addAll(challengesModel.challenges.data);
            challengesModel.challenges.data = challengesCreatedByUser;
            //joined
            challengeJoinedsModel = ChallengesModel.fromJson(responses[1].data);
            challengesJoinedByUser
                .addAll(challengeJoinedsModel.challenges.data);
            challengeJoinedsModel.challenges.data = challengesJoinedByUser;
            //  log(challengesCreatedByUser.length.toString());
            emit(ChallangerProfileSuccess());
          } else {
            responses[0].data['status'] == false
                ? challengesCreatedByUser.clear()
                : challengesJoinedByUser.clear();
            if (!responses[0].data['status'] && !responses[1].data['status']) {
              challengesCreatedByUser.clear();
              challengesJoinedByUser.clear();
            }

            emit(ChallangerProfileSuccess());
          }
        } else {
          emit(
              ChallangerProfileError(responseChallanger.data['message'] ?? ''));
        }
      } catch (e) {
        emit(ChallangerProfileError(e.toString()));

        rethrow;
      }
    } else {
      emit(ChallangerProfileError(AppStrings.checkInternet));
    }
  }

  Future<void> getMoreChallengesCreated() async {
    if (challengesModel.challenges.links.next != null) {
      if (await checkInternetConnecation()) {
        emit(ChallangerProfileLoading(false));
        try {
          final response = await _challengerProfileRepository
              .getChallengesByCreatorId(challangerId!, page: ++pageCreated);
          if (response.data['status']) {
            challengesModel = ChallengesModel.fromJson(response.data);
            challengesCreatedByUser.addAll(challengesModel.challenges.data);
            challengesModel.challenges.data = challengesCreatedByUser;
            emit(ChallangerProfileSuccess());
          } else {
            emit(ChallangerProfileError(response.data['message'] ?? ''));
          }
        } catch (e) {
          rethrow;
        }
      } else {
        emit(ChallangerProfileError(AppStrings.checkInternet));
      }
    }
  }

  Future<void> getMoreChallengesJoined() async {
    if (challengeJoinedsModel.challenges.links.next != null) {
      if (await checkInternetConnecation()) {
        emit(ChallangerProfileLoading(false));
        try {
          final response =
              await _challengerProfileRepository.getChallangeJoinedById(
            challangerId!,
            page: ++pageJoined,
          );
          if (response.data['status']) {
            challengeJoinedsModel = ChallengesModel.fromJson(response.data);
            challengesJoinedByUser.addAll(challengesModel.challenges.data);
            challengeJoinedsModel.challenges.data = challengesJoinedByUser;
            emit(ChallangerProfileSuccess());
          } else {
            emit(ChallangerProfileError(response.data['message'] ?? ''));
          }
        } catch (e) {
          rethrow;
        }
      } else {
        emit(ChallangerProfileError(AppStrings.checkInternet));
      }
    }
  }

  void selectFilteredChallenges(int index) {
    if (selectedFilter != index) {
      selectedFilter = index;
      emit(ChallangerProfileSuccess());
    }
  }
}
