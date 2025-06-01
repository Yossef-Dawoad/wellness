import 'package:dartz/dartz.dart';
import 'package:wellness/core/utils/types/networking_error_types.dart';

typedef ApiResult<T> = Either<NetworkErrorType, T>;
