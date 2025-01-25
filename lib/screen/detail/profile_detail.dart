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
  String idCard;

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
    required this.idCard,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _showImageDialog(widget.image); // Enlarge profile picture
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ),
            _buildInfoSection("Name of the User", widget.fullName),
            _buildInfoSection("Phone", widget.contactNumber),
            _buildInfoSection("Father Name", widget.fatherName),
            _buildInfoSection("Mother Name", widget.motherName),
            _buildInfoSection("Cast", widget.cast),
            _buildInfoSection("Date of Birth", widget.dob),
            _buildInfoSection("Sect", widget.sect),
            _buildInfoSection("User Profile Description", widget.aboutYourself),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID Card",
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showImageDialog(widget.idCard); // Enlarge ID card
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: mainColor,
                        backgroundImage: NetworkImage(widget.idCard),
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }

  // Method to build information sections
  Widget _buildInfoSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Method to show the enlarged image
  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the dialog when tapped
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.broken_image, size: 100, color: Colors.grey),
                        Text(
                          "Unable to load image",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Firebase update function for accepting the status
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
