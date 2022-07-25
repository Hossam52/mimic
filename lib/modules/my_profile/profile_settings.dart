import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/modules/my_profile/profile_cubit/profile_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/countries_cubit/countries_cubit_cubit.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/services/pickers_services.dart';
import 'package:mimic/widgets/build_text_error.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/default_dropdown_button.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final emailController = TextEditingController(text: ValuesManager.email);
  final usernameController =
      TextEditingController(text: ValuesManager.username);

  final birthDateController = TextEditingController(
      text: CacheHelper.getDate(key: ValuesManager.birthKey));

  final formKey = GlobalKey<FormState>();
  File? image;
  @override
  Widget build(BuildContext context) {
    // log(ProfileCubit.get(wit).state.toString());
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Account settings'),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: SvgPicture.asset('assets/images/logos/logo_vertical.svg',
                width: double.infinity, height: 245.h),
          ),
          SingleChildScrollView(
              child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HelperCubit(),
              ),
              BlocProvider(
                create: (context) => CountriesCubit()..getAllCountries(),
              ),
            ],
            child: Center(
              child: BlocBuilder<HelperCubit, HelperState>(
                builder: (context, state) {
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () async {
                              image = await PickerServices.pickImage();
                              if (image != null) {
                                HelperCubit.get(context).rebuildPart();
                                //rebuild
                              }
                            },
                            child: _ProfileImage(
                              image: image,
                            )),
                        SizedBox(height: 10.h),
                        Text(
                          ValuesManager.username,
                          style: getBoldStyle(),
                        ),
                        SizedBox(height: 5.h),
                        // if(CacheHelper.getDate(key: ValuesManager.countryKey)!=null)
                        // Text(
                        //   '${CacheHelper.getDate(key: ValuesManager.countryKey)}, ${}',
                        //   style: getRegularStyle(
                        //       color: ColorManager.commentsColor),
                        // ),
                        SizedBox(height: 40.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.h),
                          child: Column(
                            children: [
                              _AccountSettings(
                                  email: emailController,
                                  username: usernameController),
                              SizedBox(height: 30.h),
                              BlocBuilder<CountriesCubit, CountriesCubitState>(
                                builder: (context, state) {
                                  if (state is CountriesCubitLoading) {
                                    return const LoadingProgress();
                                  } else if (state is CountriesCubitError) {
                                    return buildTextError(state.error);
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Personal Data',
                                          style: getSemiBoldStyle()),
                                      SizedBox(height: AppSize.s10),
                                      GestureDetector(
                                        onTap: () async {
                                          final date = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime(1940),
                                              firstDate: DateTime(1940),
                                              lastDate: DateTime(
                                                  DateTime.now().year - 10));
                                          if (date != null) {
                                            birthDateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            log(birthDateController.text);
                                          }
                                        },
                                        child: DefaultTextField(
                                            hintText: '',
                                            labelText: 'Birth date',
                                            controller: birthDateController,
                                            marginAfterEnd: AppSize.s10,
                                            prefix: const PrefixIconImage(
                                              svgImagePath:
                                                  'assets/images/edit_profile_icons/birthday.svg',
                                            ),
                                            enabled: false,
                                            suffix: _icon(),
                                            iconColor:
                                                Theme.of(context).primaryColor),
                                      ),
                                      defaultDropdownButtonWithIcon(
                                        title: 'Country',
                                        value: CountriesCubit.get(context)
                                            .selctedCountry,
                                        imagePath:
                                            'assets/images/edit_profile_icons/country.svg',
                                        onChanged: (value) {
                                          CountriesCubit.get(context)
                                              .selectedCity = null;
                                          CountriesCubit.get(context)
                                              .getCities(value);

                                          HelperMethods.closeKeyboard(context);
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return AppStrings.thisFieldRequired;
                                          }
                                          return null;
                                        },
                                        items: CountriesCubit.get(context)
                                            .countriesRepository
                                            .countries
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e.name,
                                                    style: getMediumStyle(),
                                                  ),
                                                  value: e.name,
                                                ))
                                            .toList(),
                                      ),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      defaultDropdownButtonWithIcon(
                                          title: 'City',
                                          value: CountriesCubit.get(context)
                                              .selectedCity,
                                          imagePath:
                                              'assets/images/edit_profile_icons/city.svg',
                                          onChanged: (value) {
                                            CountriesCubit.get(context)
                                                .selectedCity = value;
                                            HelperMethods.closeKeyboard(
                                                context);
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return AppStrings
                                                  .thisFieldRequired;
                                            }
                                            return null;
                                          },
                                          items: CountriesCubit.get(context)
                                                  .cities
                                                  .isEmpty
                                              ? []
                                              : CountriesCubit.get(context)
                                                  .cities
                                                  .values
                                                  .toList()
                                                  .first
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(
                                                          e.name,
                                                          style:
                                                              getMediumStyle(),
                                                        ),
                                                        value:
                                                            e.name.toString(),
                                                      ))
                                                  .toList()),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 30.h),
                              BlocConsumer<ProfileCubit, ProfileState>(
                                listener: (context, state) {
                                  if (state is ProfileEditSuccess) {
                                    CacheHelper.saveDate(
                                        key: ValuesManager.countryKey,
                                        value: CountriesCubit.get(context)
                                            .selctedCountry);
                                    CacheHelper.saveDate(
                                        key: ValuesManager.birthKey,
                                        value: birthDateController.text);
                                    CacheHelper.saveDate(
                                        key: ValuesManager.cityKey,
                                        value: CountriesCubit.get(context)
                                            .selectedCity);

                                    Fluttertoast.showToast(
                                        msg: AppStrings.profileEdited,
                                        fontSize: FontSize.s16);
                                    Navigator.pop(context);
                                  } else if (state is ProfileEditError) {
                                    Fluttertoast.showToast(
                                        msg: state.error,
                                        backgroundColor: ColorManager.error);
                                  }
                                },
                                builder: (context, state) {
                                  return DefaultButton(
                                    text: AppStrings.saveChanges.translateString(context),
                                    loading: state is ProfileEditLoading,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ProfileCubit.get(context).editProfile(
                                          birthData: birthDateController.text,
                                          cityId: CountriesCubit.get(context)
                                              .getCityId(),
                                          countryId: CountriesCubit.get(context)
                                              .selectedCountryId!,
                                          username: ValuesManager.username,
                                          email: emailController.text.isNotEmpty
                                              ? emailController.text
                                              : ValuesManager.email,
                                          imageFile: image,
                                        );
                                      }
                                    },
                                    width: double.infinity,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor: ColorManager.white,
                                    hasBorder: false,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    radius: 24.r,
                                  );
                                },
                              ),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
        ],
      ),
    );
  }
}

Widget _icon() {
  return Icon(
    Icons.keyboard_arrow_right,
    size: 25.r,
    color: ColorManager.black,
  );
}

class _ProfileImage extends StatelessWidget {
  _ProfileImage({Key? key, this.image}) : super(key: key);
  File? image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.w,
      width: 80.w,
      child: Stack(
        children: [
          image == null
              ? cachedNetworkImageProvider(ValuesManager.imageUrl, 80.r)
              : CircleAvatar(radius: 80.r, backgroundImage: FileImage(image!)),
          //cachedNetworkImage(imageUrl: imageUrl, height: height, width: width)
          // RoundedImage(
          //     imagePath: 'assets/images/static/avatar.png', size: 85.w),
          Align(
            alignment: Alignment.bottomRight,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r)),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: SvgPicture.asset(
                    'assets/images/edit_profile_icons/edit.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrefixIconImage extends StatelessWidget {
  const PrefixIconImage({Key? key, required this.svgImagePath, this.size = 15})
      : super(key: key);
  final String svgImagePath;
  final double size;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: size.w,
        height: size.w,
        child: FittedBox(
          child: SvgPicture.asset(
            svgImagePath,
          ),
        ),
      ),
    );
  }
}

class _AccountSettings extends StatelessWidget {
  const _AccountSettings(
      {Key? key, required this.email, required this.username})
      : super(key: key);
  final TextEditingController email;
  final TextEditingController username;

  @override
  Widget build(BuildContext context) {
    double spaceAfterEnd = 15.h;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account', style: getBoldStyle(fontSize: FontSize.s14)),
        SizedBox(height: spaceAfterEnd),
        DefaultTextField(
            hintText: ValuesManager.email,
            controller: email,
            marginAfterEnd: spaceAfterEnd,
            prefix: const PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/email.svg'),
            labelText: 'Email',
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: ValuesManager.username,
            labelText: 'User Name',
            controller: username,
            marginAfterEnd: spaceAfterEnd,
            prefix: const PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/user_name.svg'),
            iconColor: Theme.of(context).primaryColor),
        GestureDetector(
          onTap: () {
            navigateTo(context, Routes.profileChangePassword);
          },
          child: DefaultTextField(
              hintText: '',
              labelText: 'Change Password',
              controller: TextEditingController(),
              marginAfterEnd: spaceAfterEnd,
              prefix: const PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/password.svg',
                size: 25,
              ),
              enabled: false,
              suffix: _icon(),
              iconColor: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}

class _PersonalData extends StatelessWidget {
  const _PersonalData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double spaceAfterEnd = 15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Data', style: getSemiBoldStyle()),
        const SizedBox(height: spaceAfterEnd),
        DefaultTextField(
            hintText: '',
            labelText: 'Birth date',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/birthday.svg'),
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: '',
            labelText: 'Country',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/country.svg'),
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: '',
            labelText: 'City',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/city.svg'),
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
      ],
    );
  }
}
