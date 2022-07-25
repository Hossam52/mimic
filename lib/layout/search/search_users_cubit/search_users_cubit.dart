import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/layout/search/search_repository.dart';
import 'package:mimic/models/people_model/people_model.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'search_users_state.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit() : super(SearchUsersInitial());
  static SearchUsersCubit get(context) => BlocProvider.of(context);
  final SearchRepository _searchRepository = SearchRepository();
  late PeopleModel peopleModel;
  String? usernameSearched;
  List<User> allUsers = [];
  int page = 1;
  void clear() {
    page = 1;
    allUsers.clear();
    usernameSearched = null;
  }

  Future<void> getPeopleUsingName({required String name}) async {
    if (name != usernameSearched) {
      usernameSearched = name;
      if (await checkInternetConnecation()) {
        emit(SearchUsersLoading(page == 1));
        try {
          final response =
              await _searchRepository.getUsersByName(name: name, page: page++);
          if (response.data['status']) {
            peopleModel = PeopleModel.fromJson(response.data);
            allUsers = peopleModel.users;
            peopleModel.users = allUsers;
            emit(SearchUsersSuccess());
          } else {
            emit(SearchUsersError(response.data['message'] ?? 'Error '));
          }
        } catch (e) {
          emit(SearchUsersError(e.toString()));
          rethrow;
        }
      } else {
        emit(SearchUsersError(AppStrings.checkInternet));
      }
    }
  }
}
