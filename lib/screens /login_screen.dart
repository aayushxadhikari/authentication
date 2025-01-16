import 'package:authentication/bloc/login_bloc.dart';
import 'package:authentication/screens%20/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFFFE5B4),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.indigo,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<Object>(
                stream: bloc.loginEmail,
                builder: (context, snapshot) => TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    labelText: "Email",
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.indigo),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) => bloc.changeLoginEmail,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<Object>(
                stream: bloc.loginPassword,
                builder: (context, snapshot) => TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) => bloc.changeLoginPassword,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _buildButton(),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                    children: [
                      TextSpan(
                        text: "Need an Account? ",
                      ),
                      TextSpan(
                        text: "Register",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                          },
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<Object>(
      stream: bloc.isValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        );
      }
    );
  }
}
