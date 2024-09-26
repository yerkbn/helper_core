import 'package:helper_core/core/usecases/params_parent.dart';

class NoParams extends ParamsParent {
  const NoParams();

  List<Object?> get props => [];

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {
      ...params,
    };
  }
}
