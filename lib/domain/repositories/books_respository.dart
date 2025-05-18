import 'package:cloud_firestore/cloud_firestore.dart'
    show
        CollectionReference,
        DocumentReference,
        DocumentSnapshot,
        FieldPath,
        FirebaseFirestore,
        Query,
        QueryDocumentSnapshot,
        QuerySnapshot,
        SetOptions;

import '../../app/app.dart' show Book, Copy;

class BooksRepository {
  BooksRepository({final FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _booksCollection =>
      _firestore.collection('books');

  CollectionReference<Map<String, dynamic>> get _copiesCollection =>
      _firestore.collection('copies');

  Future<Book?> fetchBookByISBN(final String isbn) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _booksCollection.doc(isbn).get();
    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return Book.fromMap(doc.data()!, doc.id);
  }

  Future<List<Copy>> fetchCopiesByBook(final String book) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _copiesCollection.where(Copy.bookString, isEqualTo: book).get();

    return querySnapshot.docs
        .map(
          (final QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Copy.fromMap(doc.data(), doc.id),
        )
        .toList();
  }

  Future<void> upsertBook(final Book book) async {
    await _booksCollection
        .doc(book.isbn)
        .set(book.toMap(), SetOptions(merge: true));
  }

  Future<void> deleteBook(final String isbn) async {
    await _booksCollection.doc(isbn).delete();
  }

  Future<String> addCopy(final String book) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        await _copiesCollection.add(<String, dynamic>{
      Copy.bookString: book,
    });
    return docRef.id;
  }

  Future<void> deleteCopy(final String copyId) async {
    await _copiesCollection.doc(copyId).delete();
  }

  Future<(List<Book> books, DocumentSnapshot<Map<String, dynamic>>? lastDoc)>
      fetchBooksPage({
    final int limit = 10,
    final DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    Query<Map<String, dynamic>> query =
        _booksCollection.orderBy(FieldPath.documentId).limit(limit);

    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument);
    }

    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

    if (querySnapshot.docs.isEmpty) {
      // No hay más resultados
      return (<Book>[], null);
    }

    final List<Book> books = querySnapshot.docs
        .map(
          (final QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Book.fromMap(doc.data(), doc.id),
        )
        .toList();

    final QueryDocumentSnapshot<Map<String, dynamic>> lastDoc =
        querySnapshot.docs.last;

    return (books, lastDoc as DocumentSnapshot<Map<String, dynamic>>);
  }
}
