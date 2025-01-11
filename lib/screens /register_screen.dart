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
      backgroundColor: Color(0xFFFFE5B4),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register",
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
              StreamBuilder<String>(
                stream: bloc.registerFullName,
                builder: (context, snapshot) => TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Full Name',
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon:
                        Icon(Icons.person_outlined, color: Colors.indigo),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) => bloc.changeFullName,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<String>(
                stream: bloc.registerEmail,
                builder: (context, snapshot) => TextField(
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
                  onChanged: (value) => bloc.changeRegisterEmail,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<String>(
                  stream: bloc.registerPassword,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: isVisible ? false : true,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                        suffix: IconButton(
                          icon: isVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          padding: EdgeInsets.all(0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (value) => bloc.changeRegisterPassword,
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<String>(
                stream: bloc.registerConfirmPassword,
                builder: (context, snapshot) => TextField(
                  obscureText: isVisible ? false : true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                    suffix: IconButton(
                      
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: isVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) => bloc.changeConfirmPassword,
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
                        text: "Already have an Account? ",
                      ),
                      TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // TODO: Add functionality for successful form validation
          print("Email: ${_emailController.text}");
          print("Password: ${_passwordController.text}");
        } else {
          print("Form validation failed");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
        minimumSize: Size(200, 50),
      ),
      child: Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
