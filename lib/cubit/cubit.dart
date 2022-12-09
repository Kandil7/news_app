// ignore_for_file: avoid_print, non_constant_identifier_names, unused_element

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/module/business/business.dart';
import 'package:news_app/module/science/science.dart';
import 'package:news_app/module/settings/setting.dart';
import 'package:news_app/module/sport/sport.dart';
import 'package:news_app/network/local/cach_helper.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List screens = [Business(), Science(), Sport(), Settings()];

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_outlined), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sport'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  ChangeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getScienceNews();
    // } else if (index == 2) {
    //   getSportNews();
    // }
    emit(NewsBottomNavBarState());
  }

  List<dynamic> businessNews = [];

  void getBusinessNews() {
    emit(NewsGetBusinessLoadingState());
    if (businessNews.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '25e7599f689e4ba1a88f464456bed900'
      }).then((value) {
        businessNews = value.data['articles'];
        print(businessNews[0]['title']);
        emit(NewsGetBusinessSuccessfulState());
      }).catchError((error) {
        print("error happen ! ${error.toString()}");
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessfulState());
    }
  }

  List<dynamic> scienceNews = [];

  void getScienceNews() {
    emit(NewsGetScienceLoadingState());
    if (scienceNews.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '25e7599f689e4ba1a88f464456bed900'
      }).then((value) {
        scienceNews = value.data['articles'];
        print(scienceNews[0]['title']);
        emit(NewsGetScienceSuccessfulState());
      }).catchError((error) {
        print("error happen ! ${error.toString()}");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessfulState());
    }
  }

  List<dynamic> sportNews = [];

  void getSportNews() {
    emit(NewsGetSportLoadingState());
    if (sportNews.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '25e7599f689e4ba1a88f464456bed900'
      }).then((value) {
        sportNews = value.data['articles'];
        print(sportNews[0]['title']);
        emit(NewsGetSportSuccessfulState());
      }).catchError((error) {
        print("error happen ! ${error.toString()}");
        emit(NewsGetSportErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportSuccessfulState());
    }
  }

  List<dynamic> searchItem = [];

  void getSearch(String? value)
  {
    emit(NewsSearchLoadingState());
    searchItem = [];


    DioHelper.getData(url: "v2/everything", query: {
      'q': value!,
      'category': 'science',
      'apiKey': '25e7599f689e4ba1a88f464456bed900'
    }).then((value) {
      searchItem = value.data['articles'];
      print(searchItem[0]['title']);
      emit(NewsSearchState());
    }).catchError((error) {
      print("error happen ! ${error.toString()}");
      emit(NewsSearchErrorState(error.toString()));
    });
  }


  bool? isDark = true;
  changeAppMode({bool? fromShare}) {
    if (fromShare != null) {
      isDark = fromShare;
      emit(NewsChangeAppModeState());

    } else {
      isDark = !isDark!;
      CachHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(NewsChangeAppModeState());
    });


  }
}
}
