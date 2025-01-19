import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/utils/color.dart';
import 'package:jilani_admin/widgets/save_button.dart';

class ProfileDetail extends StatefulWidget {
  String status;
  String cast;
  String sect;
  String aboutYourself;
  String qualification;
  String motherName;
  String fatherName;
  String contactNumber;
  String fullName;
  String uid;
  String dob;
  String gender;
  String image;
  ProfileDetail({
    super.key,
    required this.aboutYourself,
    required this.cast,
    required this.contactNumber,
    required this.dob,
    required this.fatherName,
    required this.fullName,
    required this.gender,
    required this.image,
    required this.motherName,
    required this.qualification,
    required this.sect,
    required this.status,
    required this.uid,
  });

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name OF THE USER",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.fullName,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.contactNumber,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Father Name",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.fatherName,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mother Name",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.motherName,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cast",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.cast,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date of Birth",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.dob,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sect",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.sect,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Profile Description",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.aboutYourself,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.status == 'pending') ...[
                    // Show both Accept and Decline buttons if status is "pending"
                    SizedBox(
                      width: 150,
                      child: SaveButton(
                        title: "Accept",
                        onTap: _acceptStatus,
                      ),
                    ),
                    TextButton(
                      onPressed: _declineStatus,
                      child: Text(
                        "Declined",
                        style: TextStyle(color: red),
                      ),
                    ),
                  ] else if (widget.status == 'accepted') ...[
                    // If status is "accepted", show only Decline button
                    TextButton(
                      onPressed: _declineStatus,
                      child: Text(
                        "Declined",
                        style: TextStyle(color: red),
                      ),
                    ),
                  ] else if (widget.status == 'declined') ...[
                    // If status is "declined", show only Accept button
                    SizedBox(
                      width: 150,
                      child: SaveButton(
                        title: "Accept",
                        onTap: _acceptStatus,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ]),
        ));
  }

  void _acceptStatus() async {
    try {
      await FirebaseFirestore.instance
          .collection('users') // Replace with your Firebase collection name
          .doc(widget.uid) // Using the user's UID to reference their document
          .update({'status': 'accepted'});

      setState(() {
        widget.status = 'accepted'; // Update the status locally
      });
    } catch (e) {
      print("Error updating status to accepted: $e");
    }
  }

  // Firebase update function for declining the status
  void _declineStatus() async {
    try {
      await FirebaseFirestore.instance
          .collection('users') // Replace with your Firebase collection name
          .doc(widget.uid) // Using the user's UID to reference their document
          .update({'status': 'declined'});

      setState(() {
        widget.status = 'declined'; // Update the status locally
      });
    } catch (e) {
      print("Error updating status to declined: $e");
    }
  }
}
