import 'package:flutter/material.dart';

import '../theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State from React component
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  String language = 'English';

  // Computed properties for styling based on dark mode state
  Color get backgroundColor =>
      isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
  Color get surfaceColor => isDarkMode ? Colors.grey[800]! : Colors.white;
  Color get textColor => isDarkMode ? Colors.white : Colors.grey[900]!;
  Color get secondaryTextColor => Colors.grey[500]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // SafeArea to prevent content from going under status bar
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor), // Back button color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 8),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 32),

              // Appearance Section
              _buildSectionHeader('Appearance'),
              const SizedBox(height: 12),
              _buildCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode, // Moon / Sun
                          size: 20,
                          color: textColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    // Custom styled switch to match the React design roughly
                    Switch.adaptive(
                      value: isDarkMode,
                      thumbColor: WidgetStateProperty.all(Colors.blue[600]),
                      onChanged: (value) {
                        ThemeNotifier.toggleTheme(value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Localization Section (Preferences)
              _buildSectionHeader('Preferences'),
              const SizedBox(height: 12),
              _buildCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language, // Globe
                          size: 20,
                          color: textColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Language',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    // Language Dropdown
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: language,
                        dropdownColor: surfaceColor,
                        icon:
                            Container(), // Hiding default icon to match clean look or add custom if needed
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[600],
                        ),
                        items: ['English', 'Spanish', 'French'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              language = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Account Actions
              // Log Out Button
              _buildCard(
                onTap: () {
                  // Handle logout logic
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: isDarkMode
                              ? Colors.grey[200]
                              : Colors.grey[700],
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.grey[200]
                                : Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[400],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Delete Account Button (Red style)
              Material(
                color: isDarkMode
                    ? const Color(0xFF3F1212)
                    : Colors.red[50], // dark:bg-red-900/20 approx

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDarkMode
                        ? const Color(0x7F7F1D1D)
                        : Colors.red[100]!,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle delete account logic
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Colors.red[600],
                        ), // Trash2
                        const SizedBox(width: 12),
                        Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for section headers
  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: secondaryTextColor,
        letterSpacing: 0.5,
      ),
    );
  }

  // Helper widget for card-style items
  Widget _buildCard({required Widget child, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
        ),
      ),
    );
  }
}
