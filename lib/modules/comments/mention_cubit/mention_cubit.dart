import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/user_model/user_abstract.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/modules/comments/mention_cubit/mention_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';

part 'mention_state.dart';

class MentionCubit extends Cubit<MentionState> {
  MentionCubit() : super(MentionInitial());
  static MentionCubit get(context) => BlocProvider.of(context);
  List<UserAbstractModel> mentionsList = [];
  List<Map<String, String>> data = [];
  Set<String> mentionsIds = {};
  Set<UserAbstract> mentionPeople = {};
  final MentionRepository _mentionRepository = MentionRepository();
  void rebuildUIAddPerson(UserAbstract user) {
    if (mentionPeople.contains(user)) {
      emit(MentionRebuildUIExists(AppStrings.aleardyExists));
    } else {
      mentionPeople.add(user);
      emit(MentionRebuildUI());
    }
  }

  void rebuildUIDeletePerson(UserAbstract userAbstract) {
    mentionPeople.remove(userAbstract);
    emit(MentionRebuildUI());
  }

  Future<void> getMentions({required String username}) async {
    emit(MentionLoading());
    data = [];
    try {
      final response =
          await _mentionRepository.getMentionList(username: username);
      if (response.data['status']) {
        mentionsList = List.from(response.data['RC'])
            .map((e) => UserAbstractModel.fromJson(e))
            .toList();
        log('mentionList${mentionsList.length}');
        data = [];
        for (int index = 0; index < mentionsList.length; index++) {
          data.add(
            {
              "id": mentionsList[index].id.toString(),
              "display": mentionsList[index].name!,
              "photo": mentionsList[index].image,
            },
          );
        }
        print('Mentions');
        emit(MentionSuccess());
      }
    } catch (e) {
      emit(MentionError());

      rethrow;
    }
  }
}
