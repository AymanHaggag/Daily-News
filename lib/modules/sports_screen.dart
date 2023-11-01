import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_states.dart';
import '../shared/component.dart';

class EconomicScreen extends StatelessWidget {
  const EconomicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context , state){} ,
      builder:(context , state){

        var ecoList = NewsCubit.get(context).sports ;

        return articleBuilder(ecoList, context);
      } ,
    );
  }
}
