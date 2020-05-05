import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/bloc/dates_bloc/dates_bloc.dart';

import 'core/presentation/bloc/navigator/bloc.dart';
import 'core/presentation/pages/splash_page/splash_page.dart';
import 'core/utils/utils.dart';
import 'di/injection_container.dart' as di;
import 'features/login/presentation/bloc/bloc.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/sturrd/dates/presentation/pages/homepage/homepage.dart';
import 'features/sturrd/dates/presentation/pages/hometabs/browse_tab.dart';
import 'features/sturrd/dates/presentation/pages/select_gender_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env');
  await di.init();
  runApp(
    MyApp(),
  );
}

//api key - DotEnv().env['API_KEY'];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
       BlocProvider<NavigatorBloc>(
      create: (_) => NavigatorBloc(navigatorKey: _navigatorKey)),
      BlocProvider<LoginBloc>(create: (_) =>  di.sl<LoginBloc>()),
      BlocProvider<DatesBloc>(create: (_) => di.sl<DatesBloc>()),

    ],
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Sturrd',
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            initialRoute: HomePage.id,
            routes: <String, Widget Function(BuildContext)>{
              SplashPage.id: (context) => SplashPage(),
              LoginPage.id: (context) => LoginPage(),
              HomePage.id: (context) => HomePage(),
              SettingsPage.id: (context) => SettingsPage(),
              SelectGenderPage.id : (context) => SelectGenderPage(),
              Browse.id : (context) => Browse(),
            },
          );
        });
      }),
    );
  }
}
