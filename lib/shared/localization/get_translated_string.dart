import 'package:flutter/material.dart';

import 'mimic_localiaze.dart';

String? getTranslated(BuildContext context, String key) 
{
  return MimicLocalizations.of(context)!.getTranslatedValue(key);
}
