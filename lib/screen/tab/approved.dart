import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/utils/color.dart';

class Approved extends StatefulWidget {
  const Approved({super.key});

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("status", isEqualTo: "accepted")
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
                    Text('No Request Accepted',
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
                          onPressed: () {},
                          child: Text(
                            "View Details",
                            style: TextStyle(color: mainColor),
                          )),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (builder) => ProfileDetail(
                        //         friendPhoto: data['image'] ??
                        //             Image.asset("assets/logo.png"),
                        //         friendName: data['fullName'],
                        //         friendId: data['uid'],
                        //         friendDOB: data['dob'] ?? "Not Available",
                        //         gender: data['gender'],
                        //         sect: data['sect'] ?? "Not Available",
                        //         cast: data['cast'] ?? "Not Available",
                        //         friendPhone: data['contactNumber'] ??
                        //             "Not Available",
                        //         friendQualification:
                        //             data['qualification'] ??
                        //                 "Not Available",
                        //         yourSelf: data['aboutYourself'] ??
                        //             "Not Available"),
                        //   ),
                        // );
                      },
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
