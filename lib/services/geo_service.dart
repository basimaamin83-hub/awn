import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/maps_config.dart';

/// بيانات متطوع تجريبي للخريطة وقائمة «قريب منك».
class NearbyVolunteerPin {
  const NearbyVolunteerPin({
    required this.id,
    required this.pos,
    required this.km,
    required this.rating,
    required this.completedServices,
    required this.serviceKeys,
  });

  final String id;
  final LatLng pos;
  final double km;
  final double rating;
  final int completedServices;

  /// مفاتيح تطابق أنواع الخدمة في الواجهة (carry, shop, …).
  final List<String> serviceKeys;
}

/// موقع ومسافات — بدون تعقيد، مناسب للأداء على الجهاز والويب.
class GeoService {
  GeoService._();

  static const LatLng defaultAmman = LatLng(MapsConfig.defaultLat, MapsConfig.defaultLng);

  static Future<LatLng> resolveUserPosition() async {
    try {
      final serviceOn = await Geolocator.isLocationServiceEnabled();
      if (!serviceOn) return defaultAmman;

      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return defaultAmman;
      }

      final p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 12),
        ),
      );
      return LatLng(p.latitude, p.longitude);
    } catch (_) {
      return defaultAmman;
    }
  }

  static double kmBetween(LatLng a, LatLng b) {
    final m = Geolocator.distanceBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
    return m / 1000.0;
  }

  /// متطوعون تجريبيون حول نقطة المركز (ذو إعاقة يرى المتطوعين).
  static List<NearbyVolunteerPin> mockVolunteersAround(LatLng center) {
    const offsets = <(double, double)>[
      (0.011, 0.007),
      (-0.0085, 0.013),
      (0.0055, -0.010),
      (-0.012, -0.0065),
    ];
    const meta = <({double rating, int services, List<String> keys})>[
      (rating: 4.9, services: 24, keys: ['carry', 'shop', 'escort']),
      (rating: 4.7, services: 18, keys: ['shop', 'med']),
      (rating: 5.0, services: 31, keys: ['escort', 'clean']),
      (rating: 4.8, services: 12, keys: ['carry', 'other']),
    ];
    return List.generate(offsets.length, (i) {
      final pos = LatLng(
        center.latitude + offsets[i].$1,
        center.longitude + offsets[i].$2,
      );
      final km = kmBetween(center, pos);
      final m = meta[i];
      return NearbyVolunteerPin(
        id: 'v$i',
        pos: pos,
        km: km,
        rating: m.rating,
        completedServices: m.services,
        serviceKeys: m.keys,
      );
    });
  }

  /// طلبات مساعدة تجريبية حول المتطوع (المتطوع يرى الطلبات).
  static List<({String id, LatLng pos, double km})> mockRequestsAround(LatLng center) {
    const offsets = <(double, double)>[
      (0.009, 0.011),
      (-0.010, 0.008),
      (0.007, -0.009),
      (-0.006, 0.014),
    ];
    return List.generate(offsets.length, (i) {
      final pos = LatLng(
        center.latitude + offsets[i].$1,
        center.longitude + offsets[i].$2,
      );
      final km = kmBetween(center, pos);
      return (id: 'r$i', pos: pos, km: km);
    });
  }

  /// نقطتان قريبتان لشاشة «الخدمة قيد التنفيذ» (أنت + الطرف الآخر).
  static ({LatLng me, LatLng peer}) pairForService(LatLng me) {
    final peer = LatLng(me.latitude + 0.004, me.longitude + 0.003);
    return (me: me, peer: peer);
  }
}
