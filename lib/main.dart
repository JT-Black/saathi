// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saathi/providers/post_provider.dart';
import 'screens/list_goal_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PostProvider()),
    ],
    child: SaathiApp(),
  ));
}

class SaathiApp extends StatelessWidget {
  // const SaathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saathi',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[300],
        primarySwatch: Colors.grey,
      ),
      home: ListGoalScreen(),
    );
  }
}
