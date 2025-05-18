import 'package:equatable/equatable.dart' show Equatable;

class Copy extends Equatable {
  const Copy({
    required this.id,
    required this.book,
  });

  factory Copy.fromMap(
    final Map<String, dynamic> data,
    final String documentId,
  ) =>
      Copy(
        id: documentId,
        book: data[bookString] as String? ?? '',
      );

  static const String bookString = 'book';

  final String id;
  final String book;

  Map<String, dynamic> toMap() => <String, dynamic>{
        bookString: book,
      };

  @override
  List<Object?> get props => [id, book];

  @override
  String toString() => 'Copy{'
      'id: $id'
      ', book: $book'
      '}';
}
