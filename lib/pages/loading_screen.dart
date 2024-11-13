import 'package:flutter/material.dart';
import 'package:myflutter/pages/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Color _backgroundColor =
      const Color.fromARGB(255, 18, 165, 188); // Initial blue background
  bool _showLogo = false;
  bool _showLoadingIndicator = false;
  bool _showSplashContent = false;

  @override
  void initState() {
    super.initState();

    // Step 1: Transition background color from blue to white
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _backgroundColor = Colors.white; // Transition to white background
      });
    });

    // Step 2: Fade in the logo after 3 seconds (background turns white)
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showLogo = true;
      });
    });

    // Step 3: Fade out the logo after 3 seconds (logo fades out)
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showLogo = false;
      });
    });

    // Step 4: Fade in the loading indicator after 3 seconds (logo fades out)
    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        _showLoadingIndicator = true;
      });
    });

    // Step 5: Fade out the loading indicator after 3 seconds (loading fades out)
    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        _showLoadingIndicator = false;
      });
    });

    // Step 6: Fade in the splash content after 3 seconds (loading fades out)
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
        duration:
            const Duration(seconds: 2), // Background color transition duration
        color: _backgroundColor,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo that fades in and fades out in 3 seconds
              AnimatedOpacity(
                opacity: _showLogo ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/logo.jpg', // Replace with your logo path
                  width: 200,
                  height: 200,
                ),
              ),
              // CircularProgressIndicator that fades in and fades out in 3 seconds
              AnimatedOpacity(
                opacity: _showLoadingIndicator ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: const CircularProgressIndicator(),
              ),
              // Final splash content that fades in for 3 seconds
              AnimatedOpacity(
                opacity: _showSplashContent ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: _showSplashContent
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/logo.jpg', // Replace with your logo or another image
                            width: 150,
                            height: 150,
                          ),
                          Image.asset(
                            'assets/amico.png', // Replace with your logo or another image
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
                          const SizedBox(
                              height: 50), // Add space before the button
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
                                borderRadius: BorderRadius.circular(
                                    10), // Set the border radius
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 115,
                                  vertical: 15), // Adjust padding as needed
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
