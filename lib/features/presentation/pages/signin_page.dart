
// import 'package:expense_tracker/features/data/models/signin_req_params.dart';
// import 'package:expense_tracker/features/domain/usecases/user/sign_in.dart';
// import 'package:expense_tracker/features/presentation/pages/old/home_page.dart';
// import 'package:expense_tracker/features/presentation/pages/signup_page.dart';
// import 'package:expense_tracker/features/presentation/widgets/basic_app_button.dart';
// import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_cubit.dart';
// import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_state.dart';
// import 'package:expense_tracker/locator.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SigninPage extends StatelessWidget {
//   SigninPage({super.key});

//   final TextEditingController _emailCon = TextEditingController();
//   final TextEditingController _passwordCon = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => ButtonStateCubit(),
//         child: BlocListener<ButtonStateCubit, ButtonState>(
//           listener: (context, state) {
//             if (state is ButtonSuccessState) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage ()),
//               );
//             }
//             if (state is ButtonFailureState) {
//               _showErrorSnackBar(context, state.errorMessage);
//             }
//           },
//           child: SafeArea(
//             minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _signin(),
//                   const SizedBox(height: 50),
//                   _emailField(),
//                   const SizedBox(height: 20),
//                   _password(),
//                   const SizedBox(height: 60),
//                   _loginButton(context),
//                   const SizedBox(height: 20),
//                   _signupText(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signin() {
//     return const Text(
//       'Sign In',
//       style: TextStyle(
//         color: Color(0xff2A4ECA),
//         fontWeight: FontWeight.bold,
//         fontSize: 32,
//       ),
//     );
//   }

//   Widget _emailField() {
//     return TextFormField(
//       controller: _emailCon,
//       decoration: const InputDecoration(
//         hintText: 'Email',
//         border: OutlineInputBorder(),
//       ),
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your email';
//         }
//         // Add regex for email validation if needed
//         return null;
//       },
//     );
//   }

//   Widget _password() {
//     return TextFormField(
//       controller: _passwordCon,
//       decoration: const InputDecoration(
//         hintText: 'Password',
//         border: OutlineInputBorder(),
//       ),
//       obscureText: true,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your password';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _loginButton(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         return BasicAppButton(
//           title: 'Login',
//           onPressed: () {
//             if (_formKey.currentState?.validate() ?? false) {
//               context.read<ButtonStateCubit>().excute(
//                     usecase: sl<SigninUseCase>(),
//                     params: SigninReqParams(
//                       email: _emailCon.text,
//                       password: _passwordCon.text,
//                     ),
//                   );
//             }
//           },
//         );
//       },
//     );
//   }

//   Widget _signupText(BuildContext context) {
//     return Text.rich(
//       TextSpan(
//         children: [
//           const TextSpan(
//             text: "Don't have an account? ",
//             style: TextStyle(
//               color: Color(0xff3B4054),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           TextSpan(
//             text: 'Sign Up',
//             style: const TextStyle(
//               color: Color(0xff3461FD),
//               fontWeight: FontWeight.w500,
//             ),
//             recognizer: TapGestureRecognizer()
//               ..onTap = () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignupPage()),
//                 );
//               },
//           ),
//         ],
//       ),
//     );
//   }

//   void _showErrorSnackBar(BuildContext context, String errorMessage) {
//     final snackBar = SnackBar(content: Text(errorMessage));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
