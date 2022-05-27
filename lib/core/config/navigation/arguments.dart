/// It is used to send values from one screen to another screen.
class NavigationArguments {
  /// Value to send
  Object? data;

  /// Value to security data
  SecurityArguments? security;

  /// Standard constructor
  NavigationArguments({
    this.data,
    this.security,
  });
}

/// To understand from which screen the screen will come
///
/// and go to which screen and which function it should go through.
class SecurityArguments {
  /// Returns the name of the screen it came from
  final String from;

  /// Returns the name of the screen to go to.
  final String to;

  /// Goes to the [to] screen specified in the screen navigation.
  final Future<Object?> Function() onSuccess;

  /// This function is used to return to the [from] screen.
  final Future<Object?> Function() onError;

  /// Standard constructor
  const SecurityArguments({
    required this.from,
    required this.to,
    required this.onSuccess,
    required this.onError,
  });
}
