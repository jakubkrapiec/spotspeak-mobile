import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/change_data/change_account_data_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_button.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

enum PermissionType {
  camera,
  gallery,
}

@RoutePage()
class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
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
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        picture.path,
        filename: picture.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    await _userService.userRepo.addPicture(formData);
    await _userService.syncUser();
  }

  Future<void> _deleteAccount() async {
    await _userService.userRepo.deleteUser();
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
                      showDialog<void>(
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
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data?.profilePictureUrl != null &&
                            snapshot.data!.profilePictureUrl!.isNotEmpty) {
                          return ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.profilePictureUrl!,
                              width: 200,
                              height: 200,
                              errorWidget: (context, url, _) => Image.asset('assets/default_icon.jpg'),
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Image.asset(
                              'assets/default_icon.jpg',
                              fit: BoxFit.cover,
                            ),
                          );
                        }
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
                      'Kliknij w zdjęcie, aby dodać nowe',
                      style: TextStyle(fontSize: 14),
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
            ProfileButton(
              pressFunction: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    alignment: Alignment.center,
                    title: Text(
                      'Usunięcie konta',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: CustomColors.red1),
                    ),
                    content: Text(
                      'Tej operacji nie można cofnąć, wszystkie dane dotyczące twojego konta zostaną usunięte. Czy na pewno chcesz usunąć konto?',
                      textAlign: TextAlign.center,
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      ElevatedButton(
                        child: Text(
                          'Usuń konto',
                          style: TextStyle(color: CustomColors.red1),
                        ),
                        onPressed: () async {
                          try {
                            await _deleteAccount();
                          } catch (exception) {
                            await Fluttertoast.showToast(
                              msg: 'W trakcie usuwania konta wystąpił błąd',
                              toastLength: Toast.LENGTH_LONG,
                            );
                            Navigator.of(context).pop();
                            return;
                          }

                          await Fluttertoast.showToast(
                            msg: 'Konto zostało usunięte',
                            toastLength: Toast.LENGTH_LONG,
                          );

                          Navigator.of(context).pop();
                          await context.router.replace(LoginRoute());
                        },
                      ),
                      ElevatedButton(
                        child: Text('Anuluj'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              buttonText: 'Usunięcie konta',
            ),
          ],
        ),
      ),
    );
  }
}
