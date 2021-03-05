import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller.dart';
import 'country.dart';
import 'country_dialog.dart';

class PhoneNumberField extends StatefulWidget {
  PhoneNumberField({
    Key? key,
    this.decoration = const InputDecoration(),
    this.style,
    this.countryCodeWidth = 135,
    this.controller,
  }) : super(key: key);

  /// Input decoration to customize input.
  final InputDecoration decoration;

  /// Editing controller that stores current state of the widget.
  final PhoneNumberEditingController? controller;

  /// Text font style
  final TextStyle? style;

  /// Width of the country code section
  final double countryCodeWidth;

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  bool _countryCodeFocused = false;
  PhoneNumberEditingController? _controller;
  final _hiddenText = TextStyle(
    color: Colors.transparent,
    height: 0,
    fontSize: 0,
  );

  PhoneNumberEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  Future<void> onChangeCountry() async {
    _countryCodeFocused = true;
    try {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountryDialog(),
        ),
      );
      if (country != null) {
        _effectiveController!.country = country;
      }
    } finally {
      _countryCodeFocused = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    if (widget.controller == null) {
      _controller = PhoneNumberEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.style ?? Theme.of(context).textTheme.bodyText1;

    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        counterStyle: widget.decoration.counterStyle,
        errorStyle: widget.decoration.errorStyle,
        labelStyle: widget.decoration.labelStyle,
        helperStyle: widget.decoration.helperStyle,
        errorText: widget.decoration.errorText,
        helperText: widget.decoration.helperText,
        labelText: widget.decoration.labelText,
        counterText: widget.decoration.counterText,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: widget.countryCodeWidth,
            margin: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: onChangeCountry,
              child: ValueListenableBuilder<Country?>(
                valueListenable: _effectiveController!.countryNotifier,
                builder: (context, value, child) => InputDecorator(
                  expands: false,
                  textAlignVertical: TextAlignVertical.center,
                  isFocused: _countryCodeFocused,
                  decoration: widget.decoration.copyWith(
                    hintText: '',
                    errorStyle: _hiddenText,
                    helperStyle: _hiddenText,
                    counterStyle: _hiddenText,
                    labelStyle: _hiddenText,
                    counterText: null,
                    prefixIcon: value == null
                        ? null
                        : Image.network(
                            'https://www.countryflags.io/${value.code}/flat/24.png',
                            width: 24,
                            height: 24,
                          ),
                    prefix: null,
                    prefixText: null,
                    suffixIcon: null,
                    suffixText: null,
                    suffix: null,
                  ),
                  child: Text(
                    value != null ? '+${value.prefix}' : '+',
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Country?>(
              valueListenable: _effectiveController!.countryNotifier,
              builder: (context, value, child) => TextField(
                controller: _effectiveController!.nationalNumberController,
                style: textStyle,
                decoration: widget.decoration.copyWith(
                  errorStyle: _hiddenText,
                  helperStyle: _hiddenText,
                  counterStyle: _hiddenText,
                  labelStyle: _hiddenText,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: value?.length.maxLength ?? 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
