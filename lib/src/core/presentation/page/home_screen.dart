import 'package:blog/src/core/presentation/widget/custom_app_bar.dart';
import 'package:blog/src/core/presentation/widget/responsive.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobileView: HomeMobilePage(),
      tabletView: HomeTabletPage(),
      desktopView: HomeDesktopPage(),
    );
  }
}

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomToolBar(
            padding: EdgeInsets.all(12),
            iconSize: 30,
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTabletPage extends StatelessWidget {
  const HomeTabletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomToolBar(
            padding: EdgeInsets.all(20),
            iconSize: 40,
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDesktopPage extends StatelessWidget {
  const HomeDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: const Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
