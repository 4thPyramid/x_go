class FilterRequestEntity {
  final String? brand;
  final String? type;
  final String? model;
  final String? minPrice;
  final String? maxPrice;

  const FilterRequestEntity({
    this.brand,
    this.type,
    this.model,
    this.minPrice,
    this.maxPrice,
  });
}
