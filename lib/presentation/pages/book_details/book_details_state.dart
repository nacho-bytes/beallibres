part of 'book_details_bloc.dart';

final class BookDetailsState extends Equatable {
  const BookDetailsState({
    this.book,
    this.isLoading = false,
  });

  final Book? book;
  final bool isLoading;

  @override
  List<Object?> get props => <Object?>[book, isLoading];

  BookDetailsState copyWith({
    final Book? book,
    final bool? isLoading,
  }) =>
      BookDetailsState(
        book: book ?? this.book,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  String toString() => 'BookState { book: $book }';
}
