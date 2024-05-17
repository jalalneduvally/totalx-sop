import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/add%20user/presentation/provider/add_user_provider.dart';
import 'package:totalx/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalx/features/login/presentation/provider/auth_provider.dart';
import 'package:totalx/features/login/presentation/view/screen/splash_screen.dart';
import 'package:totalx/features/search%20user/presentation/provider/user_search_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController(),),
        ChangeNotifierProvider(create: (context) => AddUserController(),),
        ChangeNotifierProvider(create: (context) => GetUserProvider(),),
        ChangeNotifierProvider(create: (context) => GetUserSearchProvider(),),
      ],
      child: const MaterialApp(
        title: 'Totalx',
        home: Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


 