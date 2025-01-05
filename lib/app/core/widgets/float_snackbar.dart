import 'package:flutter/material.dart';

void floatSnackbar({
  required BuildContext context,
  required String message,
  int durationInSeconds = 5,
  bool isError = false,
  bool isAlert = false,
  bool isSuccess = false,
}) {
  final duration = Duration(seconds: durationInSeconds);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: _SnackbarWithProgress(
        message: message,
        duration: duration,
        isError: isError,
        isAlert: isAlert,
        isSuccess: isSuccess,
      ),
      backgroundColor: Colors.transparent,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      // elevation: 0,
    ),
  );
}

class _SnackbarWithProgress extends StatefulWidget {
  final String message;
  final Duration duration;
  final bool isError;
  final bool isAlert;
  final bool isSuccess;

  const _SnackbarWithProgress({
    required this.message,
    required this.duration,
    required this.isError,
    required this.isAlert,
    required this.isSuccess,
  });

  @override
  State<_SnackbarWithProgress> createState() => _SnackbarWithProgressState();
}

class _SnackbarWithProgressState extends State<_SnackbarWithProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _createAnimationController();
  }

  AnimationController _createAnimationController() {
    return AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSnackbarContent(context);
  }

  Widget _buildSnackbarContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _buildSnackbarDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressBar(context),
          const SizedBox(height: 8),
          _buildMessageText(context),
        ],
      ),
    );
  }

  BoxDecoration _buildSnackbarDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getSnackbarBackgroundColor(context),
      borderRadius: BorderRadius.circular(16),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 10,
        decoration: _buildProgressBarBackgroundDecoration(context),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return _buildAnimatedProgressIndicator(context);
          },
        ),
      ),
    );
  }

  BoxDecoration _buildProgressBarBackgroundDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(50),
    );
  }

  Widget _buildAnimatedProgressIndicator(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: _controller.value,
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: _getProgressBarColor(context),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Color _getProgressBarColor(BuildContext context) {
    return Color.lerp(
      Theme.of(context).colorScheme.surfaceContainer,
      Theme.of(context).colorScheme.surfaceContainer,
      _controller.value,
    )!;
  }

  Widget _buildMessageText(BuildContext context) {
    return Flexible(
      child: Text(
        widget.message,
        style: TextStyle(
          color: _getSnackbarForegroundColor(context),
          fontSize: 16,
        ),
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Color _getSnackbarBackgroundColor(BuildContext context) {
    return widget.isError
        ? Theme.of(context).colorScheme.error
        : widget.isAlert
            ? Theme.of(context).colorScheme.errorContainer
            : widget.isSuccess
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface;
  }

  Color _getSnackbarForegroundColor(BuildContext context) {
    return widget.isError
        ? Theme.of(context).colorScheme.onError
        : widget.isAlert
            ? Theme.of(context).colorScheme.onErrorContainer
            : widget.isSuccess
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.surface;
  }
}
