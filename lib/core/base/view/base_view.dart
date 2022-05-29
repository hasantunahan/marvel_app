import "package:flutter/material.dart";
import 'package:marvel_api/core/base/model/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T value) builder;
  final VoidCallback? onDispose;
  final Future<bool> Function(T viewmodel)? onBackAction;

  const BaseView({
    required this.viewModel,
    required this.builder,
    Key? key,
    this.onDispose,
    this.onBackAction,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.viewModel.setContext(context);
      widget.viewModel.init();
    });
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!.call();
    }
    widget.viewModel.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BaseView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget _child = widget.builder(context, widget.viewModel);
    return _child;
  }
}
