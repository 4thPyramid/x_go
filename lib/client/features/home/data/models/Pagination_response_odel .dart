import 'package:x_go/client/features/home/data/models/car_model.dart';

class CarsPaginationResponse {
  final List<CarModel> data;
  final PaginationLinks links;
  final PaginationMeta meta;

  CarsPaginationResponse({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory CarsPaginationResponse.fromJson(Map<String, dynamic> json) {
    return CarsPaginationResponse(
      data: (json['data'] as List)
          .map((item) => CarModel.fromJson(item))
          .toList(),
      links: PaginationLinks.fromJson(json['links']),
      meta: PaginationMeta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((car) => car.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }
}

class PaginationLinks {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinks({this.first, this.last, this.prev, this.next});

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'first': first, 'last': last, 'prev': prev, 'next': next};
  }
}

class PaginationMeta {
  final int currentPage;
  final int? from;
  final int lastPage;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  PaginationMeta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
    required List<Map<String, dynamic>> links,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] is int
          ? json['current_page'] as int
          : int.tryParse(json['current_page'].toString()) ?? 1,
      from: json['from'] == null
          ? 0
          : (json['from'] is int
                ? json['from']
                : int.tryParse(json['from'].toString()) ?? 0),
      lastPage: json['last_page'] is int
          ? json['last_page'] as int
          : int.tryParse(json['last_page'].toString()) ?? 1,
      path: json['path']?.toString() ?? '',
      perPage: json['per_page'] is int
          ? json['per_page'] as int
          : int.tryParse(json['per_page'].toString()) ?? 10,
      to: json['to'] == null
          ? 0
          : (json['to'] is int
                ? json['to']
                : int.tryParse(json['to'].toString()) ?? 0),
      total: json['total'] is int
          ? json['total'] as int
          : int.tryParse(json['total'].toString()) ?? 0,
      links:
          (json['links'] as List?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}
