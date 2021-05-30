
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_news_app/modules/search/search_screen.dart';
import 'package:full_news_app/network/remote/dio_helper.dart';
import 'package:full_news_app/shared/components/components.dart';
import 'package:full_news_app/shared/cubit/cubit.dart';
import 'package:full_news_app/shared/cubit/mode_cubit.dart';
import 'package:full_news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = NewsAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                icon: Icon(
                    Icons.search
                ),
                onPressed: (){
                  navigateTo(context, SearchScreen(),);
                },
              ),
              IconButton(
                icon: Icon(
                    Icons.brightness_4_outlined
                ),
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            // type: BottomNavigationBarType.fixed, in app theme
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
            items: cubit.bottomItems,

          ),
        );
      },

    );
  }
}
