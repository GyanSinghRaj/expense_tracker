import 'package:expense_tracker/features/user/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRememberPassword = false;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      print(_usernameController.text);
      print(_passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/loginback.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 39, 36, 36),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 18),
                              filled: true,
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 18),
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isRememberPassword,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        isRememberPassword = newValue!;
                                      });
                                    },
                                    activeColor:
                                        Colors.blue, // Color when checked
                                    checkColor: Colors.white, // Checkmark color
                                  ),
                                  Text(
                                    'Remember Me',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: _login,
                                  child: const Text('Forgot Password?',
                                      style: TextStyle(
                                          color: Colors.amber, fontSize: 12))),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 32)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Login',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Align(
                                    child: Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Center horizontally
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Center vertically
                              children: [
                                Text(
                                  "Don't have an Account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up?',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
