import 'package:flutter/material.dart';
import '../constants/ag_colors.dart';
import '../constants/ag_effects.dart';
import 'ag_glass_container.dart';

/// AGGlassTextField - Glass Input Field with Frosted Effect
/// Input field with blur background, gradient border, and glow on focus
class AGGlassTextField extends StatefulWidget {
  const AGGlassTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.blurIntensity,
    this.borderRadius,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final int maxLines;
  final double? blurIntensity;
  final double? borderRadius;

  @override
  State<AGGlassTextField> createState() => _AGGlassTextFieldState();
}

class _AGGlassTextFieldState extends State<AGGlassTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveRadius = widget.borderRadius ?? AGEffects.radiusMedium;
    final effectiveBlur = widget.blurIntensity ?? AGEffects.blurLight;

    // Determine border color based on focus state
    Color borderColor;
    double borderWidth;
    List<BoxShadow>? focusShadow;

    if (!widget.enabled) {
      borderColor = theme.disabledColor.withOpacity(0.2);
      borderWidth = 1.0;
    } else if (_isFocused) {
      borderColor = AGColors.glassPrimary;
      borderWidth = 2.0;
      focusShadow = AGEffects.getFocusGlow(
        glowColor: AGColors.glassPrimary,
        intensity: 0.3,
      );
    } else {
      borderColor = AGColors.getGlassBorder(theme.brightness, opacity: 0.3);
      borderWidth = 1.0;
    }

    return AGGlassContainer(
      blurIntensity: effectiveBlur,
      borderRadius: effectiveRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      floatingShadow: false,
      enableGlassEffect: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: focusShadow,
        ),
        child: TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: widget.maxLines > 1 ? 16 : 14,
            ),
            labelStyle: TextStyle(
              color: _isFocused ? AGColors.glassPrimary : theme.hintColor,
            ),
            hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}
