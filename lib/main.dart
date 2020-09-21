import 'package:flutter/material.dart';
import 'package:atvFlutterExampleActivity/Pages/PlayerPage.dart';
import 'package:provider/provider.dart';

import 'Providers/VideoState.dart';
import 'Service/VideoListService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<VideoListService>(create: (_) => VideoListService()),
        ChangeNotifierProvider<VideoState>(create: (_) => VideoState()),
      ],
      child: MaterialApp(
        title: 'WIREWAX ITV',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        initialRoute: '/PlayerPage',
        routes: {
          '/': (context) => PlayerPage(),
          '/PlayerPage': (context) => PlayerPage(),
        },
      ),
    );
  }
}