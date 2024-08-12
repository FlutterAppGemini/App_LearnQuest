import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/common/providers/locale_provider.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkTheme = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
    });
    Navigator.pushNamedAndRemoveUntil(context, Routes.auth, (routes) => false);
  }

  void _changeLanguage(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale.languageCode;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).language_option),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: currentLocale,
                onChanged: (String? value) {
                  localeProvider.setLocale(const Locale('en'), context);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Español'),
                value: 'es',
                groupValue: currentLocale,
                onChanged: (String? value) {
                  localeProvider.setLocale(const Locale('es'), context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkTheme ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.deepPurpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: _user != null
                            ? Colors.transparent
                            : Colors.purple.shade100,
                        backgroundImage: _user != null
                            ? NetworkImage(_user!.photoURL ?? '')
                            : null,
                        child: _user != null
                            ? null
                            : const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.deepPurpleAccent,
                              ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _user != null
                                ? _user!.displayName ?? ''
                                : S.of(context).user_name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _user != null ? _user!.email ?? '' : '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      if (_user == null) const Spacer(),
                      if (_user == null)
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.auth,
                              (routes) => false,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).preferences_label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSettingOption(
                    S.of(context).language_option,
                    Icons.language,
                    trailing: Text(S.of(context).idiom_text),
                    onTap: () => _changeLanguage(context),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    S.of(context).account_label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSettingOption(
                    S.of(context).help_option,
                    Icons.help_outline,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.faq);
                    },
                  ),
                  if (_user != null)
                    _buildSettingOption(
                        S.of(context).logout_option, Icons.logout,
                        onTap: () => _logout(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(String title, IconData icon,
      {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(title),
      trailing:
          trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
