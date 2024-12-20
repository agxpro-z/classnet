import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../../i18n/strings.g.dart';
import '../../../app.locator.dart';
import '../register/register_view.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<LoginViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<LoginViewModel>(),
      builder: (BuildContext context, LoginViewModel viewModel, Widget? child) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                t.appName,
                style: GoogleFonts.lilitaOne(
                  fontSize: theme.textTheme.displayMedium?.fontSize,
                  height: 0.0,
                ),
              ),
              Text(
                t.appDesc,
                style: TextStyle(
                  fontSize: theme.textTheme.labelSmall?.fontSize,
                ),
              ),
              const SizedBox(height: 48.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        t.loginView.signIn,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: theme.textTheme.headlineSmall?.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: viewModel.emailController,
                      decoration: InputDecoration(
                        labelText: t.loginView.email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          gapPadding: 8.0,
                        ),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: viewModel.passwordController,
                      decoration: InputDecoration(
                        labelText: t.loginView.password,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          gapPadding: 8.0,
                        ),
                        isDense: true,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 32.0,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          t.loginView.forgotPassword,
                          style: TextStyle(fontSize: theme.textTheme.labelMedium?.fontSize),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const RegisterPage();
                            }));
                          },
                          child: Text(
                            t.loginView.createAccount,
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        FilledButton(
                          onPressed: () => viewModel.signIn(),
                          child: Text(
                            t.loginView.logIn,
                            style: TextStyle(color: theme.colorScheme.onPrimary),
                          ),
                        ),
                        const SizedBox(width: 2.0)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
