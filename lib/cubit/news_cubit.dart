import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/all_news_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/modules/technology_screen.dart';
import 'package:news_app/shared/network/cache_helper.dart';
import '../shared/network/dio_helper.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(InitialState());

  // Method to be more easily when i call this cubit in many places:
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> appScreens = [
    const AllNewsScreen(),
    const BusinessScreen(),
    const TechnologyScreen(),
    const EconomicScreen(),
  ];



  //SCREEN METHODS.....................................
  var business = [];
  void getBusinessNews(){
    emit(NewsBusinessLoadingState());
    if (business.isEmpty){
      DioHelper.getData(
        url : 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey':'6a60a88f5f5f4c748e5828b450c8f3d3',
        },).then((value) {
        business = value.data['articles'];
        print(value.data.toString());
        emit(NewsGetBusinessSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState());
      });
    }
    else {
      emit(NewsGetBusinessSuccessfulState());
    }

  }

  var tech=[];
  void getTechNews() {
    emit(NewsTechLoadingState());
    if (tech.isEmpty)
    {
      DioHelper.getData(
        url : 'v2/everything',
        query: {
          // q=apple&from=2023-03-24&to=2023-03-24&sortBy=popularity
          'q':'apple',
          'from':'2023-06-15',
          'to':'2023-06-21',
          'sortBy':'popularity',
          'apiKey':'6a60a88f5f5f4c748e5828b450c8f3d3',
        },).then((value) {
        tech = value.data['articles'];
        print(value.data.toString());
        emit(NewsGetTechSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetTechErrorState());
      });
    }
    else{
      emit(NewsGetTechSuccessfulState());
    }
  }

  var sports =[];
  void getSportsNews() {
    emit(NewsSportsLoadingState());
    if(sports.isEmpty)
    {
      DioHelper.getData(
        url : 'v2/top-headlines',
        query: {
          // q=apple&from=2023-03-24&to=2023-03-24&sortBy=popularity
          'country':'us',
          'category':'sports',
          'apiKey':'6a60a88f5f5f4c748e5828b450c8f3d3',
        },).then((value) {
        sports = value.data['articles'];
        print(value.data.toString());
        emit(NewsGetSportsSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState());
      });
    }
    else{
      emit(NewsGetTechSuccessfulState());
    }
  }

  var allNews = [];
  void getAllNews() {
    emit(AllNewsLoadingState());
    if (allNews.isEmpty){
      getBusinessNews();
      getTechNews();
      getSportsNews();

      for (var element in business) { allNews.add(element); }
      for (var element in tech) { allNews.add(element); }
      for (var element in sports) { allNews.add(element); }

       allNews.shuffle();

      emit(AllNewsGetSuccessfulState());

    }
    else{
      emit(AllNewsGetSuccessfulState());
    }
  }

  var search =[];
  void getSearch(value) {

    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(
      url : 'v2/everything',
      query: {
        'q' : '$value',
        'apiKey':'6a60a88f5f5f4c748e5828b450c8f3d3',
      },).then((value) {
      search = value.data['articles'];
      print(value.data.toString());
      emit(NewsGetSearchSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
  }

  //UI METHOD........................................
  bool isDark = false;
  void changeThemeMode({bool? fromSharedPreferences}){
    if (fromSharedPreferences != null)
    {
      isDark = fromSharedPreferences;
      emit(ChangeThemeModeState());
    }else {
      isDark = !isDark;
      CacheHelper.sharedPreferences.setBool('isDark', isDark).then((value) {
        emit(ChangeThemeModeState());});
    }
  }

  void botNavBarChangeIndex(index){
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }


}