// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/componets/compontes.dart';

import '../cubit/state.dart';
import '../module/seach/search.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(onPressed: () {
                  navigateTo(context, searchScreen());
                }, icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      NewsCubit.get(context).changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined))
              ],
            ),
            floatingActionButton:
                FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.ChangeBottomNavBar(index),
                items: cubit.bottomItem),
          );
        },

    );
  }
}
