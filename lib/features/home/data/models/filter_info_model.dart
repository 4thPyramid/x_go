class HomeRequestParams {
  final int? page;
  final String? search;
  final String? brand;
  final String? type;
  final String? model;
  final String? minPrice;
  final String? maxPrice;
  final String? engineType;
  final String? transmissionType;
  final String? seatType;
  final int? minSeats;
  final int? maxSeats;

  HomeRequestParams({
    this.page,
    this.search,
    this.brand,
    this.type,
    this.model,
    this.minPrice,
    this.maxPrice,
    this.engineType,
    this.transmissionType,
    this.seatType,
    this.minSeats,
    this.maxSeats,
  });

  factory HomeRequestParams.fromJson(Map<String, dynamic> json) {
    return HomeRequestParams(
      page: json['page'] as int?,
      search: json['search'] as String?,
      brand: json['brand'] as String?,
      type: json['type'] as String?,
      model: json['model'] as String?,
      minPrice: json['min_price'] as String?,
      maxPrice: json['max_price'] as String?,
      engineType: json['engine_type'] as String?,
      transmissionType: json['transmission_type'] as String?,
      seatType: json['seat_type'] as String?,
      minSeats: json['min_seats'] as int?,
      maxSeats: json['max_seats'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'search': search,
      'brand': brand,
      'type': type,
      'model': model,
      'min_price': minPrice,
      'max_price': maxPrice,
      'engine_type': engineType,
      'transmission_type': transmissionType,
      'seat_type': seatType,
      'min_seats': minSeats,
      'max_seats': maxSeats,
    };
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    data['page'] = page ?? 1;

    if (search != null && search!.trim().isNotEmpty) {
      data['search'] = search!.trim();
    }

    if (brand != null && brand!.trim().isNotEmpty) {
      data['brand'] = brand!.trim();
    }

    if (type != null && type!.trim().isNotEmpty) {
      data['type'] = type!.trim();
    }

    if (model != null && model!.trim().isNotEmpty) {
      data['model'] = model!.trim();
    }

    if (minPrice != null && minPrice!.trim().isNotEmpty) {
      data['min_price'] = minPrice!.trim();
    }

    if (maxPrice != null && maxPrice!.trim().isNotEmpty) {
      data['max_price'] = maxPrice!.trim();
    }

    if (engineType != null && engineType!.trim().isNotEmpty) {
      data['engine_type'] = engineType!.trim();
    }

    if (transmissionType != null && transmissionType!.trim().isNotEmpty) {
      data['transmission_type'] = transmissionType!.trim();
    }

    if (seatType != null && seatType!.trim().isNotEmpty) {
      data['seat_type'] = seatType!.trim();
    }

    if (minSeats != null) {
      data['min_seats'] = minSeats!;
    }

    if (maxSeats != null) {
      data['max_seats'] = maxSeats!;
    }

    return data;
  }

  HomeRequestParams copyWith({
    int? page,
    String? search,
    String? brand,
    String? type,
    String? model,
    String? minPrice,
    String? maxPrice,
    String? engineType,
    String? transmissionType,
    String? seatType,
    int? minSeats,
    int? maxSeats,
  }) {
    return HomeRequestParams(
      page: page ?? this.page,
      search: search ?? this.search,
      brand: brand ?? this.brand,
      type: type ?? this.type,
      model: model ?? this.model,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      engineType: engineType ?? this.engineType,
      transmissionType: transmissionType ?? this.transmissionType,
      seatType: seatType ?? this.seatType,
      minSeats: minSeats ?? this.minSeats,
      maxSeats: maxSeats ?? this.maxSeats,
    );
  }

  bool get hasFilters {
    return (brand != null && brand!.trim().isNotEmpty) ||
        (type != null && type!.trim().isNotEmpty) ||
        (model != null && model!.trim().isNotEmpty) ||
        (minPrice != null && minPrice!.trim().isNotEmpty) ||
        (maxPrice != null && maxPrice!.trim().isNotEmpty) ||
        (engineType != null && engineType!.trim().isNotEmpty) ||
        (transmissionType != null && transmissionType!.trim().isNotEmpty) ||
        (seatType != null && seatType!.trim().isNotEmpty) ||
        minSeats != null ||
        maxSeats != null ||
        (search != null && search!.trim().isNotEmpty);
  }

  @override
  String toString() {
    return 'HomeRequestParams(page: $page, search: $search, brand: $brand, type: $type, model: $model, minPrice: $minPrice, maxPrice: $maxPrice, engineType: $engineType, transmissionType: $transmissionType, seatType: $seatType, minSeats: $minSeats, maxSeats: $maxSeats)';
  }
}

class FilterInfoResponse {
  final List<BrandModel> brands;
  final List<TypeModel> types;
  final String maxPrice;
  final String minPrice;

  FilterInfoResponse({
    required this.brands,
    required this.types,
    required this.maxPrice,
    required this.minPrice,
  });

  factory FilterInfoResponse.fromJson(Map<String, dynamic> json) {
    return FilterInfoResponse(
      brands: (json['brands'] as List)
          .map((item) => BrandModel.fromJson(item))
          .toList(),
      types: (json['types'] as List)
          .map((item) => TypeModel.fromJson(item))
          .toList(),
      maxPrice: json['max_price'] as String,
      minPrice: json['min_price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brands': brands.map((brand) => brand.toJson()).toList(),
      'types': types.map((type) => type.toJson()).toList(),
      'max_price': maxPrice,
      'min_price': minPrice,
    };
  }

  @override
  String toString() {
    return 'FilterInfoResponse(brands: ${brands.length}, types: ${types.length}, maxPrice: $maxPrice, minPrice: $minPrice)';
  }
}

class BrandModel {
  final String id;
  final BrandAttributes attributes;

  BrandModel({
    required this.id,
    required this.attributes,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String,
      attributes: BrandAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.toJson(),
    };
  }

  @override
  String toString() {
    return 'BrandModel(id: $id, name: ${attributes.name})';
  }
}

class BrandAttributes {
  final String name;
  final String logo;

  BrandAttributes({
    required this.name,
    required this.logo,
  });

  factory BrandAttributes.fromJson(Map<String, dynamic> json) {
    return BrandAttributes(
      name: json['name'] as String,
      logo: json['logo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
    };
  }

  @override
  String toString() {
    return 'BrandAttributes(name: $name, logo: $logo)';
  }
}

class TypeModel {
  final String name;

  TypeModel({required this.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'TypeModel(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TypeModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
