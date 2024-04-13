import 'package:flutter/material.dart';

import '../../../../res/strings.dart';
import '../../../services/auth.dart';
import '../register/register_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.secondaryContainer,
      body: SafeArea(
        child: Center(
          child: Card(
            color: theme.colorScheme.background,
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Header
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      Strings.signInHeader,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: theme.textTheme.headlineMedium?.fontSize,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Username text field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: Strings.email,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        gapPadding: 8.0
                      ),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Password text field
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: Strings.password,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          gapPadding: 8.0
                      ),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),

                  // Forgot password
                  SizedBox(
                    height: 32.0,
                    child: TextButton(
                      onPressed: () { },
                      child: Text(
                        Strings.forgotPassword,
                        style: TextStyle(
                          fontSize: theme.textTheme.labelMedium?.fontSize
                        ),
                      ),
                     ),
                  ),
                  // const SizedBox(height: 8.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Create account button
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return const RegisterPage();
                          }));
                        },
                        child: Text(
                          Strings.createAccount,
                          style: TextStyle(
                            color: theme.colorScheme.primary
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),

                      // Login button
                      FilledButton(
                        onPressed: () {
                          Auth.signIn(_emailController.text.trim(), _passwordController.text);
                        },
                        child: Text(
                          Strings.login,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary
                          ),
                        ),
                      ),
                      const SizedBox(width: 2.0)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
