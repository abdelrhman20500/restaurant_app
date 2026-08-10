import 'package:flutter_bloc/flutter_bloc.dart';

/// الهدف منه اننا نتتابع الخطوات والحالات ماشيه ازاي بتاع الابلكيشن
class SimpleBlocObserver extends BlocObserver{
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(" on Change --${bloc.runtimeType}");
    print(" currentState --${change.currentState}");
    print(" nextState --${change.nextState}");
  }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("onError -- ${bloc.runtimeType}");
    print("onError -- $error");
  }
}