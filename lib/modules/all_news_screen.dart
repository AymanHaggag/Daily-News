import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/shared/component.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context , state){} ,
      builder:(context , state){
        //the following command accuses an infinity state for
        // AllNewsGetSuccessfulState
        //NewsCubit.get(context).getAllNews();
        var allNewsList = NewsCubit.get(context).allNews ;
        return articleBuilder(allNewsList, context);
      } ,
    );
  }
}
