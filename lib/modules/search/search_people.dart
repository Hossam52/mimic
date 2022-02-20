import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/search/widgets/search_text_field.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class SearchPeople extends StatelessWidget {
  const SearchPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: CustomSearchField(
                  searchTextHint: 'User_name',
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    navigateTo(context, Routes.scanQr);
                  },
                  child: SvgPicture.asset('assets/images/qr.svg')),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(child: _searchedPeople())
        ],
      ),
    );
  }

  Widget _searchedPeople() {
    return GridView.builder(
        itemCount: 14,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5 / 6,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        itemBuilder: (_, index) {
          return const _SearchedPersonItem();
        });
  }
}

class _SearchedPersonItem extends StatelessWidget {
  const _SearchedPersonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 5,
              child: Image.asset(
                'assets/images/static/avatar.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maria Snow',
                    style: getSemiBoldStyle(fontSize: FontSize.s16),
                  ),
                  Expanded(
                    child: Center(
                      child: RatingBarIndicator(
                        itemBuilder: (_, index) {
                          return const Icon(Icons.star, color: Colors.amber);
                        },
                        rating: 5,
                        itemCount: 5,
                        itemSize: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
