import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sawah_app/Screens/HomeScreen.dart';
import 'package:sawah_app/Screens/NavBar.dart';
import 'package:sawah_app/regester.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyNevBar()),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Successfully'),
            content: const Text('Logged in'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found
      } else if (e.code == 'wrong-password') {
        // Handle wrong password
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      // Handle error
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyNevBar()),
        );
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late Color myColor;
  late Size mediaSize;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/backk.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 60, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "SAWAH",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 80,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome",
          style: TextStyle(color: myColor, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 60),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildInputField(TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
            child: _buildGreyText("Don't have an account")),
        TextButton(onPressed: () {}, child: _buildGreyText("I forgot my password")),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: login,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: signInWithGoogle,
                child: Tab(icon: Image.asset("assets/images/google.png")),
              ),
              GestureDetector(
                onTap: signInWithFacebook,
                child: Tab(icon: Image.asset("assets/images/facebook.png")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
