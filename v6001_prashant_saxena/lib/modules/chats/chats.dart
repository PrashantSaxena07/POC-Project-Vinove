import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v6001_prashant_saxena/modules/chats/archived/screen_archived.dart';
import 'package:v6001_prashant_saxena/modules/chats/screen_inbox.dart';
import 'package:v6001_prashant_saxena/widgets/item_settingOption.dart';
import '../../constants/color.dart';
import '../../constants/data.dart';
import '../../constants/localisation/strings.dart';
import '../../widgets/item_ChatList.dart';
import '../contacts/screen_contact.dart';
import 'chat_fire/chat_detail.dart';

class Chats extends StatelessWidget {
  Chats({Key? key}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    print("name$name");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InboxScreen(
                  friendName: name,
                  friendUid: uid,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where('uid', isNotEqualTo: currentUser)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      "No Messaege",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  print("peopleList is coming");

                  return (snapshot.data?.docs.length) == 0
                      ? Center(child: Text("No Contacts added"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            print("hellobhai");

                            DocumentSnapshot people =
                                snapshot.data!.docs[index];
                            print("peopleList$people");

                            return ListTile(
                              onTap: () {
                                callChatDetailScreen(
                                    context, people['name'], people['uid']);
                              },
                              title: Text(
                                people['name'].toString(),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  data[index]['message'].toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data[index]['profilePic'].toString(),
                                ),
                                radius: 25,
                              ),
                              trailing: Text(
                                data[index]['time'].toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          });
                }
                return Container(
                  color: Colors.red,
                );
              }),
          SettingOption(
            title: Strings.of(context)!.Archived,
            leading: Icon(
              Icons.archive_outlined,
              color: Colors.grey,
            ),
            trailing: Text(
              '-',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ArchivedScreen(),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: tabColor,
          child: const Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Inbox(),
              ),
            );
          }),
    );
  }
}
