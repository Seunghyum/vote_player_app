import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:cached_storage/cached_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:vote_player_app/router.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  CachedQuery.instance.configFlutter(
    storage: await CachedStorage.ensureInitialized(),
    config: QueryConfigFlutter(
      refetchOnResume: true,
      refetchOnConnection: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade400),
        useMaterial3: true,
      ),
    );
  }
}
