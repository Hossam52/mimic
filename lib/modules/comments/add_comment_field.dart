import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';

import 'mention_cubit/mention_cubit.dart';

// ignore: must_be_immutable
class AddComment extends StatelessWidget {
  final TextEditingController textEditingController;
  final BuildContext mentionCubit;
  final FocusNode focusNode;
  //final BuildContext rebuildContext;
  final GlobalKey<FlutterMentionsState> mentionKey;
  AddComment(
    this.textEditingController, {
    required this.focusNode,
    required this.mentionCubit,
    required this.mentionKey,
    this.hint,
    // required this.rebuildContext,
  });
  String? hint;
  @override
  Widget build(BuildContext context) {
    Set<String> idsMention = {};
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSize.s50.r)),
      borderSide: BorderSide.none,
    );
    return FlutterMentions(
      focusNode: focusNode,
      key: mentionKey,
      appendSpaceOnAdd: true,
      suggestionPosition: SuggestionPosition.Top,
      suggestionListDecoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s5.r),
      ),
      enableSuggestions: true,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        filled: true,
        labelText:hint!=null?'Reply' :'Comment',
         
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p8.w),
        hintText: hint??AppStrings.writeAcomment,
        fillColor: ColorManager.white,

        //suffix: suffix,
        border: border,
      ),
      onMentionAdd: (value) {
        idsMention.add(value['id']);
        MentionCubit.get(mentionCubit).mentionsIds = idsMention;
      },
      onSearchChanged: (value, v) {
        // print('Search');
        MentionCubit.get(mentionCubit).getMentions(username: v);
      },
      
      onMarkupChanged: (value) {
        //print('Markup Text Changed');
        log(value.split(RegExp(r"[0-9]+")).toString());
        //@[___id____](___name___)=>markUp
        log(value.toString());
        log(mentionKey.currentState!.controller!.markupText);
        log(mentionKey.currentState!.controller!.text);

        // print(value.split(RegExp(r"[a-zA-Z]+")));
      },
      onChanged: (value) {
        textEditingController.text = value;
      },
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
