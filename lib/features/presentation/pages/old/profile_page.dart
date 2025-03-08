import 'package:expense_tracker/features/presentation/blocs/profile/Profile_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/profile/profile_event.dart';
// import 'package:expense_tracker/features/presentation/blocs/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(""),
            ),
            SizedBox(height: 10),
            Text("sjkfdsakjfdslkjfsds",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("sdjkfdasjkkjldsaf",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),

            // Budget Summary
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Expenses:", style: TextStyle(fontSize: 16)),
                        Text("\$4000",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Monthly Budget:", style: TextStyle(fontSize: 16)),
                        Text("\10000",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                _showEditProfileDialog(
                    context, "hellow ", "gyansinghrajbansi1@gmail.com");
              },
              child: Text("Edit Profile"),
            ),
            SizedBox(height: 10),

            // Logout Button
            TextButton(
              onPressed: () {
                BlocProvider.of<ProfileBloc>(context).add(LogoutUser());
              },
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  // Edit Profile Dialog
  void _showEditProfileDialog(BuildContext context, String name, String email) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // BlocProvider.of<ProfileBloc>(context).add(
                //   UpdateProfile(
                //       name: nameController.text, email: emailController.text),
                // );
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
