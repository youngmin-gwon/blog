import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'background_painter.dart';


class FishcakeAuthScreen extends StatefulWidget {
  const FishcakeAuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FishcakeAuthScreenState();
}

class _FishcakeAuthScreenState extends State<FishcakeAuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller.view, // animation double
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<bool>(
                valueListenable: showSignInPage,
                builder: (context, value, child) {
                  // AnimatedSwitcher : Widget간의 transition 넣는 widget
                  return PageTransitionSwitcher(
                    reverse: !value,
                    duration: const Duration(milliseconds: 800),
                    transitionBuilder: (child, animation, secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                        fillColor: Colors.transparent,
                        child: child,
                      );
                    },
                    child: value
                        ? FishcakeSigninPage(
                            key: const ValueKey("SignIn"),
                            onLoggedIn: () {
                              showSignInPage.value = false;
                              _controller.forward();
                            },
                          )
                        : FishcakeMainMenuPage(
                            key: const ValueKey("Home"),
                            onLoggedOut: () {
                              showSignInPage.value = true;
                              _controller.reverse();
                            },
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FishcakeSigninPage extends StatefulWidget {
  final VoidCallback onLoggedIn;

  const FishcakeSigninPage({super.key, required this.onLoggedIn});

  @override
  State<FishcakeSigninPage> createState() => _FishcakeSigninPageState();
}

class _FishcakeSigninPageState extends State<FishcakeSigninPage> {
  // 각 텍스트필드의 값을 불러오는 controller
  late TextEditingController idTextEditingController;
  late TextEditingController passwordTextEditingController;

  // password FocusNode : id에서 submit 했을 때 pw로 focus 넘겨주기 위함
  late FocusNode pwFocusNode;

  // 로그인 form 검증할 때 form을 찾기 위한 key value
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Placeholder(
                child: SizedBox(
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: idTextEditingController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          hintText: "id",
                          fillColor: const Color(0xffeee6ca),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Color(0xffeee6ca)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xffeee6ca),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xffeee6ca),
                              )),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xffeee6ca),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return null;
                          }
                          return "유효하지 않은 아이디 입니다.";
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(pwFocusNode),
                      ),
                      const SizedBox(height: 7),
                      TextFormField(
                        obscureText: true,
                        controller: passwordTextEditingController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          hintText: "password",
                          fillColor: const Color(0xffeee6ca),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Color(0xffeee6ca)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xffeee6ca),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xffeee6ca),
                              )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xffeee6ca),
                              )),
                        ),
                        focusNode: pwFocusNode,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return null;
                          }
                          return "유효하지 않은 비밀번호 입니다.";
                        },
                        onFieldSubmitted: (val) {
                          widget.onLoggedIn.call();
                        },
                      ),
                      const SizedBox(height: 20),
                      SignInBar(
                        label: "Sign in",
                        onPressed: () {
                          widget.onLoggedIn.call();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    idTextEditingController.dispose();
    passwordTextEditingController.dispose();
    pwFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    idTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    pwFocusNode = FocusNode();

    super.initState();
  }
}

class FishcakeMainMenuPage extends StatelessWidget {
  final VoidCallback onLoggedOut;

  const FishcakeMainMenuPage({super.key, required this.onLoggedOut});

  static const menu = [
    Menu(
      title: "입고처리",
      icon: Icons.add_business_rounded,
      routeName: "/receive",
    ),
    Menu(
      title: "재고현황",
      icon: Icons.analytics_rounded,
      routeName: "/warehouse",
    ),
    Menu(
      title: "출입검사",
      icon: Icons.assignment_return_rounded,
      routeName: "/entrance",
    ),
    Menu(
      title: "공정검사",
      icon: Icons.assignment_late_rounded,
      routeName: "/process",
    ),
    Menu(
      title: "입고검사",
      icon: Icons.assignment_turned_in_rounded,
      routeName: "/stock",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white.withOpacity(0.75),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: const Text(
                        "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    onLoggedOut.call();
                  },
                )
              ],
            ),
          ),
          const Placeholder(
            child: SizedBox(
              width: 90,
              height: 90,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: menu
                    .map(
                      (item) => Hero(
                        tag: "menu${item.routeName}",
                        child: SingleChildScrollView(
                          child: Card(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => {},
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.transparent),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 15, bottom: 25),
                                          child: Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Icon(
                                            item.icon,
                                            size: 60,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SignInBar extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SignInBar({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xffadb36e),
                fontSize: 24),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
              ),
            ),
          ),
          RawMaterialButton(
            onPressed: onPressed,
            elevation: 0.0,
            fillColor: const Color(0xffadb36e),
            splashColor: const Color(0xffeee6ca),
            padding: const EdgeInsets.all(22.0),
            shape: const CircleBorder(),
            child: const Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}

class Menu {
  const Menu({
    required this.title,
    required this.icon,
    required this.routeName,
  });

  final String title;
  final IconData icon;
  final String routeName;
}
