import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsureText;
  final bool isPasswordType;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsureText,
    required this.isPasswordType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool checkObscureText;
  @override
  void initState() {
    checkObscureText = widget.obsureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      obscureText: checkObscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordType
            ? IconButton(
                icon: checkObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () => setState(
                  () {
                    checkObscureText = !checkObscureText;
                  },
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade700),
        ),
        contentPadding: const EdgeInsets.all(12.0),
        fillColor: Colors.green.shade100,
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 14.0),
      ),
    );
  }
}
