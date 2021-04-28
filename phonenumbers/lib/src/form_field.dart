import 'package:flutter/material.dart';
import 'package:phonenumbers_core/core.dart';

import 'controller.dart';
import 'field.dart';

class PhoneNumberFormField extends FormField<PhoneNumber> {
  PhoneNumberFormField({
    Key? key,
    this.controller,
    InputDecoration decoration = const InputDecoration(),
    TextStyle? style,
    double countryCodeWidth = 135,
    String errorMessage = 'Invalid phone number',
    PhoneNumber? initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          autovalidateMode: autovalidateMode,
          initialValue: controller != null
              ? controller.value
              : (initialValue ?? PhoneNumber.empty),
          validator: (value) {
            if (value?.isValid == true) return null;
            return errorMessage;
          },
          builder: (field) {
            final state = field as _PhoneNumberFormFieldState;
            return PhoneNumberField(
              style: style,
              controller: state._effectiveController,
              decoration: decoration.copyWith(errorText: field.errorText),
              countryCodeWidth: countryCodeWidth,
            );
          },
        );

  final PhoneNumberEditingController? controller;

  @override
  _PhoneNumberFormFieldState createState() => _PhoneNumberFormFieldState();
}

class _PhoneNumberFormFieldState extends FormFieldState<PhoneNumber> {
  PhoneNumberEditingController? _controller;

  PhoneNumberEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();
    _effectiveController!.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PhoneNumberFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            PhoneNumberEditingController(oldWidget.controller!.value!);

      if (widget.controller != null) {
        setValue(widget.controller!.value);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  PhoneNumberFormField get widget => super.widget as PhoneNumberFormField;

  @override
  void reset() {
    super.reset();
    _effectiveController!.value = widget.initialValue;
  }

  void _handleControllerChanged() {
    if (_effectiveController!.value != value)
      didChange(_effectiveController!.value);
  }
}
