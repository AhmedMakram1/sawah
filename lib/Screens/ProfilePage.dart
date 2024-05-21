import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sawah_app/Screens/FeedbackPage%20.dart';
import 'package:sawah_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sawah_app/login_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ProfilePageState extends State<ProfileScreen> {
  String? userName = ''; // State variable to hold user's name
  String? userEmail = ''; // State variable to hold user's email
  File? _profileImage; // State variable to hold profile image

  @override
  void initState() {
    super.initState();
    getUserData(); // Call a method to fetch user's data when the screen loads
  }

  Future<void> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Fetch user data from Firebase Auth
      userName = user.displayName;
      userEmail = user.email;

      // If displayName is null, fetch the name from Firestore
      if (userName == null || userName!.isEmpty) {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (docSnapshot.exists) {
          setState(() {
            userName = docSnapshot.data()?['name'];
          });
        }
      }

      setState(() {
        userEmail = user.email;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: kAppPrimaryColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                AvatarImage(
                  image: _profileImage,
                  onImageTap: _pickImage,
                ),
                SizedBox(height: 30),
                SocialIcons(),
                SizedBox(height: 30),
                Text(
                  userName ?? '', // Display user's name
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  userEmail ?? '', // Display user's email
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                ProfileListItems(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;

  const AppBarButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  final File? image;
  final VoidCallback onImageTap;

  const AvatarImage({required this.image, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageTap,
      child: CircleAvatar(
        radius: 75,
        backgroundImage: image != null
            ? FileImage(image!)
            : AssetImage('assets/images/user.png') as ImageProvider,
        child: Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(
              Icons.camera_alt,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          color: Color(0xFF102397),
          iconData: facebook,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFFff4f38),
          iconData: googlePlus,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFF38A1F3),
          iconData: twitter,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFF2867B2),
          iconData: linkedin,
          onPressed: () {},
        ),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final VoidCallback onPressed;

  SocialIcon({
    required this.color,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            text: 'Privacy',
            onPressed: () {},
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.question_circle,
            text: 'Help & Support',
            onPressed: () {},
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.cog,
            text: 'Settings',
            onPressed: () {},
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.alternate_sign_out,
            text: 'Logout',
            onPressed: () async {
              await _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ProfileListItem(
            icon: Icons.rate_review,
            text: 'Rate Us',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final VoidCallback onPressed;

  ProfileListItem({
    required this.icon,
    required this.text,
    this.hasNavigation = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: hasNavigation ? onPressed : null,
    );
  }
}
