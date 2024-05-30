import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class DxSearchFieldWidget extends StatelessWidget {
  const DxSearchFieldWidget(
      {super.key, required this.controller, required this.onInputChanged});

  final TextEditingController controller;
  final Function onInputChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      autocorrect: false,
      enableSuggestions: false,
      controller: controller,
      onChanged: (value) {
        onInputChanged(value);
      },
      cursorColor: DxLightScheme().getBackgroundColor(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10, top: 0, bottom: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: DxLightScheme().getBackgroundColor(),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: DxLightScheme().getBackgroundColor(),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: DxLightScheme().getBackgroundColor(),
          ),
        ),
        hintText: "Please paste your link here",
        hintStyle: TextStyle(
          color: DxLightScheme().getBackgroundColor(),
          fontSize: 15,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        ),
      ),
      style: TextStyle(
        decoration: TextDecoration.none,
        color: DxLightScheme().getBackgroundColor(),
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
