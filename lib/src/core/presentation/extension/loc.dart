import 'package:flutter/material.dart' show BuildContext;
import 'package:blog/src/core/presentation/constants/l10n.dart';

extension BuildContextX on BuildContext {
  AppLocalizations? get loc => AppLocalizations.of(this);
}
