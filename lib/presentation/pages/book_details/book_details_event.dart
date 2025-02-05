part of 'book_details_bloc.dart';

sealed class BookDetailsEvent {
  const BookDetailsEvent();
}

final class BookDetailsGetBookEvent extends BookDetailsEvent {
  const BookDetailsGetBookEvent(this.isbn);

  final String isbn;
}
