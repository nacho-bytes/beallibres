import 'package:equatable/equatable.dart' show Equatable;

class Book extends Equatable {
  const Book({
    required this.isbn,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.language,
    required this.title,
  });

  factory Book.fromMap(
    final Map<String, dynamic> data,
    final String documentId,
  ) =>
      Book(
        isbn: documentId,
        author: data[authorString] as String? ?? '',
        description: data[descriptionString] as String? ?? '',
        imageUrl: data[imageUrlString] as String? ?? '',
        language: data[languageString] as String? ?? '',
        title: data[titleString] as String? ?? '',
      );

  static const String authorString = 'author';
  static const String descriptionString = 'description';
  static const String imageUrlString = 'imageUrl';
  static const String languageString = 'language';
  static const String titleString = 'title';

  final String isbn;
  final String author;
  final String description;
  final String imageUrl;
  final String language;
  final String title;

  Map<String, dynamic> toMap() => <String, dynamic>{
        authorString: author,
        descriptionString: description,
        imageUrlString: imageUrl,
        languageString: language,
        titleString: title,
      };

  @override
  List<Object?> get props =>
      <Object?>[isbn, author, description, imageUrl, language, title];

  @override
  String toString() => 'Book{'
      'isbn: $isbn'
      ', $authorString: $author'
      ', $descriptionString: $description'
      ', $imageUrlString: $imageUrl'
      ', $languageString: $language'
      ', $titleString: $title'
      '}';
}
