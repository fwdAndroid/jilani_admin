import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/screen/detail/profile_detail.dart';
import 'package:jilani_admin/utils/color.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
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
                      Icons.person,
                      size: 120,
                      color: mainColor,
                    ),
                    Text('No User Available',
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
                                builder: (builder) => ProfileDetail(
                                    fatherName:
                                        data['fatherName'] ?? "Not Available",
                                    motherName:
                                        data['motherName'] ?? "Not Available",
                                    status: data['status'],
                                    image: data['image'] ??
                                        Image.asset("assets/logo.png"),
                                    fullName: data['fullName'],
                                    uid: data['uid'],
                                    dob: data['dob'] ?? "Not Available",
                                    gender: data['gender'],
                                    sect: data['sect'] ?? "Not Available",
                                    cast: data['cast'] ?? "Not Available",
                                    contactNumber: data['contactNumber'] ??
                                        "Not Available",
                                    qualification: data['qualification'] ??
                                        "Not Available",
                                    aboutYourself: data['aboutYourself'] ??
                                        "Not Available"),
                              ),
                            );
                          },
                          child: Text(
                            "View Details",
                            style: TextStyle(color: mainColor),
                          )),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            data['image'] ?? Image.asset("assets/logo.png")),
                      ),
                      title: Text(data['fullName'] ?? 'No Name'),
                      subtitle: Text(data['contactNumber'] ?? 'No Phone'),
                    ),
                  );
                },
              );
            }));
  }
}
