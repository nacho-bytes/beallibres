import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../../../app/app.dart' show Book;
import '../../../domain/domain.dart' show BooksRepository;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required final BooksRepository booksRepository,
  })  : _booksRepository = booksRepository,
        super(const HomeState()) {
    on<HomeFetchBooksEvent>(_onFetchBooks);
  }

  final BooksRepository _booksRepository;

  Future<void> _onFetchBooks(
    final HomeFetchBooksEvent event,
    final Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) {
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final (
      List<Book> newBooks,
      DocumentSnapshot<Map<String, dynamic>>? newLastDocument,
    ) = await _booksRepository.fetchBooksPage(
      limit: state.limit,
      startAfterDocument: state.lastDocument,
    );

    if (newBooks.isEmpty) {
      emit(
        state.copyWith(
          hasReachedMax: true,
          isLoading: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        books: List<Book>.from(state.books)..addAll(newBooks),
        lastDocument: newLastDocument,
      ),
    );
  }
}
