import 'package:event_planner/view/auth/login_view.dart';
import 'package:event_planner/view/core/home_view.dart';
import 'package:event_planner/view_model/auth/registration_viewmodel.dart';
import 'package:event_planner/widgets/background_widget.dart';
import 'package:event_planner/widgets/custom_button.dart';
import 'package:event_planner/widgets/custom_textfield_widget.dart';
import 'package:event_planner/widgets/logo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);
    final nameController =
        TextEditingController(text: viewModel.firstName ?? '');
    final lastNameController =
        TextEditingController(text: viewModel.lastName ?? '');
    final emailController = TextEditingController(text: viewModel.email ?? '');
    final phoneController =
        TextEditingController(text: viewModel.phoneNumber ?? '');
    final passwordController =
        TextEditingController(text: viewModel.password ?? '');

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
                'Vamos começar...',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.white,
                ),
              ),
              if (viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    viewModel.errorMessage!,
                    style: const TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              CustomTextfieldWidget(
                text: 'Nome',
                controller: nameController,
                onChanged: viewModel.setFirstName,
              ),
              CustomTextfieldErrorWidget(error: viewModel.firstNameError),
              const SizedBox(height: 16),
              CustomTextfieldWidget(
                text: 'Sobrenome',
                controller: lastNameController,
                onChanged: viewModel.setLastName,
              ),
              CustomTextfieldErrorWidget(error: viewModel.lastNameError),
              const SizedBox(height: 16),
              CustomTextfieldWidget(
                text: 'Email',
                controller: emailController,
                onChanged: viewModel.setEmail,
              ),
              CustomTextfieldErrorWidget(error: viewModel.emailError),
              const SizedBox(height: 16),
              CustomTextfieldWidget(
                text: 'Telefone',
                controller: phoneController,
                prefix: CountryCodeSelector(),
                onChanged: viewModel.setPhoneNumber,
              ),
              CustomTextfieldErrorWidget(error: viewModel.phoneError),
              const SizedBox(height: 16),
              CustomTextPswfield(
                text: 'Senha',
                controller: passwordController,
                onChanged: viewModel.setPassword,
              ),
              CustomTextfieldErrorWidget(error: viewModel.passwordError),
              const SizedBox(height: 24),
              CustomButtonWidget(
                text: 'Continuar',
                width: MediaQuery.of(context).size.width * 0.8,
                accent: true,
                onPressed: () async {
                  final name = nameController.text.trim();
                  final lastName = lastNameController.text.trim();
                  final email = emailController.text.trim();
                  final phone = phoneController.text.trim();
                  final password = passwordController.text.trim();
                  final model = Provider.of<RegistrationViewModel>(context,
                      listen: false);

                  model.setFieldErrors(
                    firstName: name.isEmpty ? 'First name is required.' : null,
                    lastName:
                        lastName.isEmpty ? 'Last name is required.' : null,
                    email: email.isEmpty ? 'Email is required.' : null,
                    phone: phone.isEmpty ? 'Phone is required.' : null,
                    password: password.isEmpty ? 'Password is required.' : null,
                  );

                  final hasError = [
                    model.firstNameError,
                    model.lastNameError,
                    model.emailError,
                    model.phoneError,
                    model.passwordError,
                  ].any((e) => e != null);

                  if (hasError) return;

                  model.setUserInfo(
                    firstName: name,
                    lastName: lastName,
                    email: email,
                    phoneNumber: phone,
                    password: password,
                  );

                  await model.register(
                      password: model.password!, context: context);

                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const HomeView()),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButtonWidget(
                text: 'Eu já tenho uma conta',
                width: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const LoginView()),
                  );
                },
              ),
              if (viewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CupertinoActivityIndicator(),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryCodeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);
    final currentCode = viewModel.selectedCountryCode ?? '+55';

    return CupertinoButton(
      padding: const EdgeInsets.only(right: 8),
      minSize: 0,
      onPressed: () => _showCountryPicker(context, viewModel),
      child: Text(
        _countryFlag(currentCode),
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  void _showCountryPicker(BuildContext context, RegistrationViewModel model) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Choose your country'),
        actions: [
          _countryOption('🇦🇺 Australia', '+61', model, context),
          _countryOption('🇳🇿 New Zealand', '+64', model, context),
          _countryOption('🇺🇸 United States', '+1', model, context),
          _countryOption('🇬🇧 United Kingdom', '+44', model, context),
          _countryOption('🇯🇵 Japan', '+81', model, context),
          _countryOption('🇵🇭 Philippines', '+63', model, context),
          _countryOption('🇧🇷 Brazil', '+55', model, context),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => const RegisterView()),
            );
          },
        ),
      ),
    );
  }

  CupertinoActionSheetAction _countryOption(
    String label,
    String code,
    RegistrationViewModel model,
    BuildContext context,
  ) {
    return CupertinoActionSheetAction(
      child: Text(label),
      onPressed: () {
        model.setSelectedCountryCode(code);
        Navigator.pop(context);
      },
    );
  }

  String _countryFlag(String code) {
    switch (code) {
      case '+61':
        return '🇦🇺';
      case '+64':
        return '🇳🇿';
      case '+1':
        return '🇺🇸';
      case '+44':
        return '🇬🇧';
      case '+81':
        return '🇯🇵';
      case '+63':
        return '🇵🇭';
      case '+55':
        return '🇧🇷';
      default:
        return '🌐';
    }
  }
}
