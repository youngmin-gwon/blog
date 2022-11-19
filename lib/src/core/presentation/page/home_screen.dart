import 'package:blog/src/core/presentation/extension/loc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          context.loc!.screenHomeTitle("Minsoo"),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/setting'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
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
