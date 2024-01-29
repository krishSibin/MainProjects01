import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app2/widgets/yellow_button.dart';

const textColor = [
  Colors.yellowAccent,
  Colors.orange,
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.yellowAccent,
  Colors.purple,
];
const textStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'Acme',
  fontSize: 42,
);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool progressing = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.repeat();
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/inapp/bgimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Welcome',
                    textStyle: textStyle,
                    colors: textColor,
                  ),
                  ColorizeAnimatedText(
                    'Duck Store',
                    textStyle: textStyle,
                    colors: textColor,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              const SizedBox(
                height: 120,
                width: 120,
                child: Image(
                  image: AssetImage('images/inapp/logo.jpg'),
                ),
              ),
              // const Text(
              //   'Shop',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 26,
              //   ),
              // ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme',
                    fontSize: 40,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText(
                        'Buy',
                      ),
                      RotateAnimatedText('Shop'),
                      RotateAnimatedText('Duck Store'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Text(
                            'Suppliers only',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.yellowAccent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedLogo(controller: _controller),
                            YellowButton(
                              label: 'Login',
                              width: 0.25,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/Supplier_home');
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: YellowButton(
                                label: 'Sign Up',
                                width: 0.25,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: YellowButton(
                            label: 'Log In',
                            width: 0.25,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/Customer_home');
                            },
                          ),
                        ),
                        YellowButton(
                          label: 'Sign Up',
                          width: 0.25,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/customer_signup');
                          },
                        ),
                        AnimatedLogo(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white38.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GoogleFacebookLogin(
                        onPressed: () {},
                        label: 'Google',
                        child: const Image(
                          image: AssetImage('images/inapp/google.jpg'),
                        ),
                      ),
                      GoogleFacebookLogin(
                        onPressed: () {},
                        label: 'Facebook',
                        child: const Image(
                          image: AssetImage('images/inapp/facebook.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: progressing
                            ? const CircularProgressIndicator()
                            : GoogleFacebookLogin(
                                onPressed: () async {
                                  setState(() {
                                    progressing = true;
                                  });
                                  await FirebaseAuth.instance
                                      .signInAnonymously();
                                  Navigator.pushReplacementNamed(
                                      context, '/Customer_home');
                                  print('login');
                                },
                                label: 'Guest',
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.blueAccent,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(image: AssetImage('images/inapp/logo.jpg')),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;

  const GoogleFacebookLogin(
      {super.key,
      required this.child,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: child,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
