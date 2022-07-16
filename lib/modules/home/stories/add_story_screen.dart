import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/draft/videlo_upload_loading.dart';
import 'package:mimic/modules/draft/video_preparing_widget.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/services/pickers_services.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class AddStoryScreen extends StatelessWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorManager.primary,
          ),
          child: SafeArea(
            child: BlocProvider(
              create: (context) => ManageStoriesCubit(),
              child: BlocConsumer<ManageStoriesCubit, ManageStoriesState>(
                listener: (context, state) {
                  if (state is ManageStoriesSucceessUploading) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: AppStrings.storyAddedSuccessfully,
                      backgroundColor: ColorManager.white,
                      fontSize: FontSize.s14,
                      textColor: ColorManager.black,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ManageStoriesInitial) {
                    return InkWell(
                      onTap: () async {
                        final videoPicked = await PickerServices.pickVideo();
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
                  } else if (state is ManageStoriesPrepareLoading) {
                    return SizedBox(
                      height: 1.sh,
                      child: VideoPreparingWidget(
                        progress: state.number,
                        color: ColorManager.white,
                      ),
                    );
                  } else if (state is ManageStoriesSucceessUploading) {
                    return Center(
                        child: SizedBox(
                            height: 1.sh,
                            child: const Text('Story Uploaded Success')));
                  } else if (state is ManageStoriesErrorUploading) {
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
