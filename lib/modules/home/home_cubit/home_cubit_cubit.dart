import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/home/home_cubit/repository_home.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/helpers/error_handling/failure_model.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitLoading(true));
  static HomeCubitCubit get(context) => BlocProvider.of(context);
  final HomeRepository _homeRepository = HomeRepository();
  List<Challange> challanges = [];
  late ChallengesModel _challengesModel;
  bool get getChallengesNext {
    return _challengesModel.challenges.links!=null &&_challengesModel.challenges.links.next != null;
  }

  int selectedPage = 1;
  void clear() {
    selectedPage = 1;
    challanges.clear();
  }

  Future<void> getHomeData() async {
    if (await checkInternetConnecation()) {
      try {
        emit(HomeCubitLoading(selectedPage == 1));
        final response =
            await _homeRepository.getCurrentChallanges(page: selectedPage++);
        // log(response.toString());

        if (response.data['status']) {
          _challengesModel = ChallengesModel.fromJson(response.data);
          //challanges = _challengesModel.challenges.data;
          challanges.addAll(_challengesModel.challenges.data);
          _challengesModel.challenges.data = challanges;
          log(response.data.toString());
          emit(HomeCubitSuccess());
        } else {
          emit(HomeCubitError(Failure(
                  code: response.statusCode ?? 404,
                  message: response.data['message'])
              .message));
        }
      } catch (e) {
        emit(HomeCubitError(e.toString()));
        rethrow;
      }
    } else {
      emit(HomeCubitError(AppStrings.checkInternet));
    }
  }
}
