import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../core/services/event_services.dart';
import 'package:client/utils/date_utils.dart' as d;

import '../utils/connectivty_utils.dart';

class EventsMapsScreen extends StatefulWidget {
  const EventsMapsScreen({super.key});

  @override
  _EventsMapsScreenState createState() => _EventsMapsScreenState();
}

class _EventsMapsScreenState extends State<EventsMapsScreen> {
  late GoogleMapController mapController;
  Location location = Location();
  MapType _currentMapType = MapType.normal;
  Set<Marker> markers = {};
  late LocationData _userLocation;
  bool _isLoading = true;
  bool _hasError = false;

  Future<LatLng> _getUserLocation() async {
    _userLocation = await location.getLocation();
    return LatLng(_userLocation.latitude!, _userLocation.longitude!);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _loadEvents() async {
    try {
      final events = await EventServices.getEvents([], _userLocation.latitude, _userLocation.longitude, 'physical', null);
      for (var event in events) {
        if (event.physicalEvent != null) {
          final eventLng = event.physicalEvent['lng'];
          final eventLat = event.physicalEvent['lat'];
          if (eventLat != null && eventLng != null) {
            final LatLng eventPosition = LatLng(eventLat, eventLng);
            final eventDate = d.DateUtils.isoToFormattedDateAndTime(event.startDate);
            markers.add(
              Marker(
                markerId: MarkerId(event.id!),
                position: eventPosition,
                infoWindow: InfoWindow(title: event.title, snippet: eventDate),
              ),
            );
          }
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading events: $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation().then((_) => _loadEvents());
    ConnectivityUtils.listenConnectivityChanges(() {
      _getUserLocation().then((_) => _loadEvents());
      setState(() {});
    });
  }

  @override
  void dispose() {
    ConnectivityUtils.cancelSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_hasError) {
      return const Center(child: Text('Error retrieving location'));
    } else {
      LatLng _center = LatLng(_userLocation.latitude!, _userLocation.longitude!);
      return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              markers: markers,
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15,
              ),
            ),
          ],
        ),
      );
    }
  }
}