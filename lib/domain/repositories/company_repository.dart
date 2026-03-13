import '../entities/company.dart';

abstract class CompanyRepository {

  Future<List<Company>> getCompanies(int page);

  Future<Company> getCompanyDetails(int id);
}