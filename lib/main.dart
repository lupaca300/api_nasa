import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/screens/details_screen.dart';
import 'package:nasa_api/screens/screen_apod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:nasa_api/screens/home.dart';
import 'package:provider/provider.dart';

void main() async {
  await _initApp();
  runApp(MyApp());
}

_initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  var settingBox = await Hive.openBox('settings');
  if (settingBox.get('isDarkTheme') == null) {
    settingBox.put('isDarkTheme', false);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NasaProvider(),
          lazy: true,
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          initialRoute: 'myHome',
          routes: {
            'screen-apod': (context) => ScreenApod(),
            'details-screen': (context) => DetailsScreen(),
            'myHome': (context) => MyHome(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
