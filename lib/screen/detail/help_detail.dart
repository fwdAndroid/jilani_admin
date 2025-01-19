import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/utils/color.dart';
import 'package:jilani_admin/widgets/save_button.dart';

class HelpDetail extends StatefulWidget {
  String name;
  String message;
  String email;
  String status;
  String uuid;
  HelpDetail(
      {super.key,
      required this.email,
      required this.message,
      required this.status,
      required this.uuid,
      required this.name});

  @override
  State<HelpDetail> createState() => _HelpDetailState();
}

class _HelpDetailState extends State<HelpDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    widget.name,
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
                    "Email",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      widget.message,
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 150,
                child: SaveButton(
                  title: "Accept",
                  onTap: _acceptStatus,
                ),
              ),
            ),
          ]),
        ));
  }

  void _acceptStatus() async {
    try {
      await FirebaseFirestore.instance
          .collection(
              'collectionPath') // Replace with your Firebase collection name
          .doc(widget.uuid) // Using the user's UID to reference their document
          .update({'status': 'resolved'});

      setState(() {
        widget.status = 'accepted'; // Update the status locally
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Resolved"),
        backgroundColor: Colors.green,
      ));
      Navigator.of(context).pop();
    } catch (e) {
      print("Error updating status to accepted: $e");
    }
  }
}
