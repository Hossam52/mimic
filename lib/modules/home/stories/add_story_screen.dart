import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/draft/videlo_upload_loading.dart';
import 'package:mimic/modules/draft/video_preparing_widget.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialog_widgets/cancel_upload_dialog.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/services/pickers_services.dart';

class AddStoryScreen extends StatelessWidget {
  AddStoryScreen({Key? key}) : super(key: key);
  File? videoPicked;
  @override
  Widget build(BuildContext context) {
    BuildContext contextCubit =
        ModalRoute.of(context)!.settings.arguments as BuildContext;
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
                        title: AppStrings.areYouSureToCancelUploadingThisStory
                            .translateString(context)));
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorManager.primary,
          ),
          child: SafeArea(
            child: BlocProvider.value(
              value: ManageStoriesCubit.get(contextCubit),
              child: BlocConsumer<ManageStoriesCubit, ManageStoriesState>(
                listener: (context, state) {
                  if (state is ManageStoriesSucceessUploading) {
                    Navigator.pop(
                      context,
                    );
                    Fluttertoast.showToast(
                      msg: AppStrings.storyAddedSuccessfully,
                      backgroundColor: ColorManager.white,
                      fontSize: FontSize.s14,
                      textColor: ColorManager.black,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ManageStoriesPrepareLoading) {
                    return SizedBox(
                      height: 1.sh,
                      child: VideoPreparingWidget(
                        progress: state.number,
                        color: ColorManager.white,
                      ),
                    );
                  } else if (state is ManageStoriesSucceessUploading &&
                      videoPicked != null) {
                    return Center(
                        child: SizedBox(
                            height: 1.sh,
                            child: const Text('Story Uploaded Success')));
                  } else if (state is ManageStoriesErrorUploading) {
                    return SizedBox(
                      height: 1.sh,
                      child: BuildErrorWidget(state.error),
                    );
                  } else if (state is ManageStoriesLoadingUploading) {
                    return VideoUploadWidget(
                      color: ColorManager.white,
                    );
                  } else if (state is ManageStoriesLoadingProgressUploading) {
                    return SizedBox(
                      height: 1.sh,
                      child: VideoPreparingWidget(
                        progress:
                            double.parse(state.progress.toStringAsFixed(1)),
                        color: ColorManager.white,
                        uploadTime: true,
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        videoPicked = await PickerServices.pickVideo();
                        if (videoPicked != null) {
                          ManageStoriesCubit.get(context)
                              .createStory(videoFile: videoPicked);
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
                  }
                },
              ),
            ),
          ),
        ));
  }
}
