import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/people_model/people_model.dart';
import 'package:mimic/modules/search/discover_cubit/discover_repository.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(DiscoverInitial());
  static DiscoverCubit get(context) => BlocProvider.of(context);
  final DiscoveryRepository _discoveryRepository = DiscoveryRepository();
  late PeopleModel peopleModel;
  Future<void> getPeopleUsingName({required String name}) async {
    if (await checkInternetConnecation()) {
      emit(DiscoverLoading());
      try {
        final response = await _discoveryRepository.getUsersByName(name: name);
        if (response.data['status']) 
        {
          peopleModel = PeopleModel.fromJson(response.data);
          emit(DiscoverSuccess());
        } else {
          emit(DiscoverError());
        }
      } catch (e) {
        emit(DiscoverError());
        rethrow;
      }
    } else {
      emit(DiscoverError());
    }
  }
}
