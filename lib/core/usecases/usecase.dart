import 'package:dartz/dartz.dart';
import 'package:helper_core/core/exception/parent_exception.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ExceptionData, Type>> call(Params params);
}
