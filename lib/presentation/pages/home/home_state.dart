part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.isLoading = false,
    this.books = const <Book>[],
    this.lastDocument,
    this.limit = 10,
    this.hasReachedMax = false,
  });

  final bool isLoading;
  final List<Book> books;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final int limit;
  final bool hasReachedMax;

  @override
  List<Object?> get props =>
      <Object?>[isLoading, books, lastDocument, limit, hasReachedMax];

  HomeState copyWith({
    final bool? isLoading,
    final List<Book>? books,
    final DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    final int? limit,
    final bool? hasReachedMax,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        books: books ?? this.books,
        lastDocument: lastDocument ?? this.lastDocument,
        limit: limit ?? this.limit,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );
}
