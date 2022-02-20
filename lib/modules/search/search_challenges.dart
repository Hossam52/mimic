import 'package:flutter/material.dart';
import 'package:mimic/modules/search/widgets/search_text_field.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/rounded_image.dart';

class SearchChallenges extends StatelessWidget {
  const SearchChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CustomSearchField(
            searchTextHint: 'Challenge title',
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: _CategoryDropDown()),
              SizedBox(width: 20),
              Expanded(child: _CategoryDatePublished()),
            ],
          ),
          SizedBox(height: 20),
          Expanded(child: _searchedChallenges())
        ],
      ),
    );
  }

  Widget _searchedChallenges() {
    return GridView.builder(
        itemCount: 14,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5 / 6,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        itemBuilder: (_, index) {
          return const _SearchedChallengeItem();
        });
  }
}

class _CategoryDropDown extends StatelessWidget {
  const _CategoryDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: CustomDropDown(
        child: DropdownButton<String>(
          hint: Text(
            'Category',
            style: getRegularStyle(fontSize: FontSize.s16),
          ),
          items: [
            DropdownMenuItem(
              value: '1',
              child: Text(
                'Category1',
                style: getRegularStyle(fontSize: FontSize.s16),
              ),
            ),
            DropdownMenuItem(
              value: '2',
              child: Text(
                'Category2',
                style: getRegularStyle(fontSize: FontSize.s16),
              ),
            ),
          ],
          onChanged: (val) {},
        ),
      ),
    );
  }
}

class _CategoryDatePublished extends StatelessWidget {
  const _CategoryDatePublished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: CustomDropDown(
        child: DropdownButton<String>(
          hint: Text(
            'Date published',
            style: getRegularStyle(fontSize: FontSize.s16),
          ),
          items: [
            DropdownMenuItem(
              value: '1',
              child: Text(
                '2022',
                style: getRegularStyle(fontSize: FontSize.s16),
              ),
            ),
            DropdownMenuItem(
              value: '2',
              child: Text(
                '2021',
                style: getRegularStyle(fontSize: FontSize.s16),
              ),
            ),
          ],
          onChanged: (val) {},
        ),
      ),
    );
  }
}

class _SearchedChallengeItem extends StatelessWidget {
  const _SearchedChallengeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      shadow: 8,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/static/video_preview.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const RoundedImage(
                      imagePath: 'assets/images/static/avatar.png'),
                  const SizedBox(width: 10),
                  Text(
                    'Ola Ahmed',
                    style: getRegularStyle(fontSize: FontSize.s16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
