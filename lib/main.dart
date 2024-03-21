import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_wheels/core/routes/go_router_config.dart';
import 'package:rent_wheels/core/search/presentation/provider/search_provider.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rent_wheels/injection.dart' as di;
import 'package:rent_wheels/firebase_options.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/core/image/provider/image_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<GlobalProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<ImageSelectionProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MaterialApp.router(
        theme: theme,
        title: 'Rent Wheels',
        debugShowCheckedModeBanner: false,
        routerConfig: goRouterConfiguration,
      ),
    ),
  );
}
