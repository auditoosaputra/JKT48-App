import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jkt48_app/model/member_model.dart';
import 'package:jkt48_app/model/user.dart';
import 'package:jkt48_app/screens/home.dart';
import 'package:jkt48_app/screens/login.dart';
import 'package:jkt48_app/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(MembersAdapter());
  Hive.registerAdapter(UserAdapter());
  // Hive.registerAdapter(MembersAdapter());
  Hive.registerAdapter(EventsAdapter());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
