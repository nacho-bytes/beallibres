import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../../../app/app.dart' show Book;
import '../../../domain/domain.dart' show BooksRepository;

part 'book_details_state.dart';
part 'book_details_event.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc({
    required final BooksRepository booksRepository,
  }) :  _booksRepository = booksRepository,
        super(const BookDetailsState()) {
    on<BookDetailsGetBookEvent>(_onGetBook);
  }

  final BooksRepository _booksRepository;

  Future<void> _onGetBook(
    final BookDetailsGetBookEvent event,
    final Emitter<BookDetailsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final Book? book = await _booksRepository.fetchBookByISBN(event.isbn);
    emit(state.copyWith(book: book, isLoading: false));
  }
}
