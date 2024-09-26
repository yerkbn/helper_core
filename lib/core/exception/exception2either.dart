import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:helper_core/core/exception/parent_exception.dart';
import 'package:helper_core/core/exception/config_exception.dart';

Future<Either<ExceptionData, Payload>> exception2either<Payload>(
    {required Future<Payload> Function() function}) async {
  try {
    return Right(await function());
  } catch (exception) {
    if (exception is DioException) {
      if (exception.error is ExceptionData) {
        return Left(exception.error as ExceptionData);
      } else {
        return Left(
          ConfigNotIdentifiedExcD(
            objectMap: {'exception': exception.error.toString()},
          ),
        );
      }
    }
    return Left(
      ConfigNotIdentifiedExcD(
        objectMap: {'exception': exception.toString()},
      ),
    );
  }
}
