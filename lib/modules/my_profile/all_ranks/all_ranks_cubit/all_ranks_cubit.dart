import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/models/ranks/ranks_model.dart';
import 'package:mimic/modules/my_profile/all_ranks/all_ranks_cubit/all_ranks_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'all_ranks_state.dart';

class AllRanksCubit extends Cubit<AllRanksState> {
  AllRanksCubit() : super(AllRanksInitial());
  static AllRanksCubit get(context) => BlocProvider.of(context);
  final AllRanksRepository _allRanksRepository = AllRanksRepository();
  late RanksModel ranksModel;
  
  Future<void> allRanks() async {
    if (await checkInternetConnecation()) {
      emit(AllRanksLoading());
      try {
        final response = await _allRanksRepository.getAllRanks();
        if (response.data['status']) {
          ranksModel = RanksModel.fromJson(response.data);
          emit(AllRanksSuccess());
        } else {
          emit(const AllRanksError('error'));
        }
      } catch (e) {
        emit(AllRanksError(e.toString()));
        rethrow;
      }
    } else {
      emit(const AllRanksError(AppStrings.checkInternet));
    }
  }
}
