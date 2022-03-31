import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:v6001_prashant_saxena/constants/color.dart';


class InboxScreen extends StatefulWidget {
  final friendUid;
  final friendName;

  InboxScreen({Key? key, this.friendUid, this.friendName}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState(friendUid, friendName);
}

class _InboxScreenState extends State<InboxScreen> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final friendUid;
  final friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var _textController = new TextEditingController();
  _InboxScreenState(this.friendUid, this.friendName);
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void callEmoji() {
    print('Emoji Icon Pressed...');
  }

  void callAttachFile() {
    print('Attach File Icon Pressed...');
  }

  void callCamera() {
    print('Camera Icon Pressed...');
  }

  void callVoice() {
    print('Voice Icon Pressed...');
  }


  Widget moodIcon() {
    return IconButton(
        icon: const Icon(
          Icons.mood,
          color: Colors.grey,
        ),
        onPressed: () => callEmoji());
  }

  Widget attachFile() {
    return IconButton(
      icon: const Icon(Icons.attach_file, color: Colors.grey,),
      onPressed: () => callAttachFile(),
    );
  }

  Widget camera() {
    return IconButton(
      icon: const Icon(Icons.photo_camera, color: Colors.grey),
      onPressed: () => callCamera(),
    );
  }

  Widget voiceIcon() {
    return const Icon(
      Icons.keyboard_voice,
      color: Colors.white,
    );
  }

  Widget sendIcon() {
    return const Icon(
      Icons.send,
      size: 22,
      color: Colors.white,
    );
  }


  void checkUser() async {
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });

              print(chatDocId);
            } else {
              await chats.add({
                'users': {currentUserId: null, friendUid: null}
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {});
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId.toString()).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: chats
            .doc(chatDocId)
            .collection('messages')
            .orderBy('createdOn', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          }

          if (snapshot.hasData) {
            var data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: appBarColor,
                title: Text(
                  friendName,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,),
                centerTitle: false,
                leadingWidth: 70,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),

                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.video_call),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background1.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        reverse: true,
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot document) {
                            data = document.data()!;
                            print(document.toString());
                            print(data['msg']);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ChatBubble(
                                clipper: ChatBubbleClipper6(
                                  nipSize: 5,
                                  radius: 10,
                                  type: isSender(data['uid'].toString())
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble,
                                ),
                                alignment: getAlignment(data['uid'].toString()),
                                margin: EdgeInsets.only(top: 15),
                                backGroundColor:
                                    isSender(data['uid'].toString())
                                        ? messageColor
                                        : chatBarMessage,
                                child: Container(

                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(data['msg'],
                                              style: TextStyle(
                                                  color: isSender(data['uid']
                                                          .toString())
                                                      ? Colors.white
                                                      : Colors.white),
                                              maxLines: 100,
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            data['createdOn'] == null
                                                ? DateTime.now().toString()
                                                : data['createdOn']
                                                    .toDate()
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: isSender(
                                                        data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),

                Container(
                margin: const EdgeInsets.all(5.0),
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: chatBarMessage,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Row(
                          children: [
                            moodIcon(),
                            Expanded(
                              child: TextField(
                                cursorColor: tabColor,
                                controller: _textController,
                                decoration: InputDecoration(
                                    hintText: "Message",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            attachFile(),
                            camera(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 42,
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                          color: tabColor, shape: BoxShape.circle),
                      child: InkWell(
                        child: sendIcon(),
                        onTap: () => sendMessage(_textController.text))
                      ),
                  ],
                ),
                ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 18.0),
                    //         child: CupertinoTextField(
                    //           controller: _textController,
                    //         ),
                    //       ),
                    //     ),
                    //     CupertinoButton(
                    //         child: Icon(Icons.send_sharp),
                    //         onPressed: () => sendMessage(_textController.text))
                    //   ],
                    // )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
