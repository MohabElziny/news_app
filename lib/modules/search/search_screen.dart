
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_news_app/shared/components/components.dart';
import 'package:full_news_app/shared/cubit/cubit.dart';
import 'package:full_news_app/shared/cubit/mode_cubit.dart';
import 'package:full_news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener:(context, state) {} ,
      builder: (context, state) {
        var list = NewsAppCubit.get(context).search;
        bool mode = AppCubit.get(context).mode;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value){
                    NewsAppCubit.get(context).getSearch(value);
                  },
                  label: 'search',
                  prefix: Icons.search,
                  isModeLabel: mode ? Colors.white : Colors.black,
                  isModeText: mode ? Colors.white : Colors.black,
                  isModeBorder: mode ? Colors.white : Colors.black,
                ),
              ),
              Expanded(
                  child: newsBuilder(list, context, isSearch: true,)),
            ],
          ),
        );
      },
    );
  }
}
