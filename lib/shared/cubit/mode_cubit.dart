
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_news_app/network/local/cache_helper.dart';
import 'package:full_news_app/shared/cubit/mode_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super (AppInitialState());

  // object mn AppCubit
  static AppCubit get(context) => BlocProvider.of(context);

  bool mode = false;

  void changeAppMode({bool fromShared})
  {
    if (fromShared != null)
    {
      mode = fromShared;
      emit(NewsAppChangeModeState());
    } else
    {
      mode = !mode;
      CacheHelper.putBoolean(key: 'mode', value: mode).then((value) {
        emit(NewsAppChangeModeState());
      });
    }
  }
}