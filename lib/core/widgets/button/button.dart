import "package:flutter/material.dart";

class DefaultButton extends StatelessWidget {
  final BuildContext? context;
  final VoidCallback? onPressed;
  final BorderSide? border;
  final Widget? leftIcon;
  final Widget? icon;
  final Color? textColor;
  final Color? buttonColor;
  final Color? iconColor;
  final Color? disableTextColor;
  final Color? disableColor;
  final String? text;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final bool isFullWidth;
  final bool disabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final AlignmentGeometry? textAlign;
  final bool expandedText;
  final Widget? customContent;
  const DefaultButton({
    required this.onPressed,
    Key? key,
    this.text,
    this.expandedText = true,
    this.textColor,
    this.buttonColor,
    this.borderRadius,
    this.elevation = 0.0,
    this.width,
    this.padding,
    this.border,
    this.icon,
    this.iconColor,
    this.isFullWidth = false,
    this.margin,
    this.disabled = false,
    this.leftIcon,
    this.context,
    this.disableColor = Colors.black12,
    this.disableTextColor = Colors.black26,
    this.height,
    this.textAlign,
    this.customContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: isFullWidth ? MediaQuery.of(context).size.width : width,
        height: height ?? 40,
        child: renderButton(theme, context),
      ),
    );
  }

  ElevatedButton renderButton(ThemeData theme, BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: renderButtonStyle(),
      child: customContent ??
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: renderButtonItems(theme, context),
          ),
    );
  }

  ButtonStyle renderButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(isDisabledColor(disable: disabled, color: buttonColor)),
      elevation: MaterialStateProperty.all(elevation),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          side: disabled && border != null
              ? BorderSide(color: disableTextColor ?? Colors.black87)
              : border ?? const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget renderButtonItems(ThemeData theme, BuildContext context) {
    if (leftIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftIcon ??
              Icon(
                Icons.arrow_back_ios,
                color: iconColor,
              ),
          const SizedBox(
            width: 8,
          ),
          renderText(theme),
        ],
      );
    } else {
      if (icon != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (expandedText) ...[
              Expanded(child: renderText(theme)),
            ] else ...[
              renderText(theme)
            ],
            icon ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                )
          ],
        );
      } else {
        return renderText(theme);
      }
    }
  }

  Widget renderText(ThemeData theme) {
    if (text == null || text == "") {
      return const SizedBox();
    } else {
      return FittedBox(
        alignment: textAlign ?? Alignment.center,
        child: Text(
          text ?? "",
          style: theme.textTheme.button?.copyWith(
            color: isDisabledTextColor(disable: disabled, color: textColor),
          ),
        ),
      );
    }
  }

  Color? isDisabledColor({bool disable = false, Color? color}) {
    return disable ? disableColor : color;
  }

  Color? isDisabledTextColor({bool disable = false, Color? color}) {
    return disable ? disableTextColor : color;
  }
}
