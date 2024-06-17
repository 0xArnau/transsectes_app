import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transsectes_app/src/auth/bloc/auth_bloc.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/auth/widgets/log_out_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_alert_dialog_widget.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late String appName = '';
  late String version = '';
  late String buildNumber = '';

  String email = '';
  bool showEmail = false;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).add(GetEmail());

    _getPackageInfo();
  }

  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kColorBackground,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Icon(
                      Icons.person,
                      size: MediaQuery.of(context).size.height / 6,
                    ),
                  ),
                  Center(
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          setState(() {
                            email = state.value ?? '';
                          });
                        }
                      },
                      builder: (context, state) {
                        return ListTile(
                          title: Text(
                            showEmail ? email : '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: const Icon(Icons.email),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                showEmail = !showEmail;
                              });
                            },
                            child: Icon(
                              showEmail
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Center(
                  //   child: BlocBuilder<GeolocationBloc, GeolocationState>(
                  //     builder: (context, state) {
                  //       return ListTile(
                  //         leading: const Icon(Icons.gps_fixed),
                  //         title: const Text("GPS (Foreground)"),
                  //         trailing: Switch(
                  //           value: state.foregroundPermission,
                  //           onChanged: (value) {
                  //             Logger().d("value: $value");
                  //             if (value) {
                  //               context
                  //                   .read<GeolocationBloc>()
                  //                   .add(RequestForegroundGeolocation());
                  //             } else {
                  //               openAppSettings();
                  //             }
                  //           },
                  //           activeColor: kColorBackgroundWave,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // Center(
                  //   child: BlocBuilder<GeolocationBloc, GeolocationState>(
                  //     builder: (context, state) {
                  //       return ListTile(
                  //         leading: const Icon(Icons.gps_fixed),
                  //         title: const Text("GPS (Background)"),
                  //         subtitle: const Text(
                  //             "Required to get automatically the position"),
                  //         trailing: Switch(
                  //           value: state.backgroundPermission,
                  //           onChanged: (value) {
                  //             Logger().d("value: $value");
                  //             if (value) {
                  //               context
                  //                   .read<GeolocationBloc>()
                  //                   .add(RequestBackgroundGeolocation());
                  //             } else {
                  //               openAppSettings();
                  //             }
                  //           },
                  //           activeColor: kColorBackgroundWave,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Center(
                    child: ListTile(
                      leading: const Icon(Icons.open_in_new),
                      title: const Text("Open app settings (OS)"),
                      onTap: () {
                        openAppSettings();
                      },
                    ),
                  ),
                  Center(
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Delete account"),
                      onTap: () async {
                        await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialogWidget(
                              title: 'Remove account',
                              content:
                                  'Tis action cannot be undone!!! Please logout and login before deleting user',
                              primaryText: 'Delete',
                              primaryFunction: () {
                                Logger().d("onPressedAccept");
                                AuthRepository()
                                    .deleteUserAccountAndInformation(context);
                              },
                              secondaryText: 'Cancel',
                              secondaryFunction: () {},
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  logOutWidget(),
                  const SizedBox(height: 10),
                  Text(
                    '$appName - $version($buildNumber)',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
