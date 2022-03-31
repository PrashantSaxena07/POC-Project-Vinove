import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/data.dart';
import '../../widgets/item_messageBar.dart';
import '../../widgets/item_messageList.dart';

class Inbox extends StatefulWidget {
  final friendUid;
  final friendName;
  const Inbox({Key? key, this.friendUid, this.friendName}) : super(key: key);

  @override
  _InboxState createState() => _InboxState(friendUid, friendName);
}

class _InboxState extends State<Inbox> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final friendUid;
  final friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var _textController = new TextEditingController();
  _InboxState(this.friendUid, this.friendName);
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
          color: Color(0xFF00BFA5),
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
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          data[0]['name'].toString(),
        ),
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

      body: Column(
        children: [
          const Expanded(
            child: MessageList(),
          ),
          MessageBar(),
          // Expanded(
          //   child: Row(
          //     children: [
          //       const MobileChatEntry(),
          //       SizedBox(
          //         height: 45,
          //         width: 45,
          //         child: FittedBox(
          //           child: FloatingActionButton(
          //               child: Icon(Icons.edit,color:Colors.white,),
          //               backgroundColor: appBarColor,
          //               onPressed: () {}),
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
