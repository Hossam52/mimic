import 'package:flutter/cupertino.dart';
import 'package:mimic/shared/localization/mimic_localiaze.dart';

extension Translatation on String 
{
  String translateString(BuildContext context) =>
      MimicLocalizations.of(context)!.getTranslatedValue(this)??this;
}
