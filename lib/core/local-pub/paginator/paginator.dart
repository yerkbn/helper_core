import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper_core/core/desin-system/states/loading/custom_loading.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/local-pub/extension/sizedbox_extension.dart';
import 'package:helper_core/core/local-pub/paginator/bloc/pagination_bloc.dart';
import 'package:helper_core/core/local-pub/paginator/bloc/pagination_params.dart';
import 'package:helper_core/core/local-pub/paginator/pagination_parent.dart';
import 'package:helper_core/core/usecases/usecase.dart';

/// [T] - stands for bigger holder like {page: 1, ..., items: [S, S, ...]}
class Paginator<T extends PaginationParent<S>, S> {
  final UseCase<T, PaginationParams> paginationUseCase;
  final Widget Function(S item, T paginator) buildItem;
  final EmptyData paginatorEmptyData;
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
    this.paginatorEmptyData = const EmptyData(title: 'Empty!'),
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

  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    if (isRefreshIsEnabled) {
      return RefreshIndicator(
        color: theme.backgroundColor4,
        backgroundColor: theme.backgroundColor2,
        onRefresh: () async {
          _paginationBloc.refresh();
        },
        child: _buildChild(context),
      );
    }

    return _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return SizedBox(
      // height: UiConfig.globalHeight.h,
      child: BlocConsumer<PaginationBloc, PaginationState>(
        bloc: _paginationBloc,
        listener: (BuildContext context, PaginationState state) {
          if (listener != null) {
            // ignore: prefer_null_aware_method_calls
            listener!(state);
          }
          _isLocked = false;
          if (state is ShortLoadingPaginationState) _isLocked = true;
        },
        builder: (BuildContext context, PaginationState state) {
          if (state is LoadingPaginationState) {
            return const CustomLoading(color: Colors.black54);
          }
          // if result exist
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
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // items to build
                      placeholder,
                      for (S item in _data!.getChilds) ...[
                        buildItem(item, _data!)
                      ],

                      // If list is empty
                      if (_data!.getChilds.isEmpty && emptyIsEnabled)
                        const SizedBox.shrink()
                      // Text("Empty", style: theme.headline1)
                      else
                        const SizedBox.shrink(),

                      // loading indicator
                      if (isPagination && _data!.getChilds.isNotEmpty)
                        const CustomLoading(color: Colors.black54)
                      else
                        0.ph,
                    ],
                  ),
                ),
                if (isFillRemaining) SliverFillRemaining(),
              ],
            );
          }

          return const SizedBox.shrink();

          // CustomFailure(
          //   onTap: () {
          //     _paginationBloc.refresh();
          //   },
          // );
        },
      ),
    );
  }

  void scroll2Top() {
    _scrollController.animateTo(
      0.0, // Position to scroll to (0.0 for the top)
      duration: Duration(milliseconds: 300), // Duration of the scroll animation
      curve: Curves.easeOut, // Animation curve for a smooth scroll
    );
  }

  PaginationBloc get getBloc => _paginationBloc;

  T? get data => _data;

  void add(PaginationEvent event) => _paginationBloc.add(event);

  void modify(T data) => _paginationBloc.add(EditPaginationEvent<T>(data));
}

class EmptyData {
  final String title;
  final String subtitle;

  const EmptyData({required this.title, this.subtitle = ''});
}
