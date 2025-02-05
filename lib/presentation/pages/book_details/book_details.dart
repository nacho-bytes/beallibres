import 'package:flutter/material.dart'
    show AppBar, CircularProgressIndicator, Colors, Divider, ElevatedButton, IconButton, Icons, Material, Scaffold, Theme;
import 'package:flutter/widgets.dart'
    show Align, BorderRadius, BoxFit, BuildContext, Center, ClipRRect, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, Hero, Icon, Image, ImageChunkEvent, MediaQuery, Row, SingleChildScrollView, StatelessWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider, ReadContext;
import 'package:gap/gap.dart' show Gap;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../../app/app.dart' show Book;
import '../../../domain/domain.dart' show BooksRepository;
import 'book_details_bloc.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({
    super.key,
    required this.isbn,
  });

  final String isbn;

  @override
  Widget build(final BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return BlocProvider<BookDetailsBloc>(
      create: (final _) => BookDetailsBloc(
        booksRepository: context.read<BooksRepository>(),
      )..add(BookDetailsGetBookEvent(isbn)),
      child: BlocBuilder<BookDetailsBloc, BookDetailsState>(
        builder: (final BuildContext context, final BookDetailsState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.book == null) {
            return Container();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(state.book!.title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: context.pop,
              ),
              actions: const <Widget>[
                // Puedes poner aquí otra acción si fuera necesario
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: isLargeScreen
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: _CoverSection(book: state.book!),
                        ),
                        const Gap(16),
                        Expanded(
                          flex: 2,
                          child: _DetailsSection(book: state.book!),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        _CoverSection(book: state.book!),
                        const Gap(16),
                        _DetailsSection(book: state.book!),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _CoverSection extends StatelessWidget {
  const _CoverSection({required this.book});

  final Book book;

  @override
  Widget build(final BuildContext context) => Hero(
    tag: 'cover-${book.isbn}',
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: book.imageUrl.isNotEmpty
          ? Image.network(
              book.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (
                final BuildContext context,
                final Widget child,
                final ImageChunkEvent? loadingProgress,
              ) =>
                  loadingProgress == null
                      ? child
                      : const Center(child: CircularProgressIndicator()),
            )
          : Image.asset(
              'assets/images/book-cover-placeholder.png',
              fit: BoxFit.cover,
            ),
    ),
  );
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.book});

  final Book book;

  @override
  Widget build(final BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: 'title-${book.isbn}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              book.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        const Gap(8),
        Hero(
          tag: 'author-${book.isbn}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              book.author,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        const Gap(16),
        Text(
          'ISBN: ${book.isbn}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Gap(16),
        const Divider(thickness: 1),
        const Gap(16),
        Text(
          book.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Gap(16),
        Align(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.bookmark),
            label: const Text('Reservar'),
          ),
        ),
      ],
    );
}
