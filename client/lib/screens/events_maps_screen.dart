import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import '../core/services/event_services.dart';

class EventsMapsScreen extends StatefulWidget {
  const EventsMapsScreen({super.key});

  @override
  _EventsMapsScreenState createState() => _EventsMapsScreenState();
}

class _EventsMapsScreenState extends State<EventsMapsScreen> {
  late GoogleMapController mapController;
  Location location = Location();
  Set<Marker> markers = {};

  Future<LatLng> _getUserLocation() async {
    final userLocation = await location.getLocation();
    return LatLng(userLocation.latitude!, userLocation.longitude!);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _loadEvents() async {
    try {
      final userLocation = await _getUserLocation();
      final events = await EventServices.getEvents([], userLocation.latitude, userLocation.longitude, 'physical', 50);
      for (var event in events) {
        if (event.physicalEvent != null) {
          final eventLng = event.physicalEvent['lng'];
          final eventLat = event.physicalEvent['lat'];
          if (eventLat != null && eventLng != null) {
            final LatLng eventPosition = LatLng(eventLat, eventLng);
            markers.add(
              Marker(
                markerId: MarkerId(event.id!),
                position: eventPosition,
                infoWindow: InfoWindow(title: event.title, snippet: event.description),
              ),
            );
          }
        }
      }
      setState(() {});
    } catch (e) {
      print('Error loading events: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LatLng>(
        future: _getUserLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error retrieving location'));
          } else {
            LatLng _center = snapshot.data!;
            return GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15,
              ),
            );
          }
        },
      ),
    );
  }
}