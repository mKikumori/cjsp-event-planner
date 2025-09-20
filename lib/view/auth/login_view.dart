import 'package:event_planner/view/auth/password_reset_view.dart';
import 'package:event_planner/view/auth/register_view.dart';
import 'package:event_planner/view_model/auth/login_viewmodel.dart';
import 'package:event_planner/view_model/auth/password_reset_viewmodel.dart';
import 'package:event_planner/widgets/background_widget.dart';
import 'package:event_planner/widgets/custom_button.dart';
import 'package:event_planner/widgets/custom_textfield_widget.dart';
import 'package:event_planner/widgets/logo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return BackgroundWidget(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              LogoTitleWidget(),
              const SizedBox(height: 8),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.white,
                ),
              ),
              const SizedBox(height: 32),

              // Email Field
              CustomTextfieldWidget(
                text: "Email",
                controller: loginViewModel.emailController,
              ),
              const SizedBox(height: 16),

              // Password Field
              CustomTextPswfield(
                text: "Password",
                controller: loginViewModel.passwordController,
              ),
              const SizedBox(height: 16),

              // Sign In Button
              CustomButtonWidget(
                text: "Sign In",
                width: MediaQuery.of(context).size.width * 0.8,
                accent: true,
                onPressed: () async {
                  await loginViewModel.signIn(context);

                  if (loginViewModel.errorMessage != null) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("Login Failed"),
                          content: Text(loginViewModel.errorMessage!),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),

              if (loginViewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CupertinoActivityIndicator(),
                ),

              const SizedBox(height: 16),

              // Create New Account Button
              CustomButtonWidget(
                text: "Create New Account",
                width: MediaQuery.of(context).size.width * 0.8,
                nextPage: const RegisterView(),
              ),

              const SizedBox(height: 16),

              // Forgot Password Button
              CustomTransparentButton(
                text: "Forgot Password",
                width: MediaQuery.of(context).size.width * 0.8,
                nextPage: ChangeNotifierProvider(
                  create: (_) => PasswordResetViewModel(),
                  child: const PasswordResetView(),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
