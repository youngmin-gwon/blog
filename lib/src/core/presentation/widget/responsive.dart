import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobileView,
    required this.tabletView,
    required this.desktopView,
  });

  final Widget mobileView;
  final Widget tabletView;
  final Widget desktopView;

  Widget _buildWidgetByScreenWidth(
      BuildContext context, BoxConstraints constraints) {
    if (MediaQuery.of(context).size.width >= 915) {
      return desktopView;
    } else if (MediaQuery.of(context).size.width >= 650) {
      return tabletView;
    } else {
      return mobileView;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: _buildWidgetByScreenWidth,
    );
  }
}
