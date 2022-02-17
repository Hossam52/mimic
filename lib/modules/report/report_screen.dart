import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/dialog_card.dart';

Widget _headerText(String text) {
  return Text(text, style: getBoldStyle(fontSize: FontSize.s17));
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      height: screenHeight(context) * 0.78,
      headerTitle: 'Report',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'If you have any problem, Please let us know about',
                textAlign: TextAlign.center,
                style: getRegularStyle(fontSize: FontSize.s18),
              ),
              const SizedBox(height: 30),
              const _ViolationTypeButton(),
              const SizedBox(height: 30),
              const _ProblemDescription(),
              const SizedBox(height: 30),
              Center(
                child: DefaultButton(
                  text: 'Submit',
                  onPressed: () {},
                  backgroundColor: Theme.of(context).primaryColor,
                  hasBorder: false,
                  foregroundColor: ColorManager.white,
                  radius: 15,
                  width: screenWidth(context) * 0.37,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportSection extends StatelessWidget {
  const _ReportSection(
      {Key? key, required this.headerTitle, required this.child})
      : super(key: key);
  final String headerTitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerText(headerTitle),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _ViolationTypeButton extends StatefulWidget {
  const _ViolationTypeButton({Key? key}) : super(key: key);

  @override
  State<_ViolationTypeButton> createState() => _ViolationTypeButtonState();
}

class _ViolationTypeButtonState extends State<_ViolationTypeButton> {
  String selectedVal = '1';
  @override
  Widget build(BuildContext context) {
    return _ReportSection(
      headerTitle: 'Type of violation',
      child: SizedBox(
        width: double.infinity,
        child: InputDecorator(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: selectedVal,
                items: [
                  DropdownMenuItem(
                    value: '1',
                    child: Text(
                      'Violation type 1',
                      style: getSemiBoldStyle(fontSize: FontSize.s16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text(
                      'Violation type 2',
                      style: getSemiBoldStyle(fontSize: FontSize.s16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text(
                      'Violation type 3',
                      style: getSemiBoldStyle(fontSize: FontSize.s16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: '4',
                    child: Text(
                      'Violation type 4',
                      style: getSemiBoldStyle(fontSize: FontSize.s16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: '5',
                    child: Text(
                      'Violation type 5',
                      style: getSemiBoldStyle(fontSize: FontSize.s16),
                    ),
                  ),
                ],
                onChanged: (String? val) {
                  setState(() {
                    selectedVal = val!;
                  });
                }),
          ),
        ),
      ),
    );
  }
}

class _ProblemDescription extends StatelessWidget {
  const _ProblemDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReportSection(
      headerTitle: 'Describe your report',
      child: TextField(
        controller: TextEditingController(),
        maxLines: 5,
        style:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s16),
        decoration: InputDecoration(
          hintText: 'Write description here ',
          contentPadding: const EdgeInsets.all(18),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey),
          ),
        ),
      ),
    );
  }
}
