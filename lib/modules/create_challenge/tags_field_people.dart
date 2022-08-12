import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/user_model/user_abstract.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/modules/comments/mention_cubit/mention_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';

// ignore: must_be_immutable
class TagFieldPeople extends StatelessWidget {
  // final TextEditingController textEditingController;
  final BuildContext mentionCubit;
  final FocusNode focusNode;
  //final BuildContext rebuildContext;
  final GlobalKey<FlutterMentionsState> mentionKey;
  TagFieldPeople(
    // this.textEditingController,
     {
    required this.focusNode,
    required this.mentionCubit,
    required this.mentionKey,
    this.hint,
    // required this.rebuildContext,
  });
  String? hint;
  @override
  Widget build(BuildContext context) {
    // Set<String> idsMention = {};
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: ColorManager.grey),
    );
    return FlutterMentions(
      focusNode: focusNode,
      key: mentionKey,
      appendSpaceOnAdd: true,
      suggestionPosition: SuggestionPosition.Bottom,
      suggestionListDecoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      enableSuggestions: true,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        filled: true,

        labelText: AppStrings.tagYourFriends,

        labelStyle: getSemiBoldStyle(),

        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p8.w),
        hintText: AppStrings.tagYourFriendsAddaThenChoice,
        fillColor: ColorManager.white,

        //suffix: suffix,
        border: border,
      ),
      onMentionAdd: (value) {
       
        MentionCubit.get(mentionCubit).rebuildUIAddPerson(UserAbstract(
            id: int.parse(value['id']),
            image: value['photo'],
            name: value['display']));
        if (mentionKey.currentState!.controller != null) {
          mentionKey.currentState!.controller!.clear();
        }
        // textEditingController.clear();
      },
      onSearchChanged: (value, v) {
        MentionCubit.get(mentionCubit).getMentions(username: v);
      },
      onMarkupChanged: (value) {
        //print('Markup Text Changed');
        // log(value.split(RegExp(r"[0-9]+")).toString());
        //@[___id____](___name___)=>markUp
        log(value.toString());
        log('Changed');
        // mentionKey.currentState!.controller!.;
        log(mentionKey.currentState!.controller!.markupText);
        log(mentionKey.currentState!.controller!.text);

        // print(value.split(RegExp(r"[a-zA-Z]+")));
      },
      // onChanged: (value) {
      //   textEditingController.text = value;
      // },
      mentions: [
        Mention(
          trigger: "@",
          //  disableMarkup: true,
          //matchAll: true,
          style: TextStyle(color: ColorManager.primary),
          data: MentionCubit.get(context).data.toList(),

          suggestionBuilder: (map) => Padding(
            padding:
                EdgeInsetsDirectional.only(start: 20.w, bottom: 5.h, end: 20.w),
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                cachedNetworkImageProvider(map['photo'], 30.r),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  map['display'],
                  style: getMediumStyle(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
