import 'package:flutter/material.dart';
import 'package:v6001_prashant_saxena/constants/localisation/strings.dart';
import 'package:v6001_prashant_saxena/modules/popMenu/screen_newBroadcast.dart';
import 'package:v6001_prashant_saxena/modules/popMenu/screen_newGroup.dart';
import 'package:v6001_prashant_saxena/modules/settings/screen_settings.dart';
import 'package:v6001_prashant_saxena/widgets/item_alertDialog.dart';
import '../constants/color.dart';
import '../modules/calls/calls.dart';
import '../modules/camera/camera.dart';
import '../modules/chats/chats.dart';
import '../modules/popMenu/screen_LinkedDeviceScreen.dart';
import '../modules/status/screen_statusPrivacy.dart';
import '../modules/status/status.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          appBar:
          AppBar(automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).appBarTheme.color,
            title: Text(
              Strings.of(context)!.WhatsApp,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              _selectedIndex == 1
                  ? PopupMenuButton(
                      onSelected: (result) {
                        if (result == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NewGroupScreen(),
                            ),
                          );
                        } else if (result == 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NewBroadcastScreen(),
                            ),
                          );
                        } else if (result == 3) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LinkedDeviceScreen(),
                            ),
                          );
                        } else if (result == 4) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        } else if (result == 5) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        }
                      },
                      color: appBarColor,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text(Strings.of(context)!.NewGroup),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text(Strings.of(context)!.NewBroadcast),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text(Strings.of(context)!.LinkedDevice),
                              value: 3,
                            ),
                            PopupMenuItem(
                              child: Text(Strings.of(context)!.StarredMessages),
                              value: 4,
                            ),
                            PopupMenuItem(
                              child: Text(Strings.of(context)!.Payments),
                              value: 5,
                            ),
                            PopupMenuItem(
                              child: Text(Strings.of(context)!.Settings),
                              value: 6,
                            ),
                          ])
                  : _selectedIndex == 2
                      ? PopupMenuButton(
                          onSelected: (result) {
                            if (result == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StatusPrivacyScreen(),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ),
                              );
                            }
                          },
                          color: appBarColor,
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child:
                                      Text(Strings.of(context)!.StatusPrivacy),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(Strings.of(context)!.Settings),
                                  value: 2,
                                )
                              ])
                      : PopupMenuButton(
                          onSelected: (result) {
                            if (result == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MyAlertDialogue(
                                      title:
                                          'Do you want to clear your entire log',
                                      content: 'content',
                                      opt1: 'CANCEL',
                                      opt2: 'OK'),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ),
                              );
                            }
                          },
                          color: appBarColor,
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsScreen(),
                                      ),
                                    );
                                  },
                                  child:
                                      Text(Strings.of(context)!.ClearCallLogs),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text(Strings.of(context)!.Settings),
                                  value: 2,
                                ),
                              ]),
            ],
            bottom: TabBar(
              onTap: (int selected) {
                setState(() {
                  _selectedIndex = selected;
                });
              },
              indicatorColor: tabColor,
              labelColor: tabColor,
              unselectedLabelColor: Colors.grey,
              indicatorWeight: 3,
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
              tabs: [
                Tab(icon: Icon(Icons.camera_alt_rounded)),
                Tab(text: Strings.of(context)!.Chats),
                Tab(text: Strings.of(context)!.Status),
                Tab(text: Strings.of(context)!.Calls),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Camera(),
              Chats(),
              Status(),
              Calls(),
            ],
          ),
        ));
  }
}
