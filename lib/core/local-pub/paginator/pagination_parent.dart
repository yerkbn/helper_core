import 'package:equatable/equatable.dart';

abstract class PaginationParent<S> extends Equatable {
  const PaginationParent();

  /// This will get how many pages current data contain
  int get getTotalPages;

  /// This will display current page
  int get getCurrentPage;

  /// When new page download is finish it will be merged with old one
  PaginationParent merge(PaginationParent newParsed);

  /// To get pagination items
  List<S> get getChilds;

  PaginationParent edit(PaginationParent newUpdate);
}
