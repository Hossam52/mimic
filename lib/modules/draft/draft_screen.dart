import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mimic/models/challenge_models/hashtag_model.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/modules/draft/create_challange_cubit/create_challange_cubit.dart';
import 'package:mimic/modules/draft/video_preparing_widget.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_cubit.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/shared/services/pickers_services.dart';
import 'package:mimic/widgets/default_dropdown_button.dart';
import 'package:mimic/widgets/default_text_button.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/hashtag_chip.dart';
import 'package:mimic/widgets/loading_brogress.dart';

import 'videlo_upload_loading.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({Key? key}) : super(key: key);

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  final TextEditingController challengeTitle = TextEditingController();
  final TextEditingController newHashtag = TextEditingController();

  final TextEditingController chooseCategory = TextEditingController();
  final TextEditingController selectedEndDate = TextEditingController();
  String? selectedCategory;
  final TextEditingController challangeDetails = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? pickedVide;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperMethods.closeKeyboard(context),
      child: Scaffold(
        appBar: const TransparentAppBar(title: AppStrings.draft),
        body: BlocProvider(
          create: (context) => CategoriesCubit()..getAllCategories(),
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) return const LoadingProgress();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DefaultTextField(
                          hintText: AppStrings.challangeTitle
                              .translateString(context),
                          controller: challengeTitle,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.pleaseEnterChallangeTitle
                                  .translateString(context);
                            }
                            return null;
                          },
                        ),
                        DefaultTextField(
                          hintText: AppStrings.challangeDetails
                              .translateString(context),
                          controller: challangeDetails,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.pleaseEnterChallangeDetails
                                  .translateString(context);
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),
                        DefaultTextField(
                            // enabled: ,
                            hintText: AppStrings.chooseEndDate
                                .translateString(context),
                            action: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.pleaseChooseEndDate
                                    .translateString(context);
                              }
                              return null;
                            },
                            onTap: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                firstDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 10)),
                              );
                              if (selectedDate != null) {
                                selectedEndDate.text = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
                              }
                            },
                            controller: selectedEndDate),
                        defaultDropdownButton(
                          title: AppStrings.chooseCategory
                              .translateString(context),
                          validator: (String? value) {
                            if (value == null)
                              return AppStrings.thisFieldRequired
                                  .translateString(context);
                            return null;
                          },
                          onChanged: (value) {
                            selectedCategory = value;
                            CategoriesCubit.get(context).getCategoryHashtags(
                                categoryId: int.parse(value));
                            newHashtag.clear();
                          },
                          value: selectedCategory,
                          items: CategoriesCubit.get(context)
                              .categoriesModel
                              .categories
                              .categories
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(
                                    e.name,
                                  ),
                                  value: e.id,
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (state is HashTagsLoading)
                          const LoadingProgress()
                        else if (state is HashTagsSuccess)
                          CategoriesCubit.get(context)
                                  .hashTagModel
                                  .hashtags
                                  .isEmpty
                              ? Center(
                                  child: Text(
                                    AppStrings.noAvailableHashtags
                                        .translateString(context),
                                    style: getMediumStyle(),
                                  ),
                                )
                              : Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.selectoraddhashtags,
                                        style: getMediumStyle(),
                                      ),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      DefaultTextField(
                                        hintText: AppStrings.newHashtag
                                            .translateString(context),
                                        controller: newHashtag,
                                        suffix: defaultTextButton(
                                            onPressed: () {
                                              if (newHashtag.text.length >= 2) {
                                                if (CategoriesCubit.get(context)
                                                    .chekHashtagNotFound(
                                                        newHashtag.text)) {
                                                
                                                  int id = DateTime.now()
                                                      .millisecondsSinceEpoch;
                                                  CategoriesCubit.get(context)
                                                      .addNewHashtag(HashTag(
                                                          id: id,
                                                          name:
                                                              newHashtag.text));

                                                  CategoriesCubit.get(context)
                                                      .selectNewHashtag(
                                                          id.toString());
                                                  HelperMethods.closeKeyboard(
                                                      context);
                                                  newHashtag.clear();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: AppStrings
                                                          .hashTagexist,
                                                      fontSize: FontSize.s16);
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: AppStrings
                                                        .hashTagHasMeaning,
                                                    fontSize: FontSize.s16);
                                              }
                                            },
                                            text: AppStrings.add
                                                .translateString(context),
                                            borderColor: ColorManager.primary,
                                            buttonColor: ColorManager.white),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Text(
                                        AppStrings.hashTagsAvailable,
                                        style: getMediumStyle(),
                                      ),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Wrap(
                                        spacing: AppSize.s10,
                                        children: CategoriesCubit.get(context)
                                            .hashTagModel
                                            .hashtags
                                            .map(
                                              (e) => HashtagChip(
                                                  hashTagTitle: e.name,
                                                  selected: CategoriesCubit.get(
                                                          context)
                                                      .selectedHashtags
                                                      .contains(
                                                          e.id.toString()),
                                                  onPressed: () {
                                                    CategoriesCubit.get(context)
                                                        .selectNewHashtag(
                                                            e.id.toString());
                                                  }),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                )
                        else if (state is HashTagsError)
                          Center(
                            child: Text(
                              state.message,
                              style: getMediumStyle(),
                            ),
                          ),
                        SizedBox(
                          height: 10.h,
                        ),
                        BlocProvider(
                          create: (context) => HelperCubit(),
                          child: BlocBuilder<HelperCubit, HelperState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () async {
                                  final videoPicked =
                                      await PickerServices.pickVideo();
                                  if (videoPicked != null) {
                                    pickedVide = videoPicked;
                                    HelperCubit.get(context).rebuildPart();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffBECBFF),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 8.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          pickedVide == null
                                              ? AppStrings.uploadYourVideo
                                                  .translateString(context)
                                              : pickedVide!.path
                                                  .split('/')
                                                  .last,
                                          style: getBoldStyle(),
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                          ImageAssets.upload,
                                          width: 17.w,
                                          height: 17.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        BlocProvider(
                          create: (context) => CreateChallangeCubit(),
                          child: BlocConsumer<CreateChallangeCubit,
                              CreateChallangeState>(
                            listener: (context, state) {
                              if (state is CreateChallangeSuccess) {
                                Dialogs.postForReviewDialog(context);
                              } else if (state is CreateChallangeError) {
                                Fluttertoast.showToast(
                                    msg: state.error.translateString(context),
                                    backgroundColor: ColorManager.error);
                              }
                            },
                            builder: (context, state) {
                              return state is CreateChallangeLoading
                                  ? const LoadingProgress()
                                  : state is CreateChallangeProgressLoading
                                      ? VideoPreparingWidget(
                                          progress: state.progress,
                                        )
                                      : state is CreateChallangeUploadLoading
                                          ?  VideoUploadWidget()
                                          : DefaultButton(
                                              text: AppStrings.publish
                                                  .translateString(context),
                                              width: 200.w,
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if (pickedVide != null) {
                                                    if (CategoriesCubit.get(
                                                            context)
                                                        .selectedHashtags
                                                        .isNotEmpty) {
                                                      CreateChallangeCubit.get(
                                                              context)
                                                          .createChallange(
                                                        challangeTitle:
                                                            challengeTitle.text,
                                                        challangeDescription:
                                                            challangeDetails
                                                                .text,
                                                        categoryId: int.parse(
                                                            selectedCategory!),
                                                        endDate: selectedEndDate
                                                            .text,
                                                        videoFile: pickedVide,
                                                        newHashtagsData:CategoriesCubit.get(context).newHashtags,
                                                          
                                                        hashTag: CategoriesCubit
                                                                .get(context)
                                                            .selectedHashtags,
                                                      );
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg: AppStrings
                                                              .pleaseChooseAtLeastOneHashtag
                                                              .translateString(
                                                                  context),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 15.sp,
                                                          backgroundColor:
                                                              ColorManager
                                                                  .error);
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: AppStrings
                                                            .pleaseChooseVideo
                                                            .translateString(
                                                                context),
                                                        textColor: Colors.white,
                                                        fontSize: 15.sp,
                                                        backgroundColor:
                                                            ColorManager.error);
                                                  }
                                                }
                                              },
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              foregroundColor:
                                                  ColorManager.white,
                                              hasBorder: false,
                                              radius: 7.r,
                                            );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
