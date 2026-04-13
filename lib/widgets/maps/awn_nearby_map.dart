import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as ll;

import '../../l10n/app_localizations.dart';
import '../../services/geo_service.dart';
import '../../theme/app_theme.dart';
import '../nearby_volunteer_l10n.dart';

/// وضع الخريطة: من يرى من على الخريطة.
enum NearbyMapRole {
  /// ذو إعاقة: موقعك + متطوعون قريبون مع المسافة.
  disabilitySeesVolunteers,

  /// متطوع: موقعك + طلبات مساعدة قريبة مع المسافة.
  volunteerSeesRequests,
}

/// خريطة: **Google Maps** على الجوال، **OpenStreetMap** على الويب (تعمل بدون مفتاح Google).
class AwnNearbyMap extends StatefulWidget {
  const AwnNearbyMap({
    super.key,
    required this.role,
    this.height = 220,
  });

  final NearbyMapRole role;
  final double height;

  @override
  State<AwnNearbyMap> createState() => _AwnNearbyMapState();
}

class _AwnNearbyMapState extends State<AwnNearbyMap> with AutomaticKeepAliveClientMixin {
  gmaps.GoogleMapController? _controller;

  gmaps.LatLng _gCenter = GeoService.defaultAmman;
  List<NearbyVolunteerPin> _volunteers = [];
  List<({String id, gmaps.LatLng pos, double km})> _requests = [];
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final pos = await GeoService.resolveUserPosition();
    if (!mounted) return;

    if (widget.role == NearbyMapRole.disabilitySeesVolunteers) {
      final vols = GeoService.mockVolunteersAround(pos);
      setState(() {
        _gCenter = pos;
        _volunteers = vols;
        _requests = [];
        _loading = false;
      });
      if (!kIsWeb) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final markers = _googleMarkersVolunteers(l10n, pos, vols);
          _tryFitGoogle(pos, vols.map((e) => e.pos).toList(), markers);
        });
      }
    } else {
      final raw = GeoService.mockRequestsAround(pos);
      setState(() {
        _gCenter = pos;
        _requests = raw.map((e) => (id: e.id, pos: e.pos, km: e.km)).toList();
        _volunteers = [];
        _loading = false;
      });
      if (!kIsWeb) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final markers = _googleMarkersRequests(l10n, pos, _requests);
          _tryFitGoogle(pos, _requests.map((e) => e.pos).toList(), markers);
        });
      }
    }
  }

  Set<gmaps.Marker> _googleMarkersVolunteers(
    AppLocalizations l10n,
    gmaps.LatLng me,
    List<NearbyVolunteerPin> pins,
  ) {
    final markers = <gmaps.Marker>{
      gmaps.Marker(
        markerId: const gmaps.MarkerId('me'),
        position: me,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueAzure),
        infoWindow: gmaps.InfoWindow(title: l10n.mapYou),
      ),
    };
    for (final v in pins) {
      markers.add(
        gmaps.Marker(
          markerId: gmaps.MarkerId(v.id),
          position: v.pos,
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
          infoWindow: gmaps.InfoWindow(
            title: v.volunteerTitle(l10n),
            snippet: v.volunteerMapSnippet(l10n),
          ),
        ),
      );
    }
    return markers;
  }

  Set<gmaps.Marker> _googleMarkersRequests(
    AppLocalizations l10n,
    gmaps.LatLng me,
    List<({String id, gmaps.LatLng pos, double km})> raw,
  ) {
    final markers = <gmaps.Marker>{
      gmaps.Marker(
        markerId: const gmaps.MarkerId('me'),
        position: me,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueAzure),
        infoWindow: gmaps.InfoWindow(title: l10n.mapYou),
      ),
    };
    for (final o in raw) {
      markers.add(
        gmaps.Marker(
          markerId: gmaps.MarkerId(o.id),
          position: o.pos,
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
          infoWindow: gmaps.InfoWindow(
            title: l10n.mapHelpRequest,
            snippet: l10n.mapKmAway(o.km.toStringAsFixed(1)),
          ),
        ),
      );
    }
    return markers;
  }

  void _tryFitGoogle(gmaps.LatLng center, List<gmaps.LatLng> others, Set<gmaps.Marker> markers) {
    final c = _controller;
    if (c == null || others.isEmpty) return;
    _fitGoogleBounds(center, others, c);
  }

  Future<void> _fitGoogleBounds(
    gmaps.LatLng center,
    List<gmaps.LatLng> others,
    gmaps.GoogleMapController c,
  ) async {
    if (others.isEmpty) return;
    double minLat = center.latitude;
    double maxLat = center.latitude;
    double minLng = center.longitude;
    double maxLng = center.longitude;
    for (final p in others) {
      minLat = minLat < p.latitude ? minLat : p.latitude;
      maxLat = maxLat > p.latitude ? maxLat : p.latitude;
      minLng = minLng < p.longitude ? minLng : p.longitude;
      maxLng = maxLng > p.longitude ? maxLng : p.longitude;
    }
    minLat = minLat < center.latitude ? minLat : center.latitude;
    maxLat = maxLat > center.latitude ? maxLat : center.latitude;
    minLng = minLng < center.longitude ? minLng : center.longitude;
    maxLng = maxLng > center.longitude ? maxLng : center.longitude;

    try {
      await c.animateCamera(
        gmaps.CameraUpdate.newLatLngBounds(
          gmaps.LatLngBounds(
            southwest: gmaps.LatLng(minLat, minLng),
            northeast: gmaps.LatLng(maxLat, maxLng),
          ),
          56,
        ),
      );
    } catch (_) {
      await c.animateCamera(gmaps.CameraUpdate.newLatLngZoom(center, 13));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: _loading
                  ? const SizedBox.expand()
                  : kIsWeb
                      ? _buildOsm(l10n)
                      : _buildGoogle(l10n),
            ),
            if (_loading)
              ColoredBox(
                color: AppColors.royalBluePale.withValues(alpha: 0.85),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.royalBlue),
                ),
              ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Material(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(12),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.layers_rounded, size: 18, color: AppColors.royalBlue),
                      const SizedBox(width: 6),
                      Text(
                        kIsWeb ? l10n.mapOsmAttribution : l10n.mapLiveNearby,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOsm(AppLocalizations l10n) {
    final me = ll.LatLng(_gCenter.latitude, _gCenter.longitude);
    final markers = <fm.Marker>[
      fm.Marker(
        point: me,
        width: 42,
        height: 42,
        child: Tooltip(
          message: l10n.mapYou,
          child: const Icon(Icons.person_pin_circle, color: AppColors.royalBlue, size: 40),
        ),
      ),
      if (widget.role == NearbyMapRole.disabilitySeesVolunteers)
        ..._volunteers.map((v) {
          final title = v.volunteerTitle(l10n);
          final sub = v.volunteerMapSnippet(l10n);
          return fm.Marker(
            point: ll.LatLng(v.pos.latitude, v.pos.longitude),
            width: 40,
            height: 40,
            child: Tooltip(
              message: '$title\n$sub',
              child: Icon(Icons.volunteer_activism, color: Colors.green.shade700, size: 36),
            ),
          );
        })
      else
        ..._requests.map((n) {
          return fm.Marker(
            point: ll.LatLng(n.pos.latitude, n.pos.longitude),
            width: 40,
            height: 40,
            child: Tooltip(
              message: '${l10n.mapHelpRequest}\n${l10n.mapKmAway(n.km.toStringAsFixed(1))}',
              child: Icon(Icons.location_on, color: Colors.deepOrange.shade700, size: 38),
            ),
          );
        }),
    ];

    final coords = <ll.LatLng>[
      me,
      if (widget.role == NearbyMapRole.disabilitySeesVolunteers)
        ..._volunteers.map((v) => ll.LatLng(v.pos.latitude, v.pos.longitude))
      else
        ..._requests.map((n) => ll.LatLng(n.pos.latitude, n.pos.longitude)),
    ];

    return fm.FlutterMap(
      options: fm.MapOptions(
        initialCameraFit: fm.CameraFit.coordinates(
          coordinates: coords,
          padding: const EdgeInsets.all(48),
        ),
        initialCenter: me,
        initialZoom: 13,
        interactionOptions: const fm.InteractionOptions(flags: fm.InteractiveFlag.all),
      ),
      children: [
        fm.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.jordan.awn.awn',
        ),
        fm.MarkerLayer(markers: markers),
      ],
    );
  }

  Widget _buildGoogle(AppLocalizations l10n) {
    final gm = widget.role == NearbyMapRole.disabilitySeesVolunteers
        ? _googleMarkersVolunteers(l10n, _gCenter, _volunteers)
        : _googleMarkersRequests(l10n, _gCenter, _requests);

    final others = widget.role == NearbyMapRole.disabilitySeesVolunteers
        ? _volunteers.map((e) => e.pos).toList()
        : _requests.map((e) => e.pos).toList();

    return gmaps.GoogleMap(
      initialCameraPosition: gmaps.CameraPosition(target: _gCenter, zoom: 13),
      markers: gm,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      liteModeEnabled: false,
      padding: const EdgeInsets.only(top: 12, right: 8, left: 8, bottom: 8),
      onMapCreated: (ctrl) {
        _controller = ctrl;
        if (others.isNotEmpty) {
          _tryFitGoogle(_gCenter, others, gm);
        }
      },
    );
  }
}
