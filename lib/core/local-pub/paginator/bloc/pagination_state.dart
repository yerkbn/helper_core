part of 'pagination_bloc.dart';

abstract class PaginationState extends Equatable {}

class LoadingPaginationState extends PaginationState {
  @override
  List<Object?> get props => [];
}

class FailurePaginationState extends PaginationState {
  @override
  List<Object?> get props => [];
}

class SuccessPaginationState<T extends PaginationParent>
    extends PaginationState {
  final T data;

  SuccessPaginationState({required this.data});
  @override
  List<Object?> get props => [data];
}

class ShortLoadingPaginationState<T extends PaginationParent>
    extends PaginationState {
  final T data;

  ShortLoadingPaginationState({required this.data});
  @override
  List<Object?> get props => [data];
}
