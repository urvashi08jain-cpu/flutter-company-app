class CompanyModel {

  final int id;
  final String name;
  final String logo;
  final String description;

  CompanyModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {

    return CompanyModel(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      description: json["description"],
    );
  }
}