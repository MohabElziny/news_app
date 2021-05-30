import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_news_app/shared/cubit/cubit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:full_news_app/layout/news_layout.dart';
import 'package:full_news_app/network/local/cache_helper.dart';
import 'package:full_news_app/network/remote/dio_helper.dart';
import 'package:full_news_app/shared/bloc_observer.dart';
import 'package:full_news_app/shared/cubit/mode_cubit.dart';
import 'package:full_news_app/shared/cubit/mode_states.dart';
// make block provide to toggle between dark mode and light mode

void main() async {
  // sure every thing in main ending before open the app if main async
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool mode = CacheHelper.getBoolean(key: 'mode');

  runApp(MyApp(mode));
}

class MyApp extends StatelessWidget {

  final bool mode;
  MyApp(this.mode);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsAppCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: mode,
        ),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // 3shan asheel el debug
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backwardsCompatibility: false, // to control status bar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 30,
                backgroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('#121212'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backwardsCompatibility: false, // to control status bar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#121212'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('#121212'),
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 30,
                backgroundColor: HexColor('#121212'),
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )
              ),
            ),
            themeMode:
            AppCubit.get(context).mode ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(), // LoginScreen
          );
        },
      ),
    );
  }
}