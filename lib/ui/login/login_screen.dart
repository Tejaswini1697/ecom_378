import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/constants/app_routes.dart';
import '../app_widgets/authfield.dart';
import '../app_widgets/divder.dart';
import '../app_widgets/primary_button.dart';
import '../sign_up/bloc/user_bloc.dart';
import '../sign_up/bloc/user_event.dart';
import '../sign_up/bloc/user_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool remember = true;
  bool isLoading = false;
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Login',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
               const SizedBox(height: 24),
                AuthField(
                  hint: 'Email',
                  keyboard: TextInputType.emailAddress,
                  controller: email,
                ),
                const SizedBox(height: 14),
                AuthField(hint: 'Password', controller: pass, isPassword: true),
                const SizedBox(height: 10),

                BlocConsumer<UserBloc, UserState>(
                  listenWhen: (cs, ps){
                    return isLogin;
                  },
                  buildWhen: (cs, ps){
                    return isLogin;
                  },
                  listener: (_, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                    }

                    if (state is UserSuccessState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login Successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushNamed(context, AppRoutes.dashboard);
                    }

                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error : ${state.errorMsg}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      label: isLoading ? "Please wait.." : 'Login',
                      onPressed: () {
                        isLogin = true;
                        context.read<UserBloc>().add(
                          UserLoginEvent(email: email.text, pass: pass.text),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                        isLogin = false;
                      },
                      child: Text(
                        'Sign Up',
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
      ),
    );
  }


}
