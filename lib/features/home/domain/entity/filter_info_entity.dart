class FilterInfoEntity {
  final List<BrandEntity> brands;
  final List<TypeEntity> types;
  final String maxPrice;
  final String minPrice;

  const FilterInfoEntity({
    required this.brands,
    required this.types,
    required this.maxPrice,
    required this.minPrice,
  });
}

class BrandEntity {
  final String name;
  final String logo;

  const BrandEntity({
    required this.name,
    required this.logo,
  });
}

class TypeEntity {
  final String name;

  const TypeEntity({
    required this.name,
  });
}
