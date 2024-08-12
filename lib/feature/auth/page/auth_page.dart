import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/common/services/auth_google.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final user = await AuthUser.loginGoogle();
      if (user != null) {
        _returnToPreviousScreen(context);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? S.of(context).snackbar_error_message,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  void _enterAsGuest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGuest', true);
    _returnToPreviousScreen(context);
  }

  void _returnToPreviousScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (routes) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          Positioned(
            left: -50,
            bottom: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 380,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            _buildButton(
                              S.of(context).continue_as_guest_button,
                              Colors.deepPurpleAccent,
                              Colors.white,
                              () {
                                _enterAsGuest(context);
                              },
                              'assets/icons/user.svg',
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            _buildButton(
                              S.of(context).log_in_with_google_button,
                              Colors.white,
                              Colors.black,
                              () {
                                _signInWithGoogle(context);
                              },
                              'assets/icons/google.svg',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor,
      VoidCallback onPressed, String icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
