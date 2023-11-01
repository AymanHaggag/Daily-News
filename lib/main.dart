import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/modules/main_screen.dart';
import 'package:news_app/cubit/bloc_observer.dart';
import 'package:news_app/shared/network/cache_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = await CacheHelper().getData(key: 'isDark') ?? false;

  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
        create:(BuildContext context) => NewsCubit()..getAllNews()),
        BlocProvider(
        create:(BuildContext context) => NewsCubit()..changeThemeMode(fromSharedPreferences: isDark)),
      ],
      child: BlocConsumer<NewsCubit , NewsStates>(
          listener:(BuildContext context, state){} ,
          builder: (BuildContext context, state){
            return MaterialApp(

              //DEFINE DARK MODE
              darkTheme: ThemeData(
                progressIndicatorTheme:  const ProgressIndicatorThemeData(
                  color: Colors.grey,
                ),
                appBarTheme: AppBarTheme(
                    color: HexColor('202124'),
                    iconTheme: const IconThemeData(
                      color: Colors.grey,),
                    elevation: 20,
                    foregroundColor: Colors.grey
                ) ,
                scaffoldBackgroundColor: HexColor(
                    '202124'
                ),
                textTheme:  const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('202124'),
                  type: BottomNavigationBarType.fixed,
                  elevation: 20,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                ),
              ),

              //DEFINE LIGHT MODE
              theme: ThemeData(
                progressIndicatorTheme: ProgressIndicatorThemeData(
                  color: HexColor('003366'),
                ),
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: HexColor('003366'),),
                  elevation: 20,
                  foregroundColor: HexColor('003366'),
                ) ,
                textTheme:  const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,

                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  elevation: 20,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                ),
              ),

              //FOR CHOOSING WHICH MODE WILL BE
              themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,

              home: const MainScreen(),
            );
          },
        ),
    );
  }
}
