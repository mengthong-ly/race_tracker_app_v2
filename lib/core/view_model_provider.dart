import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/base_view_model.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatelessWidget {
  const ViewModelProvider(
      {super.key, required this.create, required this.builder, this.child});

  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final Widget? child;
  final Create<T> create;

  @override
  Widget build(BuildContext context) {
    // pkert provider nv nis (local provider)
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => create(context),
      child: Builder(
        builder: (context) {
          T viewModel = Provider.of<T>(context);
          return builder(context, viewModel, child);
        },
      ),
    );
  }
}
