import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/change_data/change_account_data_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_button.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

enum PermissionType {
  camera,
  gallery,
}

@RoutePage()
class AccountSettingsScreen extends StatelessWidget {
  AccountSettingsScreen({super.key});

  final _userService = getIt<UserService>();

  Future<void> _pickImage(ImageSource source) async {
    if (await _getPermission(source == ImageSource.camera ? PermissionType.camera : PermissionType.gallery) == false) {
      return;
    }
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage == null) return;
    await _uploadImage(File(returnedImage.path));
  }

  Future<void> _uploadImage(File picture) async {
    await _userService.userRepo.addPicture(picture);
  }

  Future<bool> _getPermission(PermissionType type) async {
    var status = type == PermissionType.camera ? await Permission.camera.status : await Permission.photos.status;
    if (status.isGranted) return true;
    status = type == PermissionType.camera ? await Permission.camera.request() : await Permission.photos.request();
    if (status.isGranted) return true;
    await Fluttertoast.showToast(
      msg: 'Musisz wyrazić zgodę, aby dodać ustawić zdjęcie profilowe',
      toastLength: Toast.LENGTH_SHORT,
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacje o koncie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Gap(32),
            Row(
              children: [
                SizedBox.square(
                  dimension: 100,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Dodaj zdjęcie'),
                          actions: [
                            ElevatedButton(
                              child: Text('Z aparatu'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _pickImage(ImageSource.camera);
                              },
                            ),
                            ElevatedButton(
                              child: Text('Z galerii'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: StreamBuilder<User>(
                      stream: _userService.user,
                      builder: (context, snapshot) {
                        return ClipOval(
                          child: Image.asset(
                            snapshot.data?.profilePictureUrl ?? 'assets/default_icon.jpg',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Zdjęcie profilowe'),
                    Gap(8),
                    Text(
                      maxLines: 3,
                      'Format PNG lub JPG, maksymalny rozmiar 5MB',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Gap(64),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAccountDataRoute(accountData: AccountData.username));
              },
              buttonText: 'Zmiana nazwy użytkownika',
            ),
            Gap(16),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAccountDataRoute(accountData: AccountData.email));
              },
              buttonText: 'Zmiana adresu email',
            ),
            Gap(16),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAccountDataRoute(accountData: AccountData.password));
              },
              buttonText: 'Zmiana hasła',
            ),
            Gap(16),
            ProfileButton(pressFunction: () {}, buttonText: 'Usunięcie konta'),
          ],
        ),
      ),
    );
  }
}
