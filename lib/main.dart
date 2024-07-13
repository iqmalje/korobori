import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:korobori/providers/activitydatesprovider.dart';
import 'package:korobori/urusetia/views/authentication/login.dart';
import 'package:korobori/urusetia/views/temppage.dart';
import 'package:korobori/urusetia/views/temppagepemimpin.dart';
import 'package:korobori/urusetia/views/temppagepkk.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool hasLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
      url: dotenv.env['URL']!, anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  // check whether uuser has logged in or not
  hasLoggedIn = Supabase.instance.client.auth.currentUser != null;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => ActivityDatesProvider())
      ],
      child: MaterialApp(
        title: 'Korobori 2024',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: hasLoggedIn
            ? FutureBuilder(
                future: AuthController()
                    .getAccount(Supabase.instance.client.auth.currentUser!.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Material(
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    context.read<AccountProvider>().account = snapshot.data;
                    if (snapshot.data!.role == 'officer') {
                      return const TempPage();
                    } else if (snapshot.data!.role == 'pemimpin') {
                      return const TempPagePemimpin();
                    } else {
                      return const TempPagePKK();
                    }
                  }
                })
            : const LoginPage(),
      ),
    );
  }
}
