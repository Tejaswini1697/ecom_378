
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_widgets/authfield.dart';
import '../app_widgets/primary_button.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final mobNo = TextEditingController();
  final pass = TextEditingController();
  final repass = TextEditingController();
  bool marketing = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                'Create Account',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),
              AuthField(hint: 'Full Name', controller: name),
              const SizedBox(height: 14),
              AuthField(
                hint: 'Email',
                keyboard: TextInputType.emailAddress,
                controller: email,
              ),
              const SizedBox(height: 14),
              AuthField(
                hint: 'Mob No',
                keyboard: TextInputType.phone,
                controller: mobNo,
              ),
              const SizedBox(height: 14),
              AuthField(hint: 'Password', controller: pass, isPassword: true),
              const SizedBox(height: 14),
              AuthField(
                hint: 'Confirm Password',
                controller: repass,
                isPassword: true,
              ),
              const SizedBox(height: 10),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoadingState) {
                    isLoading = true;
                  }

                  if (state is UserSuccessState) {
                    isLoading = false;
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registered Successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }

                  if (state is UserFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    label: isLoading ? 'Please wait...' : 'Create Account',
                    onPressed: () {
                      // TODO: validation + API
                      if (pass.text != repass.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                          ),
                        );
                        return;
                      }

                      context.read<UserBloc>().add(
                        UserRegisterEvent(
                          name: name.text,
                          email: email.text,
                          mobNo: mobNo.text,
                          password: pass.text,
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
