import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../controllers/profile_controller.dart';
import 'store_details.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfilePage();
  }
}

class _ProfilePage extends StatelessWidget {
  _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, state, child) {
        final colors = Theme.of(context).colorScheme;
        final l10n = AppLocalizations.of(context)!;

        return Scaffold(
          backgroundColor: colors.surface,
          appBar: AppBar(
            title: Text(
              l10n.profileTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 120,
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: state.imagePath != null
                            ? ClipOval(
                                child: Image.file(
                                  File(state.imagePath!),
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Text(
                                state.getFirstWord(),
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diogo Bernardo Maraschi',
                            style: TextStyle(fontSize: 18, fontWeight: .w500),
                          ),

                          SizedBox(height: 7),
                          Text(
                            'CNPJ: 21.601,949/0001-47',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                l10n.profilePreferences,
                style: TextStyle(fontSize: 18, fontWeight: .w500),
              ),

              SizedBox(height: 10),

              Material(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(l10n.profileStoreInformation),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => StoreDetailsPage()),
                        );
                      },
                    ),
                    SwitchListTile(
                      title: Text(l10n.profileDarkMode),
                      value: state.isDark,
                      onChanged: state.setDarkMode,
                      activeColor: colors.primary,
                    ),
                    ListTile(
                      title: Text(l10n.profileLanguage),
                      subtitle: Text(state.locale!.languageCode),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('Português'),
                                    onTap: () async {
                                      await state.setLanguage('pt');
                                      if (!context.mounted) return;
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('English'),
                                    onTap: () async {
                                      await state.setLanguage('en');
                                      if (!context.mounted) return;
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Español'),
                                    onTap: () async {
                                      await state.setLanguage('es');
                                      if (!context.mounted) return;
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
