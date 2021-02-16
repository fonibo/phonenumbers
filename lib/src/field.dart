import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller.dart';
import 'country.dart';
import 'country_dialog.dart';

class PhoneNumberField extends StatefulWidget {
  PhoneNumberField({
    Key key,
    this.decoration = const InputDecoration(),
    this.style,
    this.countryCodeWidth = 135,
    PhoneNumberEditingController controller,
  })  : this.controller = controller ?? PhoneNumberEditingController(),
        this._selfControlled = controller == null,
        assert(countryCodeWidth != null),
        super(key: key);

  final InputDecoration decoration;
  final PhoneNumberEditingController controller;
  final TextStyle style;
  final double countryCodeWidth;

  final bool _selfControlled;

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  bool _countryCodeFocused = false;

  Future<void> onChangeCountry() async {
    _countryCodeFocused = true;
    try {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountryDialog(),
        ),
      );
      print(country);
      if (country != null) {
        widget.controller.country = country;
      }
    } finally {
      _countryCodeFocused = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    if (widget._selfControlled) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.style ?? Theme.of(context).textTheme.bodyText1;

    return Row(
      children: <Widget>[
        Container(
          width: widget.countryCodeWidth,
          margin: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: onChangeCountry,
            child: ValueListenableBuilder<Country>(
              valueListenable: widget.controller.countryListener,
              builder: (context, value, child) => InputDecorator(
                expands: false,
                textAlignVertical: TextAlignVertical.center,
                isFocused: _countryCodeFocused,
                decoration: widget.decoration.copyWith(
                  labelText: null,
                  helperText: null,
                  hintText: null,
                  errorText: null,
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
          child: ValueListenableBuilder<Country>(
            valueListenable: widget.controller.countryListener,
            builder: (context, value, child) => TextField(
              controller: widget.controller.nationalNumberController,
              style: textStyle,
              decoration: widget.decoration.copyWith(counterText: ''),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: value?.length?.maxLength ?? 15,
            ),
          ),
        ),
      ],
    );
  }
}
