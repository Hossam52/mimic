import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/layout/search/search_repository.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'search_challanges_state.dart';

class SearchChallangesCubit extends Cubit<SearchChallangesState> {
  SearchChallangesCubit() : super(SearchChallangesInitial());
  static SearchChallangesCubit get(context) => BlocProvider.of(context);
  List<Challange> allChallanges = [];
  final SearchRepository _searchRepository = SearchRepository();
  late ChallengesModel _challengesModel;
  int page = 1;
  int? selectedCategoryId;
  int? selectedPeriod;
  void setCategory(int categoryId) {
    selectedCategoryId = categoryId;
  }

  void setPeriod(int period) {
    selectedPeriod = period;
  }

  void clear() {
    page = 1;
    selectedCategoryId = null;
    selectedPeriod = null;
    allChallanges.clear();
  }

  Future<void> searchOnChallanges({int? categoryId, int? year}) async {
    if (await checkInternetConnecation()) {
      emit(SearchChallangesLoading(page == 1));
      try {
        final response = await _searchRepository.searchOnChallanges(
          categoryId: selectedCategoryId,
          period: selectedPeriod,
        );
        if (response.data['status']) {
          _challengesModel = ChallengesModel.fromJson(response.data);
          allChallanges = _challengesModel.challenges.data;
          emit(SearchChallangesSuccess());
        } else {
          allChallanges = [];
          emit(SearchChallangesError(response.data['message'] ?? 'Error'));
        }
      } catch (e) {
        emit(SearchChallangesError(e.toString()));
        rethrow;
      }
    } else {
      emit(SearchChallangesError(AppStrings.checkInternet));
    }
  }
}
