import 'package:flutter/material.dart';

class SecurityPrivacyPage extends StatefulWidget {
  const SecurityPrivacyPage({super.key});

  @override
  State<SecurityPrivacyPage> createState() => _SecurityPrivacyPageState();
}

class _SecurityPrivacyPageState extends State<SecurityPrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            child: Text(
          "Security & Privacy",
          style: TextStyle(),
        )),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("App Lock"),
            subtitle: Text("PIN, Finger Print and Face ID"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
