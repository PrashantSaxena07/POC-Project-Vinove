import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v6001_prashant_saxena/constants/theme/buttton_theme.dart';
import '../../../constants/color.dart';
import '../../../constants/localisation/strings.dart';
import '../../../constants/prefrences.dart';
import '../../../constants/theme/theme_provider.dart';
import '../../../main.dart';
import '../../../widgets/item_settingOption.dart';
import '../../../widgets/item_toogleButton.dart';
import '../screen_settings.dart';

enum Language { English, French }

class ChatsSetting extends StatefulWidget {
  const ChatsSetting({Key? key}) : super(key: key);

  @override
  State<ChatsSetting> createState() => _ChatsSettingState();
}

class _ChatsSettingState extends State<ChatsSetting> {
  int _langGroup = -1;
  int _themeGroup = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          Strings.of(context)!.Chats,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //display tile
            ListTile(
              title: Text('Display', style: TextStyle(color: Colors.grey, fontSize: 14),),
              subtitle: Column(
                children: [
                SettingOption(
                    title: Strings.of(context)!.Theme, leading: Icon(Icons.brightness_4, color: Colors.grey,), subtitle: 'Light, Dark, Summer, Winter, Autumn',
                    onTap: (){
                      showDialog(context: context, builder: (context) =>
                          SimpleDialog(
                            backgroundColor: backgroundColor,
                            children: <Widget>[
                              ThemeButton(),
                            ],
                          ),);
                    }),
                SettingOption(
                  title: 'Wallpaper', leading: Icon(Icons.wallpaper_rounded),),
              ],),
            ),
            Divider(indent: 5,endIndent: 5,),
            //archive tile
            ListTile(
              title: Text(Strings.of(context)!.ArchivedSetting, style: TextStyle(color: Colors.grey, fontSize: 14),),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SettingOption(
                  title: Strings.of(context)!.KeepChatsArchived,
                  leading: null, trailing: MyToogleButton(),
                  subtitle: Strings.of(context)!.ArchivedScreenMsg,),
              ),

            ),
            Divider(indent: 5,endIndent: 5,thickness: 1,),
            //lang, back up...
            ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(children: [
                  SettingOption(
                      title: Strings.of(context)!.AppLang, leading: Icon(CupertinoIcons.globe, color: Colors.grey,), subtitle: 'Phone Language',
                      onTap: (){
                        showDialog(context: context, builder: (context) =>
                            SimpleDialog(
                              backgroundColor: backgroundColor,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  alignment: Alignment.center,
                                  child: RadioListTile<int>(
                                    value: 0,
                                    groupValue: _langGroup,
                                    onChanged: (value) {
                                      setState(() {
                                        _langGroup = value ?? 0;
                                      });
                                      MyApp.setLocale(context, Locale("en"));
                                      Preference.setString(Preference.language, "en");
                                    },
                                    title: Text(
                                      Strings.of(context)!.English,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  alignment: Alignment.center,
                                  child: RadioListTile<int>(
                                    value: 1,
                                    groupValue: _langGroup,
                                    onChanged: (value) {
                                      setState(() {
                                        _langGroup = value ?? 0;
                                      });
                                      MyApp.setLocale(context, Locale("fr"));
                                      Preference.setString(Preference.language, "fr");
                                    },
                                    title: Text(
                                      Strings.of(context)!.French,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),);
                      }),
                  SettingOption(title: 'Chat backup', leading: Icon(Icons.backup)),
                  SettingOption(title: 'Chat history', leading: Icon(Icons.history)),
                ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
