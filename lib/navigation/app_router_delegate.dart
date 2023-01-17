import 'package:flutter/material.dart';
import 'package:navitator_experiments/data/book.dart';
import 'package:navitator_experiments/navigation/app_route_configuration.dart';
import 'package:navitator_experiments/screens/book_details_screen.dart';
import 'package:navitator_experiments/screens/book_list_screen.dart';
import 'package:navitator_experiments/screens/page_not_found_screen.dart';

class AppRouterDelegate extends RouterDelegate<AppRouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Book? _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book(title: 'Left Hand of Darkness', author: 'Ursula K. Le Guin'),
    Book(title: 'Too Like the Lightning', author: 'Ada Palmer'),
    Book(title: 'Kindred', author: 'Octavia E. Butler'),
  ];

  @override
  AppRouteConfiguration get currentConfiguration {
    if (show404) {
      return AppRouteConfiguration.unknown();
    }
    return _selectedBook == null
        ? AppRouteConfiguration.home()
        : AppRouteConfiguration.details(books.indexOf(_selectedBook!));
  }

  @override
  Future<void> setNewRoutePath(AppRouteConfiguration configuration) async {
    if (configuration.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (configuration.isDetailsPage) {
      if (configuration.id == null) return;
      if (configuration.id! < 0 || configuration.id! > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[configuration.id!];
    } else {
      _selectedBook = null;
    }

    show404 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: BooksListScreen(
            books: books,
            onTapped: _onBookTapped,
          ),
        ),
        if (show404)
          const MaterialPage(child: PageNotFoundScreen())
        else if (_selectedBook != null)
          MaterialPage(child: BookDetailsScreen(book: _selectedBook!))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        _selectedBook = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  void _onBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}
