import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  const DashboardScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: DashboardDrawer(onThemeChanged: onThemeChanged),
      body: Builder(
        // Use Builder to provide a new context for opening/closing the drawer
        builder: (context) => Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Analytics Overview'),
                  // Dummy image placeholder
                  Image.asset(
                    'lib/images/Chart.png',
                  ),
                  const SizedBox(height: 20),
                  const Text('Hover over the left to view account settings'),
                ],
              ),
            ),
            // Hover area to open the drawer
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 150, // Wider hover area for convenience
              child: MouseRegion(
                onEnter: (_) {
                  // Open the drawer when hovering over the left side
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Scaffold.of(context).openDrawer();
                  });
                },
                child: Container(
                  color: Colors.transparent, // Invisible hover region
                ),
              ),
            ),
            // Hover area to close the drawer when moving to the right or out of the active area
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width *
                  0.8, // Covers most of the right side of the screen
              child: MouseRegion(
                onEnter: (_) {
                  // Close the drawer if it's open when hovering to the right side
                  if (Scaffold.of(context).isDrawerOpen) {
                    Scaffold.of(context).closeDrawer(); // Close the drawer
                  }
                },
                child: Container(
                  color: Colors.transparent, // Invisible hover region
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardDrawer extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  const DashboardDrawer({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                // Replace with your logo path
                Image.asset(
                  'lib/images/codebridge_logo.png',
                  height: 50,
                ),
                const Text('Admin Settings', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          ListTile(
            title: const Text('Toggle Dark Mode'),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                onThemeChanged(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Account Settings'),
            onTap: () {
              // Navigate to account settings
            },
          ),
                    ListTile(
            title: const Text('Users '),
            onTap: () {
              // Navigate to Set up
              Navigator.pushNamed(context, "/users");
            },
          ),
          ListTile(
            title: const Text('Set Up '),
            onTap: () {
              // Navigate to Set up
              Navigator.pushNamed(context, "/setup");
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              // Log out functionality
            },
          ),
        ],
      ),
    );
  }
}
