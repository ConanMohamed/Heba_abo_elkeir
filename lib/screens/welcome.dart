import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(248, 116, 0, 1),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(248, 119, 0, 1),
                ),
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Welcome",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "To Food Recipes",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: const Text(
                        "Providing the finest cooking recipes",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: const Text(
                        "around the world",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'lib/assets/otherAssets/b.jpg',
                            fit: BoxFit.fill,
                            height: 130,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Image.asset(
                            'lib/assets/otherAssets/j.jpg',
                            fit: BoxFit.fill,
                            height: 130,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'lib/assets/otherAssets/d.jpg',
                              fit: BoxFit.fill,
                              height: 120,
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Image.asset(
                              'lib/assets/otherAssets/c.jpg',
                              fit: BoxFit.fill,
                              height: 120,
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Image.asset(
                              'lib/assets/otherAssets/a.jpeg',
                              fit: BoxFit.fill,
                              height: 120,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'lib/assets/otherAssets/e.jpg',
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Image.asset(
                            'lib/assets/otherAssets/f.jpg',
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Image.asset(
                            'lib/assets/otherAssets/h.jpg',
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(129, 80, 112, 187),
                      Color.fromARGB(255, 0, 72, 131),
                      Color.fromARGB(255, 0, 72, 131),
                    ],
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(left: 10),
                child: TextButton(
                  onPressed: () async {
                    final pref = await SharedPreferences.getInstance();
                    pref.setBool('onboarding', true);
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
