// providers/sidebar_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_tracker/presentation/enums/drawer_page.dart';

final pageProvider = StateProvider<DrawerPage>((ref) => DrawerPage.devices);
