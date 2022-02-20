import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/dialog_card.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/rounded_image.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      backgroundColor: ColorManager.commentsBackgroundColor,
      headerTitle: 'Reactions',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _commentStatistics(),
          const SizedBox(height: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _comments()),
            ],
          )),
          const _CommentFieldAndActions(),
        ],
      ),
    );
  }

  Widget _commentStatistics() {
    return Row(
      children: [
        Text(
          '40 comment',
          style: getBoldStyle(fontSize: FontSize.s16),
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: ColorManager.favoriteColor,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    MimicIcons.favoriteOutline,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '75',
              style: getRegularStyle(),
            )
          ],
        )
      ],
    );
  }

  Widget _comments() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return const _CommentItem();
        });
  }
}

class _CommentItem extends StatelessWidget {
  const _CommentItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CommentPersonDetails(),
            const SizedBox(height: 15),
            _commentBody(),
            _commentActions()
          ],
        ),
      ),
    );
  }

  Widget _commentBody() {
    return Text(
      AppStrings.commentBody,
      style: getRegularStyle(),
    );
  }

  Widget _commentActions() {
    return Wrap(
      spacing: 20,
      children: [
        Icon(
          MimicIcons.favoriteOutline,
          color: ColorManager.favoriteColor,
        ),
        Icon(
          MimicIcons.commentOutline,
          color: ColorManager.commentsColor,
        )
      ],
    );
  }
}

class _CommentPersonDetails extends StatelessWidget {
  const _CommentPersonDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            child: RoundedImage(
          imagePath: 'assets/images/static/avatar.png',
        )),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ola ahmed',
                style: getBoldStyle(fontSize: FontSize.s14),
              ),
              Text(
                '2 Min ago',
                style: getRegularStyle(color: ColorManager.timeAgo),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentFieldAndActions extends StatelessWidget {
  const _CommentFieldAndActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: _commentField()),
          const SizedBox(width: 10),
          const SizedBox(width: 20),
          Icon(Icons.sentiment_satisfied_sharp,
              color: ColorManager.emotionColor),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: ColorManager.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Icon(
                    Icons.send,
                    color: ColorManager.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentField() {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: TextEditingController(),
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        filled: true,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        hintText: 'Write a comments',
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        fillColor: ColorManager.white,
      ),
    );
  }
}
