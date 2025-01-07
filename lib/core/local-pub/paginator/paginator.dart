import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper_core/core/desin-system/states/loading/custom_loading.dart';
import 'package:helper_core/core/local-pub/paginator/bloc/pagination_bloc.dart';
import 'package:helper_core/core/local-pub/paginator/bloc/pagination_params.dart';
import 'package:helper_core/core/local-pub/paginator/pagination_parent.dart';
import 'package:helper_core/core/usecases/usecase.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

/// [T] - stands for bigger holder like {page: 1, ..., items: [S, S, ...]}
class Paginator<T extends PaginationParent<S>, S> {
  final UseCase<T, PaginationParams> paginationUseCase;
  final Widget Function(S item, T paginator) buildItem;
  final Widget paginatorEmpty;
  final bool isRefreshIsEnabled;
  final void Function(PaginationState state)? listener;
  final Widget placeholder;
  final bool emptyIsEnabled;
  final bool isFillRemaining;

  /// internal isage
  final ScrollController _scrollController = ScrollController();
  final PaginationBloc<T> _paginationBloc;
  T? _data; // this will be used as data if it is null no success load is done
  bool _isLocked = false;

  Paginator({
    required this.paginationUseCase,
    required this.buildItem,
    this.listener,
    this.paginatorEmpty = const SizedBox(),
    this.isRefreshIsEnabled = true,
    this.placeholder = const SizedBox.shrink(),
    Map<String, dynamic> initialParams = const {},
    this.emptyIsEnabled = true,
    this.isFillRemaining = true,
  }) : _paginationBloc = PaginationBloc<T>(
          paginationUseCase: paginationUseCase,
          initialParams: initialParams,
        ) {
    _paginationBloc.add(NetxtPaginationEvent());
    _scrollController.addListener(() {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double currentScroll = _scrollController.position.pixels;
      const double delta = 50.0; // or something else..
      if (maxScroll - currentScroll <= delta && !_isLocked) {
        _paginationBloc.add(NetxtPaginationEvent());
        _isLocked = true;
      }
    });
  }

  void dispose() {
    _paginationBloc.close();
  }

  // return RefreshIndicator(
  //   color: theme.backgroundColor4,
  //   backgroundColor: theme.backgroundColor2,
  //   onRefresh: () async {
  //     await Future.delayed(Duration(seconds: 1));
  //     _paginationBloc.refresh();
  //   },
  //   child: _buildChild(context),
  // );

  Widget build(BuildContext context) {
    if (isRefreshIsEnabled) {
      return CustomMaterialIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          _paginationBloc.refresh();
        },
        indicatorBuilder: (_, __) => const CustomLoading(),
        useMaterialContainer: false,
        child: _buildChild(context),
      );
    }

    return _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return SizedBox(
      child: BlocConsumer<PaginationBloc, PaginationState>(
        bloc: _paginationBloc,
        listener: (BuildContext context, PaginationState state) {
          if (listener != null) {
            listener!(state);
          }
          _isLocked = false;
          if (state is ShortLoadingPaginationState) _isLocked = true;
        },
        builder: (BuildContext context, PaginationState state) {
          if (state is LoadingPaginationState) {
            return const CustomLoading();
          }
          bool isPagination = false;
          if (state is SuccessPaginationState<T>) {
            _data = state.data;
          }
          if (state is ShortLoadingPaginationState<T>) {
            _data = state.data;
            isPagination = true;
          }
          if (_data != null) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              shrinkWrap: false,
              slivers: [
                SliverToBoxAdapter(child: placeholder),
                for (S item in _data!.getChilds)
                  SliverToBoxAdapter(child: buildItem(item, _data!)),
                // Bottom loading
                if (isPagination && _data!.getChilds.isNotEmpty)
                  const SliverToBoxAdapter(child: CustomLoading()),

                // if empty
                if (_data!.getChilds.isEmpty && emptyIsEnabled)
                  SliverToBoxAdapter(child: paginatorEmpty),

                // if end is empty
                if (_data!.getChilds.isEmpty && isFillRemaining)
                  const SliverFillRemaining()
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void scroll2Top() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  PaginationBloc get getBloc => _paginationBloc;

  T? get data => _data;

  void add(PaginationEvent event) => _paginationBloc.add(event);
  void refresh() => _paginationBloc.refresh();

  void modify(T data) => _paginationBloc.add(EditPaginationEvent<T>(data));
}
