import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/screen/detail/reportDetail.dart';
import 'package:jilani_admin/utils/color.dart';

class Complains extends StatefulWidget {
  const Complains({super.key});

  @override
  State<Complains> createState() => _ComplainsState();
}

class _ComplainsState extends State<Complains> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("report")
                .where("status", isEqualTo: "pending")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help,
                      size: 120,
                      color: mainColor,
                    ),
                    Text('No User Complaint Yet Required Yet',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 20,
                        )),
                  ],
                ));
              }
              var userDocs = snapshot.data!.docs;

              return ListView.builder(
                padding: EdgeInsets.zero,

                itemCount: userDocs.length, // For simplicity
                itemBuilder: (context, index) {
                  final Map<String, dynamic> data =
                      userDocs[index].data() as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      trailing: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => ReportDetail(
                                    name: data['name'],
                                    message: data['message'],
                                    email: data['email'],
                                    uuid: data['uuid'],
                                    status: data['status'],
                                  ),
                                ));
                          },
                          child: Text(
                            "View Details",
                            style: TextStyle(color: mainColor),
                          )),
                      title: Text(data['name'] ?? 'No Name'),
                      subtitle: Text(data['email'] ?? 'No Phone'),
                    ),
                  );
                },
              );
            }));
  }
}
