import 'package:helper_core/core/usecases/params_parent.dart';

class PaginationParams extends ParamsParent {
  final int page;
  final String search;
  final Map<String, dynamic> secondaryParams;

  const PaginationParams({
    required this.page,
    this.search = "",
    this.secondaryParams = const {},
  });

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {'page': page, ...params, ...secondaryParams, 'search': search};
  }

  @override
  List<Object?> get props => [page];
}
