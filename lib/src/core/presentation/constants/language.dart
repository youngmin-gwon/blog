import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:flutter/material.dart';

class LanguageChange extends Notification {
  final Language language;

  const LanguageChange({required this.language});
}
