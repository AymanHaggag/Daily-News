import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context , state){} ,
      builder:(context , state){

        var searchList = NewsCubit.get(context).search ;

        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              onChanged: (value){
                   NewsCubit.get(context).getSearch(value);},
               validator: (value){},
                decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),

              ),
            ),
          ),
        body: articleBuilder(searchList, context , isSearch: true)
        );
      } ,
    );
  }
}