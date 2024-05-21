// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawah_app/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> signup() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'phone': phoneController.text.trim(),
          });
        }

        Navigator.of(context).pushNamed('login');
      } catch (e) {
        // Handle error
        print(e);
      }
    }
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  late Color myColor;
  late Size mediaSize;
  bool rememberUser = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: AssetImage("assets/images/backk.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          style: TextStyle(
              color: myColor, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        _buildGreyText("Please enter your information"),
        SizedBox(height: 30),
        _buildGreyText("Name"),
        _buildInputField(nameController),
        SizedBox(height: 20),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        SizedBox(height: 20),
        _buildGreyText("Phone Number"),
        _buildInputField(phoneController, isPhoneNumber: true),
        SizedBox(height: 20),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        SizedBox(height: 20),
        _buildGreyText("Confirm Password"),
        _buildInputField(confirmPasswordController, isPassword: true),
        SizedBox(height: 20),
        _buildRememberForgot(),
        SizedBox(height: 20),
        _buildSignupButton(),
        SizedBox(height: 20),
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

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false, bool isPhoneNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
      ),
      obscureText: isPassword,
      keyboardType: isPhoneNumber ? TextInputType.phone : TextInputType.text,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: _buildGreyText("Already have an account?"))
          ],
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: signup,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Signup"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Signup with"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/facebook.png")),
              Tab(icon: Image.asset("assets/images/google.png")),
              Tab(icon: Image.asset("assets/images/twitter.png")),
            ],
          )
        ],
      ),
    );
  }
}
