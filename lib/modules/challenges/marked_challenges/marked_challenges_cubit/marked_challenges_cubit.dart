import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/challenges/marked_challenges/marked_challenges_cubit/marked_challenges_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'marked_challenges_state.dart';

class MarkedChallengesCubit extends Cubit<MarkedChallengesState> {
  MarkedChallengesCubit() : super(MarkedChallengesInitial());
  static MarkedChallengesCubit get(context) => BlocProvider.of(context);
  late ChallengesModel challengesModel;
  List<Challange> allFavChallenges = [];
  final MarkedChallengesRepository _markedChallengesRepository =
      MarkedChallengesRepository();
  int page = 1;
  void clear() {
    page = 1;
    allFavChallenges.clear();
  }

  Future<void> getFavChallenges() async {
    if (await checkInternetConnecation()) {
      try {
        emit(MarkedChallengesLoading(page==1));
        final response = await _markedChallengesRepository.getMyFavChallenges(
          page: page++,
        );
        if (response.data['status']) {
          challengesModel = ChallengesModel.fromJson(response.data);
          allFavChallenges.addAll(challengesModel.challenges.data);
          challengesModel.challenges.data = allFavChallenges;
          emit(MarkedChallengesSuccess());
        } else {
          allFavChallenges.clear();
          emit(MarkedChallengesSuccess());
        }
      } catch (e) {
        emit(MarkedChallengesError(e.toString()));
        rethrow;
      }
    } else {
      emit(MarkedChallengesError(AppStrings.checkInternet));
    }
  }
}
