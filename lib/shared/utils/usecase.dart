import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCase2<Type, Param1, Param2> {
  Future<Either<Failure, Type>> call(Param1 param1, Param2 param2);
}

class Params<T> {
  final T data;
  Params(this.data);
}

class NoParams {
  NoParams();
}
