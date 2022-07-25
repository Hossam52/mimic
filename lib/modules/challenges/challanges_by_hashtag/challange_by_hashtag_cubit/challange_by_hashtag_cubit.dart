import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/challenges/challanges_by_hashtag/challange_by_hashtag_cubit/challange_by_hashtag_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'challange_by_hashtag_state.dart';

class ChallangeByHashtagCubit extends Cubit<ChallangeByHashtagState> {
  ChallangeByHashtagCubit() : super(ChallangeByHashtagInitial());
  static ChallangeByHashtagCubit get(context) => BlocProvider.of(context);
  final ChallangeByHashtagRepository _challangeByHashtagRepository =
      ChallangeByHashtagRepository();
  late ChallengesModel challengesModel;
  List<Challange> allChallanges = [];
  int page = 1;
  void clear() {
    page = 1;
    allChallanges = [];
  }

  Future<void> getAllChallangesByHashtagId({required int hashtagId}) async {
    if (await checkInternetConnecation()) {
      emit(ChallangeByHashtagLoading(page == 1));
      try {
        final response =
            await _challangeByHashtagRepository.getChallangesByHashtagId(
          hashtagId,
          page: page++,
        );
        challengesModel = ChallengesModel.fromJson(response.data);
        allChallanges.addAll(challengesModel.challenges.data);
        challengesModel.challenges.data = allChallanges;
        emit(ChallangeByHashtagSuccess());
      } catch (e) {
        emit(ChallangeByHashtagError(e.toString()));

        rethrow;
      }
    } else {
      emit(ChallangeByHashtagError(AppStrings.checkInternet));
    }
  }
}
