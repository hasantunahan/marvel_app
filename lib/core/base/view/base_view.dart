import "package:flutter/material.dart";
import 'package:marvel_api/core/base/model/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T value) builder;
  final VoidCallback? onDispose;
  final Future<bool> Function(T viewmodel)? onBackAction;
  final Function(T model)? didPopNext;
  final Function(T viewmodel, AppLifecycleState state)? onAppLifecycleChanged;
  final bool enableFocusControl;
  final bool isLoading;
  final bool fromTest;
  final RouteObserver<ModalRoute<void>> routeObserver;

  const BaseView({
    required this.viewModel,
    required this.builder,
    required this.routeObserver,
    Key? key,
    this.onDispose,
    this.didPopNext,
    this.onAppLifecycleChanged,
    this.enableFocusControl = true,
    this.isLoading = false,
    this.onBackAction,
    this.fromTest = false,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.viewModel.setContext(context);
      if (!widget.fromTest) {
        widget.viewModel.init();
      }
    });
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
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
    widget.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.onAppLifecycleChanged?.call(widget.viewModel, state);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (widget.didPopNext != null) {
      widget.didPopNext!.call(widget.viewModel);
    }
  }

  Widget _willPopScopeWrapper({required Widget child}) {
    if (widget.onBackAction == null) {
      return child;
    } else {
      return WillPopScope(
        child: child,
        onWillPop: () async {
          return widget.onBackAction != null ? widget.onBackAction!(widget.viewModel) : Future.value(true);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.builder(context, widget.viewModel);

    return _willPopScopeWrapper(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.enableFocusControl) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            child: child,
          ),
          Visibility(
            visible: widget.isLoading,
            child: const CircularProgressIndicator.adaptive(),
          )
        ],
      ),
    );
  }
}
