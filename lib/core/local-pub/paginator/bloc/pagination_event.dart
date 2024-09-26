part of 'pagination_bloc.dart';

abstract class PaginationEvent {}

class NetxtPaginationEvent extends PaginationEvent {}

class EditPaginationEvent<T> extends PaginationEvent {
  final T data;

  EditPaginationEvent(this.data);
}

class QueryPaginationEvent extends PaginationEvent {
  final String query;
  QueryPaginationEvent(this.query);
}

class FilterPaginationEvent extends PaginationEvent {
  final Map<String, dynamic> filter;

  FilterPaginationEvent(this.filter);
}
