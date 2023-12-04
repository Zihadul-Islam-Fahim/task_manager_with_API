import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:task_manager_1/Controller/authController.dart';
import 'package:task_manager_1/Screens/EditProfile.dart';
import 'package:task_manager_1/Screens/LogInScreen.dart';

class ProfileSummeryCard extends StatefulWidget {
  const ProfileSummeryCard({super.key, this.ignoreOnTap = true});

  final bool ignoreOnTap;

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  @override
  Widget build(BuildContext context) {
    String base64String = AuthController.user!.photo ?? '';

    if (base64String.startsWith('data:image')) {
      // Remove data URI prefix if present
      base64String =
          base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    }

    Uint8List imageBytes = const Base64Decoder().convert(base64String);

    return ListTile(
      onTap: () {
        if (widget.ignoreOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(
                user: AuthController.user,
              ),
            ),
          );
        }
      },
      tileColor: Colors.green,
      leading: CircleAvatar(
        child: AuthController.user!.photo == null
            ? const Icon(Icons.person)
            : ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
      ),
      title: Text(
        fullname,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
      trailing: IconButton(
          onPressed: () {
            ShowModalforLogout();
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          )),
    );
  }

  String get fullname {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }

  ShowModalforLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout !!!'),
          content: const Text('Are You want to Logout?'),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    )),
                TextButton(
                  onPressed: () async {
                    await AuthController.clearAuthData();
                    if (mounted) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInScreen(),
                          ),
                          (route) => false);
                    }
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
