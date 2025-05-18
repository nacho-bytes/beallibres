import 'package:flutter/material.dart'
    show Card, CircularProgressIndicator, InkWell, ListTile, Theme;
import 'package:flutter/widgets.dart'
    show
        Align,
        Alignment,
        Axis,
        BorderRadius,
        BoxFit,
        BuildContext,
        Center,
        Clip,
        ClipRRect,
        CrossAxisAlignment,
        EdgeInsets,
        Flex,
        Flexible,
        GridView,
        Hero,
        Image,
        ImageChunkEvent,
        Padding,
        ScrollController,
        SliverGridDelegateWithMaxCrossAxisExtent,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../../app/app.dart'
    show $BookDetailsRouteExtension, Book, BookDetailsRoute;
import '../../../domain/domain.dart' show BooksRepository;
import '../../presentation.dart' show AdaptiveNavigationTrail;
import 'home_bloc.dart' show HomeBloc, HomeFetchBooksEvent, HomeState;

/// A widget that displays a grid of book covers.
class BookGaleryPage extends StatefulWidget {
  /// Creates a widget that displays a grid of book covers.
  ///
  /// The [key] is optional and defaults to `null`.
  const BookGaleryPage({
    super.key,
  });

  @override
  State<BookGaleryPage> createState() => _BookGaleryPageState();
}

class _BookGaleryPageState extends State<BookGaleryPage> {
  final ScrollController _scrollController = ScrollController();
  bool endOfPage = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollState);
  }

  // TODO - Call this not only when the user scrolls to the end of the page
  //        but also when the user changes the screen size and waits for the
  //        new books to load.
  void _updateScrollState() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        endOfPage = true;
      });
    } else {
      setState(() {
        endOfPage = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateScrollState)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocProvider<HomeBloc>(
        create: (final BuildContext context) => HomeBloc(
          booksRepository: context.read<BooksRepository>(),
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (
            final BuildContext context,
            final HomeState state,
          ) {
            if (endOfPage && !state.isLoading && !state.hasReachedMax) {
              context.read<HomeBloc>().add(const HomeFetchBooksEvent());
            }
            final bool isLargeScreen =
                AdaptiveNavigationTrail.isLargeScreen(context);
            return GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: isLargeScreen ? 500 : 200,
                childAspectRatio: AdaptiveNavigationTrail.isLargeScreen(context)
                    ? 3 / 2
                    : 1 / 2,
              ),
              itemCount: state.books.length,
              itemBuilder: (
                final BuildContext context,
                final int index,
              ) =>
                  BookCard(
                book: state.books[index],
              ),
            );
          },
        ),
      );
}

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(final BuildContext context) {
    final bool isLargeScreen = AdaptiveNavigationTrail.isLargeScreen(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.go(BookDetailsRoute(isbn: book.isbn).location),
        splashColor: Theme.of(context).colorScheme.secondary.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
            children: <Widget>[
              Flexible(
                flex: isLargeScreen ? 1 : 2,
                child: Center(
                  child: Hero(
                    tag: 'cover-${book.isbn}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: book.imageUrl.isNotEmpty
                          ? Image.network(
                              book.imageUrl,
                              // fit: BoxFit.cover,
                              fit:
                                  isLargeScreen ? BoxFit.cover : BoxFit.contain,
                              loadingBuilder: (
                                final BuildContext context,
                                final Widget child,
                                final ImageChunkEvent? loadingProgress,
                              ) =>
                                  loadingProgress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator()),
                            )
                          : Image.asset(
                              'assets/images/book-cover-placeholder.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: isLargeScreen ? 2 : 1,
                child: Align(
                  alignment: isLargeScreen
                      ? const Alignment(0, -1 / 3)
                      : Alignment.center,
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
