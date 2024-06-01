part of '../domain.dart';

abstract class BaseUseCase {
  const BaseUseCase();
}

abstract class UseCase<Response, Param> extends BaseUseCase {
  const UseCase() : super();

  Future<Response> execute(Param params);
}
