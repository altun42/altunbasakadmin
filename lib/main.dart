import 'package:altunbasakadmin/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  localization.init(
    mapLocales: [
      const MapLocale('tr', AppLocale.TR),
    ],
    initLanguageCode: 'tr',
  );
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: "Altunbasak Admin",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: localization.localizationsDelegates,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: ThemeData(
              primarySwatch: Colors.orange,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "Rubik Bold",
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              )),
        );
      },
    );
  }
}

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> TR = {title: 'Lokalizasyon'};
}
