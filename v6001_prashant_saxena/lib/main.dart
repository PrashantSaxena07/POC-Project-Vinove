import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:v6001_prashant_saxena/modules/settings/screen_settings.dart';
import 'package:v6001_prashant_saxena/screens/mobile_home.dart';
import 'package:v6001_prashant_saxena/screens/web_home.dart';
import 'constants/color.dart';
import 'constants/localisation/app_localization_deligate.dart';
import 'constants/prefrences.dart';
import 'constants/responsiveness.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/theme/theme_provider.dart';
import 'modules/register/screen_landing.dart';
import 'modules/settings/chats/screen_chatsSetting.dart';

int ?initScreen = 0;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  //login skip
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  Preference.load().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    var lang = Preference.getString(Preference.language, def: "en");
    _locale = Locale(lang ?? "en");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var lang = Preference.getString(Preference.language, def: "en");
    _locale = Locale(lang ?? "en");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => ThemeProvider(),
      builder: (context, _) {

        final themeProvider = Provider.of<ThemeProvider>(context);

        return  MaterialApp(
          title: 'WhatsApp Clone',
          locale: _locale,
          supportedLocales: [
            Locale('en', ''),
            Locale('fr', ''),
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                _locale = supportedLocale;
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,

          // theme: ThemeData.dark().copyWith(
          //   scaffoldBackgroundColor: backgroundColor,
          // ),

          // home: const Splash(),

          // home: initScreen == 0 || initScreen == null
          //     ? LandingScreen()
          //     : MobileHome(),


          home: const Responsive(
            mobile_homeLayout: MobileHome(),
            web_homeLayout: WebHome(),
          ),


          // home: Settings(),
          // home: DummyContactScreen(),
          // home: LandingScreen(),
        );
      },


    );
  }
}
