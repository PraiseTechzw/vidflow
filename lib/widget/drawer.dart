import 'package:flutter/material.dart';
import 'package:vidflow/constants/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.video_library,
                size: 200,
                color: grey,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: grey,
                  size: 24,
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: grey,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, '/home'); // Update with actual route
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.download,
                  color: grey,
                  size: 24,
                ),
                title: const Text(
                  "Downloads",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: grey,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, '/Downloads'); // Update with actual route
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: grey,
                  size: 24,
                ),
                title: const Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: grey,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, '/settings'); // Update with actual route
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 24),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: grey,
                size: 24,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: grey,
                ),
              ),
              onTap: () {
                // Add logout functionality here
              },
            ),
          ),
        ],
      ),
    );
  }
}
