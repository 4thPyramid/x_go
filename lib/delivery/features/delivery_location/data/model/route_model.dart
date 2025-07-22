class RouteModel {
  final String? status;
  final String? summary;
  final String? distance;
  final String? duration;
  final String? polyline;
  final String? startAddress;
  final String? endAddress;
  final List<RouteStep> steps;

  RouteModel({
    this.status,
    this.summary,
    this.distance,
    this.duration,
    this.polyline,
    this.startAddress,
    this.endAddress,
    required this.steps,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      status: json['status'] as String?,
      summary: json['summary'] as String?,
      distance: json['distance'] as String?,
      duration: json['duration'] as String?,
      polyline: json['polyline'] as String?,
      startAddress: json['start_address'] as String?,
      endAddress: json['end_address'] as String?,
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => RouteStep.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class RouteStep {
  final Distance? distance;
  final DurationModel? duration;
  final LatLngModel? startLocation;
  final LatLngModel? endLocation;
  final String? htmlInstructions;
  final String? maneuver;
  final String? travelMode;
  final String? polyline;

  RouteStep({
    this.distance,
    this.duration,
    this.startLocation,
    this.endLocation,
    this.htmlInstructions,
    this.maneuver,
    this.travelMode,
    this.polyline,
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    return RouteStep(
      distance: json['distance'] != null
          ? Distance.fromJson(json['distance'])
          : null,
      duration: json['duration'] != null
          ? DurationModel.fromJson(json['duration'])
          : null,
      startLocation: json['start_location'] != null
          ? LatLngModel.fromJson(json['start_location'])
          : null,
      endLocation: json['end_location'] != null
          ? LatLngModel.fromJson(json['end_location'])
          : null,
      htmlInstructions: json['html_instructions'] as String?,
      maneuver: json['maneuver'] as String?,
      travelMode: json['travel_mode'] as String?,
      polyline: json['polyline']?['points'] as String?,
    );
  }
}

class Distance {
  final String? text;
  final int? value;

  Distance({this.text, this.value});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json['text'] as String?,
      value: json['value'] as int?,
    );
  }
}

class DurationModel {
  final String? text;
  final int? value;

  DurationModel({this.text, this.value});

  factory DurationModel.fromJson(Map<String, dynamic> json) {
    return DurationModel(
      text: json['text'] as String?,
      value: json['value'] as int?,
    );
  }
}

class LatLngModel {
  final double? lat;
  final double? lng;

  LatLngModel({this.lat, this.lng});

  factory LatLngModel.fromJson(Map<String, dynamic> json) {
    return LatLngModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}
