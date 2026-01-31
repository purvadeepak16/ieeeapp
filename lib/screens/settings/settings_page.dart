import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile_page.dart';
import 'language_page.dart';
import 'notification_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsOn = true;
  bool isDarkMode = true;
  String selectedLanguage = 'English (UK)';

  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  // ===== COLOR SYSTEM (MATCHES HOME PAGE) =====
  static const _darkBg = Color(0xFF0F1216);
  static const _darkCard = Color(0xFF1A1F26);
  static const _darkText = Color(0xFFE6E9EE);
  static const _darkSubText = Color(0xFF9AA4AF);
  static const _darkDivider = Color(0xFF2A2F36);

  static const _lightBg = Color(0xFFF4F6F8);
  static const _lightCard = Colors.white;
  static const _lightText = Color(0xFF1C1E21);
  static const _lightSubText = Color(0xFF5F6B7A);
  static const _lightDivider = Color(0xFFE0E3E7);

  static const _accentBlue = Color(0xFF1F6BFF);

  Color get bgColor => isDarkMode ? _darkBg : _lightBg;
  Color get cardColor => isDarkMode ? _darkCard : _lightCard;
  Color get textColor => isDarkMode ? _darkText : _lightText;
  Color get subTextColor => isDarkMode ? _darkSubText : _lightSubText;
  Color get dividerColor => isDarkMode ? _darkDivider : _lightDivider;

  Future<void> _pickAvatar() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _avatarImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'USER PROFILE',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== HEADER =====
            Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDarkMode
                      ? const [_darkBg, _darkCard]
                      : const [Color(0xFFE9EDF2), Color(0xFFF7F9FB)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickAvatar,
                        child: CircleAvatar(
                          radius: 72,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 68,
                            backgroundImage: _avatarImage != null
                                ? FileImage(_avatarImage!)
                                : const AssetImage(
                                'assets/images/avatar.png')
                            as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: _pickAvatar,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _accentBlue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'USER',
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'youremail@domain.com | +91 XXXXXXXX',
                    style: TextStyle(color: subTextColor, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== MAIN SETTINGS CARD =====
            _card(
              Column(
                children: [
                  _tile(
                    Icons.badge_outlined,
                    'Edit profile information',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfilePage()),
                      );
                    },
                  ),
                  _divider(),
                  _tile(
                    Icons.notifications,
                    'Notifications',
                    trailing: Switch(
                      value: notificationsOn,
                      activeColor: _accentBlue,
                      onChanged: (v) =>
                          setState(() => notificationsOn = v),
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationPage()),
                      );
                      if (result != null) {
                        setState(() {
                          notificationsOn = result['general'];
                        });
                      }
                    },
                  ),
                  _divider(),
                  _tile(
                    Icons.translate,
                    'Language',
                    trailing: Text(selectedLanguage,
                        style: TextStyle(color: subTextColor)),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LanguagePage()),
                      );
                      if (result != null) {
                        setState(() => selectedLanguage = result);
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== THEME =====
            _card(
              ListTile(
                leading: Icon(Icons.palette, color: _accentBlue),
                title:
                Text('Theme', style: TextStyle(color: textColor)),
                trailing: DropdownButton<bool>(
                  value: isDarkMode,
                  underline: const SizedBox(),
                  dropdownColor: cardColor,
                  items: const [
                    DropdownMenuItem(
                        value: false, child: Text('Light mode')),
                    DropdownMenuItem(
                        value: true, child: Text('Dark mode')),
                  ],
                  onChanged: (v) => setState(() => isDarkMode = v!),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== LOGOUT =====
            _card(
              const ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title:
                Text('Log out', style: TextStyle(color: Colors.red)),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _card(Widget child) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: dividerColor),
    ),
    child: child,
  );

  Widget _divider() => Divider(color: dividerColor);

  Widget _tile(
      IconData icon,
      String text, {
        Widget? trailing,
        VoidCallback? onTap,
      }) =>
      ListTile(
        leading: Icon(icon, color: _accentBlue),
        title: Text(text, style: TextStyle(color: textColor)),
        trailing: trailing ??
            Icon(Icons.chevron_right, color: subTextColor),
        onTap: onTap,
      );
}
