import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/presentation/misc/app_routes.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';
import 'package:gps_tracker/presentation/providers/routes/router_provider.dart';

class DeviceListItem extends ConsumerWidget {
  final Device device;

  const DeviceListItem({super.key, required this.device});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Extracting the needed data
    final String name = device.name;
    final String uniqueId = device.uniqueId;
    final String status = device.status;
    final String? lastUpdate = device.lastUpdate;

    // Determine subtitle based on status and lastUpdate
    String subtitle;
    Color subtitleColor;

    if (status == "online") {
      subtitle = "Online";
      subtitleColor = Colors.green; // Color for online
    } else {
      if (lastUpdate != null) {
        // Parse the lastUpdate and calculate the time difference
        final DateTime updateTime = DateTime.parse(lastUpdate);
        final Duration difference = DateTime.now().difference(updateTime);

        // Format the time difference
        if (difference.inDays > 0) {
          subtitle = "${difference.inDays} hari yang lalu"; // e.g. "1 hari yang lalu"
          subtitleColor = AppColors.secondarySoft; // Color for last update
        } else if (difference.inHours > 0) {
          subtitle = "${difference.inHours} jam yang lalu"; // e.g. "2 jam yang lalu"
          subtitleColor = AppColors.secondarySoft; // Color for last update
        } else {
          subtitle = "Baru saja"; // For updates within the last hour
          subtitleColor = AppColors.secondarySoft; // Color for last update
        }

        if (device.status == 'offline') {
          subtitleColor = Colors.red;
        }
      } else {
        subtitle = "Offline"; // If lastUpdate is null
        subtitleColor = Colors.red; // Color for offline
      }
    }

    return ListTile(
      onTap: () {
        if (!device.disabled!) {
          ref.read(routerProvider).push(Routes.DEVICE, extra: device);
        }
      },
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Icon(
          device.category == "scooter" ? Icons.electric_scooter : Icons.location_on,
          color: Colors.blue,
        ),
      ),
      title: Text(
        name,
        style: Typogaphy.Medium,
      ),
      subtitle: Row(
        children: [
          Text(
            uniqueId,
            style: Typogaphy.Regular.copyWith(fontSize: 12),
          ),
          Text(
            " • ",
            style: Typogaphy.SemiBold.copyWith(fontSize: 12),
          ),
          Expanded(
            child: Text(
              subtitle,
              style: Typogaphy.Medium.copyWith(
                fontSize: 12,
                color: subtitleColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
