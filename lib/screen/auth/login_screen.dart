import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/screen/main/main_dashboard.dart';
import 'package:jilani_admin/utils/color.dart';
import 'package:jilani_admin/widgets/save_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;

    @override
    void initState() {
      super.initState();
      passwordVisible = true;
    }

    // Toggles the password show status
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Image.asset(
                "assets/logo.png",
                height: 180,
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 9),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 8, top: 15),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: mainColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  fillColor: textColor,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.email,
                    ),
                    onPressed: () {},
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 9),
              TextFormField(
                controller: passController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 8, top: 15),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: mainColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  fillColor: textColor,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              SaveButton(
                title: "Log in",
                onTap: () async {
                  try {
                    // Authenticate the user
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text,
                    );

                    // Get the authenticated user's email
                    String email = userCredential.user?.email ?? '';

                    // Check if this email exists in the Firestore 'admin' collection
                    DocumentSnapshot adminSnapshot = await FirebaseFirestore
                        .instance
                        .collection('admin')
                        .doc(email)
                        .get();

                    if (adminSnapshot.exists) {
                      // Email exists in the 'admin' collection
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MainDashboard()),
                      );
                    } else {
                      // Email not found in 'admin' collection
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Access denied. Admin only.'),
                        ),
                      );
                    }
                  } catch (e) {
                    // Handle errors (e.g., wrong password, user not found)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
