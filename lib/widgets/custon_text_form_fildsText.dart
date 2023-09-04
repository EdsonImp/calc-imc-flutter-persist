import 'package:flutter/material.dart';
class CustonTextFormFieldText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  CustonTextFormFieldText({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        textAlign: TextAlign.center,
        decoration:  InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                  Radius.circular(20))),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),

        )
    );

  }
}
