import 'package:flutter/material.dart';
import 'package:rpg_story/Pages/HomePage.dart';
import 'package:rpg_story/Services/auth_service.dart';
import 'package:rpg_story/Utils/Constants.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B3B3B),
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/main_logo.png')),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    focusColor: SECONDARY_COLOR,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: SECONDARY_COLOR, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PRIMARY_COLOR.withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: SECONDARY_COLOR.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    focusColor: SECONDARY_COLOR,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: SECONDARY_COLOR, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PRIMARY_COLOR.withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: SECONDARY_COLOR.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required';
                    }
                    if (val.length < 6) {
                      return '6 characters minimum';
                    }
                    return null;
                  },
                ),
                GAP_H_16,
                TextFormField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    focusColor: SECONDARY_COLOR,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: SECONDARY_COLOR, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PRIMARY_COLOR.withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: SECONDARY_COLOR.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required';
                    }
                    final isValid =
                        RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                    if (!isValid) {
                      return '3-24 long with alphanumeric or underscore';
                    }
                    return null;
                  },
                ),
                GAP_H_32,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      final message = await AuthService().registration(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                      );
                      if (message!.contains('Success')) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    username: _usernameController.text,
                                  )),
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Colors.black),
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
