import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';

typedef ResultVoidWithMessage = Future<Either<Failure, Success>>;
typedef ResultVoid = Future<Either<Failure, Unit>>;
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef Result<T> = Either<Failure, T>;
