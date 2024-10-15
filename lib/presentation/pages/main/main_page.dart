import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_tracker/presentation/extensions/build_context_extension.dart';
import 'package:gps_tracker/presentation/misc/app_routes.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';
import 'package:gps_tracker/presentation/providers/api/devices_provider.dart';
import 'package:gps_tracker/presentation/providers/routes/router_provider.dart';
import 'package:gps_tracker/presentation/providers/user_data/user_data_provider.dart';
import 'package:gps_tracker/presentation/widgets/common/device_ilist_tem.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    final devicesAsync = ref.watch(devicesProvider);

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
          title: const Text("Devices"),
          scrolledUnderElevation: 0.0,
        ),
        drawer: _buildDrawer(context),
        extendBodyBehindAppBar: true,
        body: devicesAsync.when(
          data: (devicesData) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: devicesData.length,
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: AppColors.primaryExtraSoft,
              ),
              itemBuilder: (context, index) {
                if (devicesData.isEmpty) {
                  // return const HistoryItemSkeleton();
                  return const Text("Empty");
                } else {
                  var item = devicesData[index];
                  return DeviceListItem(device: item);
                }
              },
            );
          },
          loading: () => ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Skeletonizer(
                child: ListTile(
                  title: Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.grey,
                  ),
                  subtitle: Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
          error: (error, stack) => Center(child: Text("Terjadi kesalahan: $error")),
        ),
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
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle navigation to settings.
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              ref.read(userDataProvider.notifier).logout();
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
}
