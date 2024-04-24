import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../i18n/strings.g.dart';
import '../../../services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _branchController = TextEditingController();
  final _courseController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: theme.colorScheme.secondaryContainer,
      ),
      // backgroundColor: theme.colorScheme.secondaryContainer,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Header
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            t.registerView.signUp,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: theme.textTheme.headlineSmall?.fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),

                        // Full name text field
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: t.registerView.name,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12.0),

                        // Username text field
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: t.registerView.email,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12.0),

                        // Password text field
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: t.registerView.password,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                            isDense: true,
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 12.0),

                        // Confirm password text field
                        TextField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: t.registerView.confirmPassword,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                            isDense: true,
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // Login button
                            FilledButton(
                              onPressed: () {
                                Auth.signUp(
                                  context,
                                  _nameController.text.trim(),
                                  _branchController.text.trim(),
                                  _courseController.text.trim(),
                                  _emailController.text.trim(),
                                  _passwordController.text,
                                  _confirmPasswordController.text,
                                );
                              },
                              child: Text(
                                t.registerView.signUp,
                                style: TextStyle(color: theme.colorScheme.onPrimary),
                              ),
                            ),
                            const SizedBox(width: 2.0)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
