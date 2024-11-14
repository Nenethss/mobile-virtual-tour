import 'package:flutter/material.dart';
import 'package:myflutter/pages/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Color _backgroundColor = const Color.fromARGB(255, 18, 165, 188);
  bool _showLogo = false;
  bool _showLoadingIndicator = false;
  bool _showSplashContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _backgroundColor = Colors.white;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showLogo = true;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showLogo = false;
      });
    });

    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        _showLoadingIndicator = true;
      });
    });

    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        _showLoadingIndicator = false;
      });
    });

    Future.delayed(const Duration(seconds: 11), () {
      setState(() {
        _showSplashContent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        color: _backgroundColor,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: _showLogo ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/logo.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
              AnimatedOpacity(
                opacity: _showLoadingIndicator ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: const CircularProgressIndicator(),
              ),
              AnimatedOpacity(
                opacity: _showSplashContent ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: _showSplashContent
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/logo.jpg',
                            width: 150,
                            height: 150,
                          ),
                          Image.asset(
                            'assets/amico.png',
                            width: 350,
                            height: 350,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Meet Giga, Your Virtual Tour Guide',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Giga, our friendly mascot, is here to help you \n'
                              'navigate  the app and answer  any questions \n'
                              'you have. Look for Giga to guide you through \n'
                              '            features, tips, and assistance!',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 18, 165, 188),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 115, vertical: 15),
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
