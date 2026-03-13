import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_loader.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              TextFormField(
                controller: emailController,
                decoration:
                const InputDecoration(labelText: "Email"),
                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }

                  if (!value.contains("@")) {
                    return "Enter valid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration:
                const InputDecoration(labelText: "Password"),
                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              authProvider.isLoading
                  ? const AppLoader()
                  : SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () async {

                    if (!formKey.currentState!
                        .validate()) {
                      return;
                    }

                    final error =
                    await authProvider.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (error != null) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(content: Text(error)),
                      );

                    } else {

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const HomeScreen(),
                        ),
                      );
                    }
                  },

                  child: const Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}