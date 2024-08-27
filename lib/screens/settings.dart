import 'package:flutter/material.dart';
import 'package:vidflow/constants/colors.dart';
import 'package:vidflow/main.dart';
import 'package:vidflow/themes/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedTheme = 'Light';
  final List<String> _themes = [
    'Light',
    'Dark',
    'Blue',
    'Green',
    'Red',
  ];

  void _changeTheme(String theme) {
    ThemeData newTheme;
    switch (theme) {
      case 'Blue':
        newTheme = blueTheme;
        break;
      case 'Green':
        newTheme = greenTheme;
        break;
      case 'Red':
        newTheme = redTheme;
        break;
      case 'Dark':
        newTheme = darkTheme;
        break;
      case 'Light':
      default:
        newTheme = lightTheme;
    }
    setState(() {
      _selectedTheme = theme;
    });
    // Apply the new theme
    MyApp.of(context)!.changeTheme(newTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "App Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6, color: Colors.blue),
            title: const Text("Theme"),
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              items: _themes.map((String theme) {
                return DropdownMenuItem<String>(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeTheme(newValue);
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.high_quality, color: Colors.blue),
            title: const Text("Downloading Quality Format"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Select Downloading Quality",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("High Quality"),
                          onTap: () {
                            // Handle high quality selection
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Medium Quality"),
                          onTap: () {
                            // Handle medium quality selection
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Low Quality"),
                          onTap: () {
                            // Handle low quality selection
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.support, color: Colors.blue),
            title: const Text("Support Us"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Support Us"),
                    content: const Text(
                        "If you enjoy using this app, please consider supporting us to keep the project going."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.feedback, color: Colors.blue),
            title: const Text("Feedback"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Feedback"),
                    content: const TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Enter your feedback here...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Handle feedback submission
                          Navigator.pop(context);
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.blue),
            title: const Text("Follow Us"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Follow Us"),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.facebook),
                          onPressed: () async {},
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.twitter),
                          onPressed: () async {
                            const url = 'https://www.twitter.com/';
                          },
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.instagram),
                          onPressed: () async {
                            const url = 'https://www.instagram.com/';
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text("About Me"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "VidFlow",
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(Icons.video_library),
                children: [
                  const Text(
                      "Praise Masunga is a university student at Chinhoyi University of Technology doing a BSIT degree."),
                ],
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_cafe, color: Colors.blue),
            title: const Text("Buy Me a Coffee"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Buy Me a Coffee"),
                    content: const Text(
                        "If you find this app useful, you can support me by buying me a coffee!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}
