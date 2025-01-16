import 'package:authentication/bloc/register_bloc.dart';
import 'package:authentication/screens%20/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFFFFE5B4),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.indigo,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              StreamBuilder<String>(
                stream: bloc.registerFullName,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Full Name',
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon:
                          const Icon(Icons.person_outlined, color: Colors.indigo),
                      filled: true,
                      fillColor: Colors.grey[200],
                      errorText: snapshot.error?.toString(),
                    ),
                    onChanged: (value) => bloc.changeFullName(value),
                  );
                },
              ),
              const SizedBox(height: 30),
              StreamBuilder<String>(
                stream: bloc.registerEmail,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.indigo),
                      filled: true,
                      fillColor: Colors.grey[200],
                      errorText: snapshot.error?.toString(),
                    ),
                    onChanged: (value) => bloc.changeRegisterEmail(value),
                  );
                },
              ),
              const SizedBox(height: 30),
              StreamBuilder<String>(
                stream: bloc.registerPassword,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _passwordController,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.indigo),
                      suffix: IconButton(
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        padding: EdgeInsets.zero,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      errorText: snapshot.error?.toString(),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: (value) => bloc.changeRegisterPassword(value),
                  );
                },
              ),
              const SizedBox(height: 30),
              StreamBuilder<String>(
                stream: bloc.registerConfirmPassword,
                builder: (context, snapshot) {
                  return TextField(
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.indigo),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      errorText: snapshot.error?.toString(),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: (value) => bloc.changeConfirmPassword(value),
                  );
                },
              ),
              const SizedBox(height: 30),
              _buildButton(bloc),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.indigo,
                  ),
                  children: [
                    const TextSpan(
                      text: "Already have an Account? ",
                    ),
                    TextSpan(
                      text: "Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(RegisterBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.isFormValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true
              ? () {
                  if (_formKey.currentState!.validate()) {
                    bloc.register(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
            minimumSize: const Size(200, 50),
          ),
          child: const Text(
            'Register',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}