import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared/component.dart';
import '../cubit/news_states.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(BuildContext context, state){} ,
      builder: (BuildContext context, Object? state){
        return Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            leading: IconButton(
               onPressed: () {
                 NewsCubit.get(context).changeThemeMode();
               },
              icon: const Icon(
                Icons.brightness_medium_outlined,
              ),
            ),
            title: Center(
                child: Text(
                  "Daily News",
                  style: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30
                    ),
                  ),
                )
            ),
            actions: [IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search,),
              )],
          ),

          body: NewsCubit.get(context).appScreens[NewsCubit.get(context).currentIndex] ,

          bottomNavigationBar: BottomNavigationBar(
            currentIndex:  NewsCubit.get(context).currentIndex  ,
            onTap: (index){
              NewsCubit.get(context).botNavBarChangeIndex(index);
              NewsCubit.get(context).getAllNews();
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper,
                    color: Colors.grey,
                  ),
                label: "All News",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.business_center_outlined,
                    color: Colors.teal,
                ),
                label: "Business",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.computer,
                  color: Colors.brown ,),
                label: "Technology",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_football_outlined,
                  color: Colors.indigoAccent,
                ),
                label: "Sports",
              ),
            ],

          ),
        );
      },
    );
  }
}
