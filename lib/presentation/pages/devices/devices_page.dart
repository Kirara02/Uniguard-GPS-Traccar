import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/providers/api/devices_provider.dart';
import 'package:gps_tracker/presentation/widgets/common/device_ilist_tem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DevicesPage extends ConsumerWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(devicesProvider);

    Future<void> _refreshDevices() async {
      await ref.read(devicesProvider.notifier).getDevices();
    }

    return RefreshIndicator(
      onRefresh: _refreshDevices,
      child: devicesAsync.when(
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
    );
  }
}
