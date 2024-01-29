import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/view.dart' as base;

import '../bloc.dart';

class ViewState extends base.ViewState {
  @override
  Widget content(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              context.bloc.errorType.errorMessage(context),
              style: context.texts.headlineMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () => context.bloc.reload(),
            child: Text(context.strings.reloadButton),
          ),
        ],
      ),
    );
  }
}

extension ErrorMessage on ErrorType {
  String errorMessage(BuildContext context) {
    switch (this) {
      case ErrorType.e503:
        return context.strings.examErrorMessage503;
      case ErrorType.unexpected:
        return context.strings.examErrorMessageUnknown;
    }
  }
}
