
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_news_app/shared/components/components.dart';
import 'package:full_news_app/shared/cubit/cubit.dart';
import 'package:full_news_app/shared/cubit/states.dart';
// put Column in container to fit the photo
class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>( // <tt> tt what i will listen on it
      listener:(context, state) {} ,
      builder:(context, state) {
        var list = NewsAppCubit.get(context).business;
        return newsBuilder(list, context);
      } ,
    );
  }
}
