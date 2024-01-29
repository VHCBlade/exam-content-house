import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/view.dart' as base;

import '../bloc.dart';

class ViewState extends base.ViewState {
  @override
  Widget content(BuildContext context) {
    final bloc = context.bloc;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Image.network(bloc.imageLink, height: 200),
          const SizedBox(height: 20),
          Text(bloc.message),
          const SizedBox(height: 20),
          Text('${context.select<Bloc, int>((value) => value.count)}'),
          ElevatedButton(
            onPressed: context.bloc.incrementCounter,
            child: Text(context.strings.examCounterButtonLabel),
          ),
        ],
      ),
    );
  }
}
