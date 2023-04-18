import 'package:fpdart/fpdart.dart';
import 'package:reddit/Common/failures.dart';

typedef FutureEithertypedef<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEithertypedef<void>;
//typedef FutureEithertypedefff<T> = Future<Either<String, T>>;
