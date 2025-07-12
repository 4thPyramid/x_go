class CarEntity {
  final String id;
  final String modelName; // استخدام model name بدلاً من name
  final String year;
  final String price;
  final String engineType;
  final String transmissionType;
  final String seatType;
  final int seatsCount;
  final String acceleration;
  final String image;
  final String typeName;
  final String brandName;

  const CarEntity({
    required this.id,
    required this.modelName,
    required this.year,
    required this.price,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.image,
    required this.typeName,
    required this.brandName,
  });
}

class Brand {
  final String id;
  final String name;
  final String logo;

  const Brand({required this.id, required this.name, required this.logo});
}

class CarType {
  final String name;

  const CarType({required this.name});
}

class FilterInfo {
  final List<Brand> brands;
  final List<CarType> types;
  final List<String> years;
  final String maxPrice;
  final String minPrice;

  const FilterInfo({
    required this.brands,
    required this.types,
    required this.years,
    required this.maxPrice,
    required this.minPrice,
  });
}

