import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, BlocBase, BlocObserver, Change, Transition;

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(
    final Bloc<dynamic, dynamic> bloc,
    final Object? event,
  ) {
    super.onEvent(bloc, event);
    // print('Bloc ${bloc.runtimeType} has emitted $event');
  }

  @override
  void onError(
    final BlocBase<dynamic> bloc,
    final Object error,
    final StackTrace stackTrace,
  ) {
    // print('Bloc ${bloc.runtimeType} has failed with $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(
    final BlocBase<dynamic> bloc,
    final Change<dynamic> change,
  ) {
    super.onChange(bloc, change);
    // print('Bloc ${bloc.runtimeType} has changed: $change');
  }

  @override
  void onTransition(
    final Bloc<dynamic, dynamic> bloc,
    final Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    // print('Bloc ${bloc.runtimeType} has transitioned: $transition');
  }
}
