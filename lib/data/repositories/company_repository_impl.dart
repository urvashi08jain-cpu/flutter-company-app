import '../../core/network/api_service.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {

  final ApiService apiService;

  CompanyRepositoryImpl(this.apiService);

  @override
  Future<List<Company>> getCompanies(int page) async {

    final response = await apiService.getCompanies(page);

    return response.map<Company>((json) {

      return Company(
        id: json["id"],
        name: json["name"],
        logo: json["logo"] ?? "",
        industry: json["industry"] ?? "",
        country: json["country"] ?? "",
        ceoName: json["ceoName"] ?? "",
      );

    }).toList();
  }

  @override
  Future<Company> getCompanyDetails(int id) async {

    final json = await apiService.getCompanyDetails(id);

    return Company(
      id: json["id"],
      name: json["name"],
      logo: json["logo"] ?? "",
      industry: json["industry"] ?? "",
      country: json["country"] ?? "",
      ceoName: json["ceoName"] ?? "",
    );
  }
}