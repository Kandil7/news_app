// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/layout/bloc_observe.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/componets/constans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  isDark = CachHelper.getData(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessNews()
            ..getScienceNews()
            ..getSportNews()..changeAppMode(fromShare: isDark),

      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(

                    titleSpacing: 18,
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(

                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    iconTheme: IconThemeData(color: Colors.black)),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                textTheme: TextTheme(

                    bodyText2: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.deepOrangeAccent,
                    unselectedItemColor: Colors.grey[700])),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Color(0xFF141d26),
                appBarTheme: AppBarTheme(
                    titleSpacing: 18,
                    backgroundColor: Color(0xFF141d26),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xFF141d26),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    iconTheme: IconThemeData(color: Colors.white)),
                //floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
                textTheme: TextTheme(
                    bodyText2: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Color(0xFF243447),
                    selectedItemColor: Colors.deepOrangeAccent,
                    unselectedItemColor: Colors.grey)),
            debugShowCheckedModeBanner: false,
            themeMode: NewsCubit.get(context).isDark!
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
                textDirection: TextDirection.rtl, child: NewsApp()),
          );
        },
      ),
    );
  }
}
