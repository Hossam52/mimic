import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/models/global_models/category_model/category.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_cubit.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/default_check_box.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  bool selectAll = false;
  Widget _nextButton(context, CategoriesState state) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h, right: 65.w, left: 65.w),
      child: Visibility(
        visible: CategoriesCubit.get(context).selectedCategories.isNotEmpty,
        child: state is CategoriesSubmitLoading
            ? const LoadingProgress()
            : DefaultButton(
                text: 'Next',
                trailing: const Icon(Icons.arrow_forward),
                onPressed: () {
                  CategoriesCubit.get(context).submitCategoriesSelected();
                  //  navigateTo(context, Routes.privacyPolicy);
                },
                backgroundColor: Theme.of(context).primaryColor,
                radius: 10.r,
                foregroundColor: ColorManager.white,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getAllCategories(),
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesSubmitError) {
            Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: ColorManager.error,
                fontSize: FontSize.s16);
          } else if (state is CategoriesSubmitSuccess) {
            navigateTo(context, Routes.privacyPolicy);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Choose your interests'),
              titleTextStyle: getBoldStyle(fontSize: FontSize.s16),
              elevation: 0,
              leading: BackButton(color: ColorManager.black),
              backgroundColor: Colors.transparent,
            ),
            //todo
            floatingActionButton: _nextButton(context, state),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SingleChildScrollView(
              child: state is CategoriesLoading
                  ? const LoadingProgress()
                  : Column(children: [
                      _selectAll(context),
                      _InterestsGridView(),
                    ]),
            ),
          );
        },
      ),
    );
  }

  Widget _selectAll(BuildContext cubitContext) {
    return DefaultCheckbox(
      val: selectAll,
      text: 'Select All',
      onChange: (val) {
        selectAll = val!;
        CategoriesCubit.get(cubitContext)
            .toggleSelectAllCategories(toggleSelectAll: selectAll);
        // setState(() {
        //   ;
        //   if (val == true) {
        //     for (int i = 0; i < _InteresModel.data.length; i++) {
        //       _InteresModel.data[i].isSelected = false;
        //     }
        //   }
        // });
      },
    );
  }
}

class _InterestsGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data =
        CategoriesCubit.get(context).categoriesModel.categories.categories;
    final selectedCatepories = CategoriesCubit.get(context).selectedCategories;
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1),
      itemBuilder: (_, index) {
        return _InterestItem(
            intrest: data[index],
            selected: selectedCatepories.contains(data[index]));
      },
      itemCount: data.length,
    );
  }
}

class _InterestItem extends StatelessWidget {
  const _InterestItem({Key? key, required this.intrest, required this.selected})
      : super(key: key);
  final Category intrest;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CategoriesCubit.get(context).selecteCategory(intrest),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s18),
          ),
          clipBehavior: Clip.hardEdge,
          child: selected ? _selectedItem() : _item()),
    );
  }

  Widget _item() {
    return Stack(
      alignment: Alignment.center,
      children: [
        cachedNetworkImage(
            imageUrl: intrest.image,
            height: double.infinity,
            width: double.infinity),
        Positioned(
          bottom: 0,
          child: Container(
            color: ColorManager.grey.withOpacity(0.6),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1990),
              child: Text(
                intrest.name,
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

// class _InteresModel {
//   final String imagePath;
//   final String categoryName;
//   bool isSelected;

//   _InteresModel(
//       {required this.imagePath,
//       required this.categoryName,
//       this.isSelected = false});
//   static List<_InteresModel> data = [
//     _InteresModel(
//         imagePath: 'assets/images/static/interest1.png',
//         categoryName: 'Sports'),
//     _InteresModel(
//         imagePath: 'assets/images/static/interest2.png', categoryName: 'Yoga'),
//     _InteresModel(
//         imagePath: 'assets/images/static/interest3.png',
//         categoryName: 'Athelets'),
//     _InteresModel(
//         imagePath: 'assets/images/static/interest4.png',
//         categoryName: 'Basket'),
//     _InteresModel(
//         imagePath: 'assets/images/static/interest5.png', categoryName: 'Run'),
//     _InteresModel(
//         imagePath: 'assets/images/static/interest6.png',
//         categoryName: 'Swimming'),
//   ];
// }
