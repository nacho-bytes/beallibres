part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeFetchBooksEvent extends HomeEvent {
  const HomeFetchBooksEvent();
}
