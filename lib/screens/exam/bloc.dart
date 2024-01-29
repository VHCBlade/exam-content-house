export 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/bloc.dart' as base;
import 'package:mobile_exam/core/extensions/response.dart';
import 'package:mobile_exam/core/services/server.dart';

import 'views/main.dart' as main_view;
import 'views/loading.dart' as loading_view;
import 'views/error.dart' as error_view;

enum ErrorType {
  e503,
  e404,
  unexpected,
  ;

  static ErrorType of(int statusCode) {
    switch (statusCode) {
      case 503:
        return ErrorType.e503;
      case 404:
        return ErrorType.e404;
      default:
        return ErrorType.unexpected;
    }
  }
}

extension Extension on BuildContext {
  Bloc get bloc => read<Bloc>();
}

class Bloc extends base.Bloc {
  Bloc(BuildContext context)
      : super(loading_view.ViewState(), context: context);

  late String imageLink;
  late String message;
  late int count;
  ErrorType errorType = ErrorType.unexpected;

  late final Server service;

  @override
  void init() async {
    service = context.server;
    reload(true);
  }

  Future<void> reload([bool initial = false]) async {
    if (!initial) {
      emit(loading_view.ViewState());
    }

    final response = ServerResponse(await service.data);

    if (response.hasError) {
      _handleError(response);
      return;
    }

    _handleData(response);
  }

  void _handleError(ServerResponse response) {
    if (isClosed) {
      return;
    }
    errorType = ErrorType.of(response.statusCode);
    emit(error_view.ViewState());
  }

  void _handleData(ServerResponse response) {
    if (isClosed) {
      return;
    }
    if (response.message == null ||
        response.count == null ||
        response.imageLink == null) {
      _handleError(response);
      return;
    }

    message = response.message!;
    count = response.count!;
    imageLink = response.imageLink!;

    emit(main_view.ViewState());
  }

  Future<void> incrementCounter() async {
    count = await service.addToCount(1);
    if (isClosed) {
      return;
    }
    updateView();
  }
}
