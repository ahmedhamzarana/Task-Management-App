import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/add_task_provider.dart';
import 'package:task_management_app/providers/edit_task_provider.dart';
import 'package:task_management_app/providers/fetch_task_provider.dart';
import 'package:task_management_app/providers/login_provider.dart';
import 'package:task_management_app/providers/profile_provider.dart';
import 'package:task_management_app/providers/register_provider.dart';
import 'package:task_management_app/providers/splash_provider.dart';
import 'package:task_management_app/utils/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jpzfbtipieksnwwtqdgn.supabase.co',
    anonKey: 'sb_publishable_Y0KuXNF5kz8aESxEq0VbFA_gT_valaq',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => AddTaskProvider()),
        ChangeNotifierProvider(create: (context) => FetchTaskProvider()),
        ChangeNotifierProvider(create: (context) => EditTaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Sync',
      initialRoute: AppRoutes.splashRoute,
      routes: AppRoutes.routes,
    );
  }
}
