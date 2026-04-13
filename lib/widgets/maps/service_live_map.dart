import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as ll;

import '../../l10n/app_localizations.dart';
import '../../services/geo_service.dart';
import '../../theme/app_theme.dart';

/// خريطة أثناء الخدمة: تتبّع حيّ، وقت وصول تقديري، والضغط على طرف للتواصل.
class ServiceLiveMap extends StatefulWidget {
  const ServiceLiveMap({
    super.key,
    required this.volunteerSide,
    this.onPeerTap,
  });

  final bool volunteerSide;
  final VoidCallback? onPeerTap;

  @override
  State<ServiceLiveMap> createState() => _ServiceLiveMapState();
}

class _ServiceLiveMapState extends State<ServiceLiveMap> with AutomaticKeepAliveClientMixin {
  gmaps.GoogleMapController? _controller;
  gmaps.LatLng _meFixed = GeoService.defaultAmman;
  gmaps.LatLng _peerStart = GeoService.defaultAmman;
  gmaps.LatLng _displayMe = GeoService.defaultAmman;
  gmaps.LatLng _displayPeer = GeoService.defaultAmman;
  Set<gmaps.Marker> _markers = {};
  bool _loading = true;
  double _km = 0.6;
  Timer? _tick;
  double _progress = 0;

  static const _speedKmh = 26.0;
  static const _tickMs = 900;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  gmaps.LatLng _lerp(gmaps.LatLng a, gmaps.LatLng b, double t) {
    final c = t.clamp(0.0, 1.0);
    return gmaps.LatLng(
      a.latitude + (b.latitude - a.latitude) * c,
      a.longitude + (b.longitude - a.longitude) * c,
    );
  }

  int _etaMinutes(double km) {
    if (km <= 0.01) return 1;
    final hours = km / _speedKmh;
    return (hours * 60).ceil().clamp(1, 120);
  }

  void _rebuildMarkers(AppLocalizations l10n) {
    final meHue = widget.volunteerSide ? gmaps.BitmapDescriptor.hueGreen : gmaps.BitmapDescriptor.hueAzure;
    final peerHue = widget.volunteerSide ? gmaps.BitmapDescriptor.hueAzure : gmaps.BitmapDescriptor.hueGreen;

    _markers = {
      gmaps.Marker(
        markerId: const gmaps.MarkerId('me'),
        position: _displayMe,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(meHue),
        infoWindow: gmaps.InfoWindow(title: l10n.mapYou),
      ),
      gmaps.Marker(
        markerId: const gmaps.MarkerId('peer'),
        position: _displayPeer,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(peerHue),
        infoWindow: gmaps.InfoWindow(
          title: widget.volunteerSide ? l10n.requesterRole : l10n.peerVolunteerName,
        ),
        onTap: widget.onPeerTap,
      ),
    };
  }

  Future<void> _load() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final me = await GeoService.resolveUserPosition();
    final pair = GeoService.pairForService(me);
    final peer = pair.peer;

    if (!mounted) return;

    _meFixed = me;
    _peerStart = peer;
    _displayMe = me;
    _displayPeer = peer;
    _km = GeoService.kmBetween(_displayMe, _displayPeer);
    _progress = 0;
    _rebuildMarkers(l10n);

    setState(() => _loading = false);

    if (!kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryFit(_displayMe, _displayPeer));
    }

    _tick?.cancel();
    _tick = Timer.periodic(const Duration(milliseconds: _tickMs), (_) {
      if (!mounted) return;
      setState(() {
        _progress = (_progress + 0.018).clamp(0.0, 1.0);
        if (widget.volunteerSide) {
          _displayMe = _lerp(_meFixed, _peerStart, _progress);
          _displayPeer = _peerStart;
        } else {
          _displayMe = _meFixed;
          _displayPeer = _lerp(_peerStart, _meFixed, _progress);
        }
        _km = GeoService.kmBetween(_displayMe, _displayPeer);
        _rebuildMarkers(AppLocalizations.of(context)!);
      });
      if (!kIsWeb && _controller != null) {
        _tryFit(_displayMe, _displayPeer);
      }
    });
  }

  Future<void> _tryFit(gmaps.LatLng a, gmaps.LatLng b) async {
    final c = _controller;
    if (c == null || !mounted) return;
    await _fit(a, b, c);
  }

  Future<void> _fit(gmaps.LatLng a, gmaps.LatLng b, gmaps.GoogleMapController c) async {
    try {
      await c.animateCamera(
        gmaps.CameraUpdate.newLatLngBounds(
          gmaps.LatLngBounds(
            southwest: gmaps.LatLng(
              a.latitude < b.latitude ? a.latitude : b.latitude,
              a.longitude < b.longitude ? a.longitude : b.longitude,
            ),
            northeast: gmaps.LatLng(
              a.latitude > b.latitude ? a.latitude : b.latitude,
              a.longitude > b.longitude ? a.longitude : b.longitude,
            ),
          ),
          64,
        ),
      );
    } catch (_) {
      final center = gmaps.LatLng((a.latitude + b.latitude) / 2, (a.longitude + b.longitude) / 2);
      await c.animateCamera(gmaps.CameraUpdate.newLatLngZoom(center, 14));
    }
  }

  @override
  void dispose() {
    _tick?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildOsm(AppLocalizations l10n) {
    final a = ll.LatLng(_displayMe.latitude, _displayMe.longitude);
    final b = ll.LatLng(_displayPeer.latitude, _displayPeer.longitude);
    final meHue = widget.volunteerSide ? AppColors.rainbowGreen : AppColors.rainbowBlue;
    final peerHue = widget.volunteerSide ? AppColors.rainbowBlue : AppColors.rainbowGreen;

    return fm.FlutterMap(
      options: fm.MapOptions(
        initialCameraFit: fm.CameraFit.coordinates(
          coordinates: [a, b],
          padding: const EdgeInsets.all(56),
        ),
        initialCenter: ll.LatLng((a.latitude + b.latitude) / 2, (a.longitude + b.longitude) / 2),
        initialZoom: 14,
        interactionOptions: const fm.InteractionOptions(flags: fm.InteractiveFlag.all),
      ),
      children: [
        fm.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.jordan.awn.awn',
        ),
        fm.MarkerLayer(
          markers: [
            fm.Marker(
              point: a,
              width: 44,
              height: 44,
              child: Tooltip(
                message: l10n.mapYou,
                child: Icon(Icons.person_pin_circle, color: meHue, size: 40),
              ),
            ),
            fm.Marker(
              point: b,
              width: 48,
              height: 48,
              child: Tooltip(
                message: l10n.tapPeerOnMap,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onPeerTap,
                    customBorder: const CircleBorder(),
                    child: Icon(Icons.location_on, color: peerHue, size: 42),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;
    final eta = _etaMinutes(_km);
    final center = gmaps.LatLng(
      (_displayMe.latitude + _displayPeer.latitude) / 2,
      (_displayMe.longitude + _displayPeer.longitude) / 2,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: _loading
                  ? const SizedBox.expand()
                  : kIsWeb
                      ? _buildOsm(l10n)
                      : gmaps.GoogleMap(
                          initialCameraPosition: gmaps.CameraPosition(target: center, zoom: 14),
                          markers: _markers,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          compassEnabled: false,
                          liteModeEnabled: false,
                          onTap: (pos) {
                            final dMe = GeoService.kmBetween(
                              pos,
                              _displayMe,
                            );
                            final dPeer = GeoService.kmBetween(
                              pos,
                              _displayPeer,
                            );
                            if (dPeer < dMe && dPeer < 0.15) {
                              widget.onPeerTap?.call();
                            }
                          },
                          onMapCreated: (ctrl) async {
                            _controller = ctrl;
                            if (!_loading) {
                              await _fit(_displayMe, _displayPeer, ctrl);
                            }
                          },
                        ),
            ),
            if (_loading)
              ColoredBox(
                color: AppColors.royalBluePale.withValues(alpha: 0.9),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.royalBlue),
                ),
              ),
            if (!_loading)
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(16),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.route_rounded, color: AppColors.rainbowViolet, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l10n.mapKmAway(_km.toStringAsFixed(2)),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.schedule_rounded, color: AppColors.rainbowBlue, size: 18),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                l10n.etaApproxMinutes(eta),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.directions_run_rounded, color: AppColors.rainbowGreen, size: 18),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.volunteerSide ? l10n.liveYouAreMoving : l10n.livePeerMovingToYou,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.rainbowIndigo,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
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
}
