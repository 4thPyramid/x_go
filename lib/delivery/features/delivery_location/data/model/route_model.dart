class RouteModel {
  final String status;
  final String summary;
  final String distance;
  final String duration;
  final String polyline;
  final String startAddress;
  final String endAddress;
  final List<RouteStep> steps;

  RouteModel({
    required this.status,
    required this.summary,
    required this.distance,
    required this.duration,
    required this.polyline,
    required this.startAddress,
    required this.endAddress,
    required this.steps,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      status: json['status'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      distance: json['distance'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      polyline: json['polyline'] as String? ?? '',
      startAddress: json['start_address'] as String? ?? '',
      endAddress: json['end_address'] as String? ?? '',
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => RouteStep.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class RouteStep {
  final Distance distance;
  final DurationModel duration;
  final LatLngModel startLocation;
  final LatLngModel endLocation;
  final String htmlInstructions;
  final String maneuver;
  final String travelMode;
  final String polyline;

  RouteStep({
    required this.distance,
    required this.duration,
    required this.startLocation,
    required this.endLocation,
    required this.htmlInstructions,
    required this.maneuver,
    required this.travelMode,
    required this.polyline,
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    return RouteStep(
      distance: json['distance'] != null
          ? Distance.fromJson(json['distance'])
          : Distance(),
      duration: json['duration'] != null
          ? DurationModel.fromJson(json['duration'])
          : DurationModel(),
      startLocation: json['start_location'] != null
          ? LatLngModel.fromJson(json['start_location'])
          : LatLngModel(),
      endLocation: json['end_location'] != null
          ? LatLngModel.fromJson(json['end_location'])
          : LatLngModel(),
      htmlInstructions: json['html_instructions'] as String? ?? '',
      maneuver: json['maneuver'] as String? ?? '',
      travelMode: json['travel_mode'] as String? ?? '',
      polyline: json['polyline']?['points'] as String? ?? '',
    );
  }
}

class Distance {
  final String text;
  final int value;

  Distance({this.text = '', this.value = 0});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json['text'] as String? ?? '',
      value: json['value'] as int? ?? 0,
    );
  }
}

class DurationModel {
  final String text;
  final int value;

  DurationModel({this.text = '', this.value = 0});

  factory DurationModel.fromJson(Map<String, dynamic> json) {
    return DurationModel(
      text: json['text'] as String? ?? '',
      value: json['value'] as int? ?? 0,
    );
  }
}

class LatLngModel {
  final double lat;
  final double lng;

  LatLngModel({this.lat = 0.0, this.lng = 0.0});

  factory LatLngModel.fromJson(Map<String, dynamic> json) {
    return LatLngModel(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
