import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper_core/core/local-pub/paginator/bloc/pagination_params.dart';
import 'package:helper_core/core/local-pub/paginator/pagination_parent.dart';
import 'package:helper_core/core/usecases/usecase.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc<T extends PaginationParent>
    extends Bloc<PaginationEvent, PaginationState> {
  final UseCase<T, PaginationParams> paginationUseCase;
  final Map<String, dynamic> initialParams;

  /// internal staff
  T? _paginationData;
  Map<String, dynamic> _filter = {};
  String _search = "";

  PaginationBloc({
    required this.paginationUseCase,
    required this.initialParams,
  }) : super(LoadingPaginationState()) {
    _filter = initialParams;
    on<NetxtPaginationEvent>(_onNext);
    on<FilterPaginationEvent>(_onFilter);
    on<EditPaginationEvent<T>>(_onEdit);
    on<QueryPaginationEvent>(_onQuery);
  }

  Future<void> _onEdit(
      EditPaginationEvent<T> event, Emitter<PaginationState> emit) async {
    if (_paginationData == null) {
      _paginationData = event.data;
    } else {
      _paginationData = _paginationData!.edit(event.data) as T;
    }
    emit(SuccessPaginationState<T>(data: _paginationData!));
  }

  Future<void> _onFilter(
      FilterPaginationEvent event, Emitter<PaginationState> emit) async {
    _filter = {...event.filter, ...initialParams};
    _paginationData = null;
    add(NetxtPaginationEvent());
    emit(LoadingPaginationState());
  }

  Future<void> _onQuery(
      QueryPaginationEvent event, Emitter<PaginationState> emit) async {
    _search = event.query;
    _paginationData = null;
    add(NetxtPaginationEvent());
    emit(LoadingPaginationState());
  }

  Future<void> _onNext(
      NetxtPaginationEvent event, Emitter<PaginationState> emit) async {
    /// initial loading displayer
    if (_paginationData == null) {
      emit(LoadingPaginationState());
    } else {
      emit(ShortLoadingPaginationState<T>(data: _paginationData!));
    }

    /// fetching ...
    if (_paginationData != null &&
        _paginationData!.getTotalPages == _paginationData!.getCurrentPage) {
      emit(SuccessPaginationState<T>(data: _paginationData!));
    } else {
      final PaginationParams params = PaginationParams(
        page: (_paginationData?.getCurrentPage ?? 0) + 1,
        secondaryParams: {..._filter},
        search: _search,
      );

      final result = await paginationUseCase(params);
      result.fold(
        (failure) {
          emit(FailurePaginationState());
        },
        (entity) {
          _paginationData = (_paginationData?.merge(entity) ?? entity) as T;
          emit(SuccessPaginationState<T>(data: _paginationData!));
        },
      );
    }
  }

  void refresh() {
    _paginationData = null;
    add(NetxtPaginationEvent());
  }
}
