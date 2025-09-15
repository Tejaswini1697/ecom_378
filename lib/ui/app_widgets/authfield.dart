import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hint;
  final TextInputType keyboard;
  final bool isPassword;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboard = TextInputType.text,
    this.isPassword = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscure : false,
        keyboardType: widget.keyboard,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon:
                      Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : null,
        ),
      ),
    );
  }
}
