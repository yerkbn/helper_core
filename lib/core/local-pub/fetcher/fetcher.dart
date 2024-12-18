import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:helper_core/core/local-pub/fetcher/fetcher/fetcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper_core/core/desin-system/states/failure/custom_failure.dart';
import 'package:helper_core/core/desin-system/states/loading/custom_loading.dart';
import 'package:helper_core/core/usecases/no_params.dart';
import 'package:helper_core/core/usecases/params_parent.dart';
import 'package:helper_core/core/usecases/usecase.dart';

/// This is simple module is responsibile for fetching elements
/// and provide it to provided class and handle all View cases
/// [LOADING, ERROR, SUCCESS]

class Fetcher<T> {
  final UseCase<T, ParamsParent> fetcherUseCase;
  final Widget Function(T feet) buildSuccess;
  final Function(BuildContext context, FetcherState state)? listener;
  final bool isRefreshIsEnabled;
  final Widget? loadingShimmer;
  final ParamsParent initalParams;
  final bool showFailure;
  final Function(T feet)? successEntity;

  // local usage
  // final IndicatorController _refreshController = IndicatorController();
  final FetcherBloc<T> _fetcherBloc;
  T? _data;

  Fetcher({
    required this.buildSuccess,
    required this.fetcherUseCase,
    this.loadingShimmer,
    this.listener,
    this.isRefreshIsEnabled = true,
    this.initalParams = const NoParams(),
    this.showFailure = true,
    this.successEntity,
  }) : _fetcherBloc = FetcherBloc<T>(fetcherUseCase: fetcherUseCase);

  void dispose() {
    _fetcherBloc.close();
  }

  void add(T data) {
    _fetcherBloc.add(EditFetcherEvent<T>(data: data));
  }

  /// this update build method with new
  /// fetched data, it can be called from outside
  void fetch({ParamsParent? params}) {
    _fetcherBloc.add(StartFetcherEvent(params: params ?? initalParams));
  }

  Widget build(BuildContext context,
      {Widget Function(T feet)? buildSuccessDirect, Widget? loadingWidget}) {
    if (isRefreshIsEnabled) {
      return CustomMaterialIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          _fetcherBloc
              .add(RefreshFetcherEvent(result: _data, params: initalParams));
        },
        indicatorBuilder: (_, __) => const CustomLoading(color: Colors.black),
        useMaterialContainer: false,
        child: _buildContent(context, buildSuccessDirect: buildSuccessDirect),
      );
    }
    return _buildContent(context, buildSuccessDirect: buildSuccessDirect);
  }

  Widget _buildContent(BuildContext context,
      {Widget Function(T feet)? buildSuccessDirect, Widget? loadingWidget}) {
    return BlocConsumer(
        listener: (BuildContext context, FetcherState state) {
          if (isRefreshIsEnabled) {
            if (!((state is LoadingFetcherState) ||
                (state is RefreshFetcherState))) {
              // _refreshController.refreshCompleted();
            }
          }

          if (state is SuccessFetcherState<T>) {
            if (successEntity != null) {
              successEntity!(state.result);
            }
          }
        },
        bloc: _fetcherBloc,
        builder: (BuildContext context, FetcherState state) {
          if (listener != null) {
            listener!(context, state);
          }
          if (state is LoadingFetcherState || state is InitialFetcherState) {
            if (loadingShimmer != null) {
              return loadingShimmer!;
            }

            return loadingWidget ?? const CustomLoading();
          }
          if (state is FailureFetcherState) {
            // return Container(color: Colors.red, child: Text("sss"),);
            _data = null;
            if (!showFailure) {
              if (loadingShimmer != null) {
                return loadingShimmer!;
              }
              return const SizedBox.shrink();
            }

            return CustomFailure(
              onTap: () {
                fetch();
              },
              status: FailureStatus.h3,
            );
          }
          if (state is SuccessFetcherState<T>) {
            _data = state.result;
            return buildSuccessDirect == null
                ? buildSuccess(state.result)
                : buildSuccessDirect(state.result);
          }
          if (state is RefreshFetcherState) {
            if (state.result == null) {
              return CustomFailure(
                onTap: () {
                  fetch();
                },
              );
            } else {
              return buildSuccessDirect == null
                  ? buildSuccess(state.result as T)
                  : buildSuccessDirect(state.result as T);
            }
          }
          return Container();
        });
  }

  T get data => _data as T;

  void modify(T data) => add(data);
}
