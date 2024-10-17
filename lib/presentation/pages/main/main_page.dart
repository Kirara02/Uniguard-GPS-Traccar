import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_tracker/presentation/enums/drawer_page.dart';
import 'package:gps_tracker/presentation/extensions/build_context_extension.dart';
import 'package:gps_tracker/presentation/misc/app_routes.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';
import 'package:gps_tracker/presentation/pages/devices/devices_page.dart';
import 'package:gps_tracker/presentation/pages/settings/settings_page.dart';
import 'package:gps_tracker/presentation/providers/page/page_provider.dart';
import 'package:gps_tracker/presentation/providers/routes/router_provider.dart';
import 'package:gps_tracker/presentation/providers/user_data/user_data_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(pageProvider);

    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).go(Routes.LOGIN);
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(selectedPage.title),
          scrolledUnderElevation: 0.0,
        ),
        drawer: _buildDrawer(context),
        body: _buildContent(selectedPage), // Konten dinamis
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final user = ref.watch(userDataProvider).valueOrNull;
    final userName = user?.name ?? "-";
    final userEmail = user?.email ?? "No email";
    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : "-";

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 42, 164, 226),
              child: Text(
                userInitial,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: AppColors.secondaryExtraSoft),
            accountName: Text(
              userName,
              style: Typogaphy.SemiBold.copyWith(
                color: AppColors.dark,
              ),
            ),
            accountEmail: Text(
              userEmail,
              style: Typogaphy.Regular.copyWith(
                color: AppColors.dark,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Devices'),
            onTap: () {
              ref.read(pageProvider.notifier).state = DrawerPage.devices;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              ref.read(pageProvider.notifier).state = DrawerPage.settings;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              ref.read(userDataProvider.notifier).logout();
              Navigator.pop(context);
            },
          ),
          const Spacer(), // Pushes the footer to the bottom
          const Divider(), // Adds a divider before the footer
          ListTile(
            title: Text(
              'Version',
              style: Typogaphy.Regular,
            ),
            subtitle: Text(
              _packageInfo.version, // Replace with your app version dynamically if needed
              style: Typogaphy.Regular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(DrawerPage selectedPage) {
    switch (selectedPage) {
      case DrawerPage.devices:
        return const DevicesPage();
      case DrawerPage.settings:
        return const SettingsPage();
      default:
        return const DevicesPage();
    }
  }


}
