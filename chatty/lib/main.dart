
import 'package:chatty/firebase_options.dart';
import 'package:chatty/services/auth_gate.dart';
import 'package:chatty/services/auth_service.dart';
import 'package:chatty/views/chat_page.dart';
import 'package:chatty/views/homepage.dart';
import 'package:chatty/views/login.dart';
import 'package:chatty/views/resgister.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context)=>AuthService(),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 780),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthGate(),
        routes: {
          '/register/': (context) => Register(),
          '/login/': (context) => LoginPage(),
          '/home/': (context) => HomePage(),

        },
      ),
    );
  }
}
