import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/challenges/add_video_to_challange/cubit/add_video_to_challange_cubit.dart';
import 'package:mimic/modules/draft/videlo_upload_loading.dart';
import 'package:mimic/modules/draft/video_preparing_widget.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialog_widgets/cancel_upload_dialog.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/services/pickers_services.dart';

class AddVideoToChallangeScreen extends StatelessWidget {
  AddVideoToChallangeScreen({Key? key}) : super(key: key);
  File? videoPicked;
  @override
  Widget build(BuildContext context) {
    String challangeId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: ColorManager.white,
            onPressed: () async {
              if (videoPicked != null) {
                showDialog(
                    context: context,
                    builder: (context) => CancelUploading(
                        title: AppStrings
                            .areYouSureToCancelUploadingInThisChallenge
                            .translateString(context)));
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: BlocProvider(
          create: (context) => ManageVideosChallangersCubit(),
          child: Container(
            height: 1.sh,
            width: 1.sw,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorManager.primary,
            ),
            child: SafeArea(
              child: BlocConsumer<ManageVideosChallangersCubit,
                  AddVideoToChallangeState>(
                listener: (context, state) {
                  if (state is AddVideoToChallangeSuccess) {
                    Navigator.pop(context, true);
                    Fluttertoast.showToast(
                      msg: AppStrings.videoAddedToChallangeSuccessfully,
                      backgroundColor: ColorManager.white,
                      fontSize: FontSize.s14,
                      textColor: ColorManager.black,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AddVideoToChallangeInitial) {
                    return InkWell(
                      onTap: () async {
                        videoPicked = await PickerServices.pickVideo();
                        if (videoPicked != null) {
                          ManageVideosChallangersCubit.get(context).createStory(
                              videoFile: videoPicked,
                              challangeId: int.parse(challangeId));
                        } else {
                          Fluttertoast.showToast(
                              msg: AppStrings.videoDoesntPicked
                                  .translateString(context),
                              backgroundColor: ColorManager.error);
                        }
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: AppSize.largeIconSize + 15.r,
                              color: ColorManager.white,
                            ),
                            SizedBox(
                              height: AppSize.s20.h,
                            ),
                            Text(
                              AppStrings.uploadYourOwnVideo
                                  .translateString(context),
                              style: getRegularStyle(
                                fontSize: FontSize.s25,
                                color: ColorManager.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is AddVideoToChallangePrepareing) {
                    return SizedBox(
                      height: 1.sh,
                      child: VideoPreparingWidget(
                        progress: state.progress,
                        color: ColorManager.white,
                      ),
                    );
                  } else if (state is AddVideoToChallangeUploadPreparing) {
                    return SizedBox(
                      height: 1.sh,
                      child: VideoPreparingWidget(
                        progress: state.progress,
                        color: ColorManager.white,
                        uploadTime: true,
                      ),
                    );
                  } else if (state is AddVideoToChallangeSuccess) {
                    return Center(
                        child: SizedBox(
                            height: 1.sh,
                            child: const Text('Video Uploaded Success')));
                  } else if (state is AddVideoToChallangeError) {
                    return SizedBox(
                        height: 1.sh, child: BuildErrorWidget(state.error));
                  } else {
                    return VideoUploadWidget(
                      color: ColorManager.white,
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }
}
