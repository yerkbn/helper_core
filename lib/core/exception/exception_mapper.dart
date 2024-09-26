import 'package:helper_core/core/exception/config_exception.dart';
import 'package:helper_core/core/exception/network_exception.dart';
import 'package:helper_core/core/exception/parent_exception.dart';
import 'package:helper_core/core/local-pub/extension/map_error_extension.dart';

/// Responsible for parsing exceptions to Dart objects
class ExceptionMapper {
  /// This is default initial instructions
  /// Which will be availible in all games by default
  final Map<int, ExceptionData Function(Map objectMap)> _exceptions = {
    /// CONFIG
    ConfigNotIdentifiedExcD.status: ConfigNotIdentifiedExcD.parseMap,
    ConfigParsingExcD.status: ConfigParsingExcD.parseMap,
    ConfigFormatExcD.status: ConfigFormatExcD.parseMap,

    /// OOF LOCAL
    ParsingExceptionInstr.status: ParsingExceptionInstr.parseMap,

    /// NETWORK
    NetworkFailureExcD.status: NetworkFailureExcD.parseMap,
    UnauthenticatedExcD.status: UnauthenticatedExcD.parseMap,
    BadRequestExcD.status: BadRequestExcD.parseMap,
    NotFoundExcD.status: NotFoundExcD.parseMap,
    TokenExpiredExcD.status: TokenExpiredExcD.parseMap,
    UsernameIsTakenExcD.status: UsernameIsTakenExcD.parseMap,
    SignupFirstExcD.status: SignupFirstExcD.parseMap,
    IncorectCredentialsExcD.status: IncorectCredentialsExcD.parseMap,
    EmailTakenExcD.status: EmailTakenExcD.parseMap,
  };

  /// This should return Data if every thing is OK and statusCode == 1000
  /// or throw exception
  ///
  /// Input Map is a map of format {'statusCode': '', data: {}}
  /// and parse it and return particular instance of [ExceptionData]
  ///
  /// Exceptions:
  /// if failed to parse input throw [InstructionParsingException]
  void mapping(Map objectMap) {
    if (!objectMap.containsKey("result")) {
      objectMap["result"] = {};
    }
    if (objectMap.containsKey('statusCode') &&
        objectMap.containsKey('result') &&
        objectMap.getValueSafely('statusCode') is int) {
      final int statausCode = objectMap.getValueSafely<int>('statusCode');
      ExceptionData customException = ConfigNotIdentifiedExcD(objectMap: {
        'statausCode': statausCode,
        'result': objectMap['result']
      });
      if (_exceptions.containsKey(statausCode)) {
        if (objectMap['result'] is Map) {
          customException =
              _exceptions[statausCode]!(objectMap['result'] as Map);
        } else {
          customException =
              _exceptions[statausCode]!({'result': objectMap['result']});
        }
      }
      if (customException is UnauthenticatedExcD) {
        // Unauthenticated
      }
      throw customException;
    } else {
      // Format is not correct
      throw ConfigFormatExcD(objectMap: objectMap);
    }
  }
}
