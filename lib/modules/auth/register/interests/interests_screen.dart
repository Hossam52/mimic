import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_check_box.dart';
import 'package:mimic/widgets/defulat_button.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  bool selectAll = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Choose your interests'),
        titleTextStyle: getBoldStyle(fontSize: FontSize.s16),
        elevation: 0,
        leading: BackButton(color: ColorManager.black),
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        _selectAll(),
        const Expanded(child: _InterestsGridView()),
      ]),
    );
  }

  Widget _selectAll() {
    return DefaultCheckbox(
      val: selectAll,
      text: 'Select All',
      onChange: (val) {
        setState(() {
          selectAll = val!;
          if (val == true) {
            for (int i = 0; i < _InteresModel.data.length; i++) {
              _InteresModel.data[i].isSelected = false;
            }
          }
        });
      },
    );
  }
}

class _InterestsGridView extends StatelessWidget {
  const _InterestsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = _InteresModel.data;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GridView.builder(
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1),
            itemBuilder: (_, index) {
              return _InterestItem(
                intrest: data[index],
              );
            },
            itemCount: data.length,
          ),
          Positioned(
            bottom: 20,
            child: _nextButton(context),
          ),
        ],
      ),
    );
  }

  Widget _nextButton(context) {
    return DefaultButton(
      text: 'Next',
      trailing: const Icon(Icons.arrow_forward),
      onPressed: () {
        navigateTo(context, Routes.privacyPolicy);
      },
      backgroundColor: Theme.of(context).primaryColor,
      radius: 10,
      foregroundColor: ColorManager.white,
    );
  }
}

class _InterestItem extends StatelessWidget {
  const _InterestItem({Key? key, required this.intrest}) : super(key: key);
  final _InteresModel intrest;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s18),
        ),
        clipBehavior: Clip.hardEdge,
        child: intrest.isSelected ? _selectedItem() : _item());
  }

  Widget _item() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(intrest.imagePath,
            width: double.infinity, height: double.infinity, fit: BoxFit.fill),
        Positioned(
          bottom: 0,
          child: Container(
            color: ColorManager.grey.withOpacity(0.6),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1990),
              child: Text(
                intrest.categoryName,
                style: getBoldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectedItem() {
    return Stack(
      children: [
        _item(),
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.lightGrey.withOpacity(0.5),
          ),
          child: Center(
            child: SvgPicture.asset('assets/images/icons/selected_icon.svg'),
          ),
        )
      ],
    );
  }
}

class _InteresModel {
  final String imagePath;
  final String categoryName;
  bool isSelected;

  _InteresModel(
      {required this.imagePath,
      required this.categoryName,
      this.isSelected = false});
  static List<_InteresModel> data = [
    _InteresModel(
        imagePath: 'assets/images/static/interest1.png',
        categoryName: 'Sports'),
    _InteresModel(
        imagePath: 'assets/images/static/interest2.png', categoryName: 'Yoga'),
    _InteresModel(
        imagePath: 'assets/images/static/interest3.png',
        categoryName: 'Athelets'),
    _InteresModel(
        imagePath: 'assets/images/static/interest4.png',
        categoryName: 'Basket'),
    _InteresModel(
        imagePath: 'assets/images/static/interest5.png', categoryName: 'Run'),
    _InteresModel(
        imagePath: 'assets/images/static/interest6.png',
        categoryName: 'Swimming'),
  ];
}
