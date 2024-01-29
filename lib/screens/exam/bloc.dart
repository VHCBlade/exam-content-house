export 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/bloc.dart' as base;
import 'package:mobile_exam/core/extensions/response.dart';
import 'package:mobile_exam/core/services/server.dart';

import 'views/main.dart' as main_view;
import 'views/loading.dart' as loading_view;
import 'views/error.dart' as error_view;

extension Extension on BuildContext {
  Bloc get bloc => read<Bloc>();
}

class Bloc extends base.Bloc {
  Bloc(BuildContext context)
      : super(loading_view.ViewState(), context: context);

  @override
  void init() async {
    _reload(true);
  }

  Future<void> _reload([bool initial = false]) async {
    if (!initial) {
      emit(loading_view.ViewState());
    }

    final response = ServerResponse(await context.server.data);

    print(response.baseRequest);

    if (response.hasError) {
      _handleError(response);
      return;
    }

    _handleData(response);
  }

  void _handleError(ServerResponse response) {
    emit(error_view.ViewState());
  }

  void _handleData(ServerResponse response) {
    emit(main_view.ViewState());
  }
}
