import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/setteings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'status.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sport'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeIndex(index) {
    currentindex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];

  void getBusinessData() {
    emit(NewsGetBusinessDataLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'de',
        'category': 'business',
        'apiKey': '8535b49f76cd4f1da677a65b9762d6d6',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessDataErrorState());
    });
  }

  void getScienceData() {
    emit(NewsGetScienceDataLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'de',
        'category': 'science',
        'apiKey': '8535b49f76cd4f1da677a65b9762d6d6',
      },
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetDataScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsDataErrorState());
    });
  }

  void getSportsData() {
    emit(NewsGetSportsDataLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'de',
        'category': 'sport',
        'apiKey': '8535b49f76cd4f1da677a65b9762d6d6',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsDataErrorState());
    });
  }

  bool isDark = false;

  void changeTheme({bool sharedBool}) {
    if (sharedBool != null) {
      isDark=sharedBool;
      emit(NewsChangeThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        print(isDark);
        print('done');
        emit(NewsChangeThemeState());
      });
    }
  }

  List<dynamic> search=[];

  void getSearchData(String word) {
    search=[];
    emit(NewsGetSearchLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'q': '$word',
        'apiKey': '8535b49f76cd4f1da677a65b9762d6d6',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
    search=[];

  }

}
