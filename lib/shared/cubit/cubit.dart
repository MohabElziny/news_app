
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_news_app/modules/business/business_screen.dart';
import 'package:full_news_app/modules/science/science_screen.dart';
import 'package:full_news_app/modules/sports/sports_screen.dart';
import 'package:full_news_app/network/remote/dio_helper.dart';
import 'package:full_news_app/shared/cubit/states.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(NewsAppInitialState());

  // object from AppCubit
  static NewsAppCubit get(context) => BlocProvider.of(context);


  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<String> titles = [
    'Business News',
    'Sports News',
    'Science News',
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(NewsAppBottomNavlState());
  }

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '9c247add9401437388bd67294067ddd4',
        }).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('get business data error ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '9c247add9401437388bd67294067ddd4',
          }).then((value) {
        // print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        // print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print('get sports data error ${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }// 3shan may3mlsh load kol shwia
    else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'science',
            'apiKey': '9c247add9401437388bd67294067ddd4',
          }).then((value) {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('get science data error ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '9c247add9401437388bd67294067ddd4',
        }).then((value) {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('get science data error ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}
