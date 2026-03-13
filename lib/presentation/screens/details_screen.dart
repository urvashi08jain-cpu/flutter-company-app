import 'package:flutter/material.dart';
import '../../core/network/api_service.dart';
import '../../core/utils/app_loader.dart';

class DetailsScreen extends StatefulWidget {

  final int id;

  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  final ApiService apiService = ApiService();

  Map<String, dynamic>? company;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  loadDetails() async {

    try {

      final data =
      await apiService.getCompanyDetails(widget.id);

      setState(() {
        company = data;
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        errorMessage = "Failed to load company details";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(body: AppLoader());
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(errorMessage!)),
      );
    }

    if (company == null) {
      return const Scaffold(
        body: Center(child: Text("No Data Found")),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(company!["name"] ?? ""),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Center(
              child: Image.network(
                company!["logo"] ?? "",
                height: 120,

                loadingBuilder:
                    (context, child, progress) {

                  if (progress == null) return child;

                  return const AppLoader();
                },

                errorBuilder:
                    (_, __, ___) =>
                const Icon(Icons.business,
                    size: 100),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              company!["name"] ?? "",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Industry: ${company!["industry"] ?? ""}"),
            Text("CEO: ${company!["ceoName"] ?? ""}"),
            Text("Country: ${company!["country"] ?? ""}"),
            Text("Employees: ${company!["employeeCount"] ?? ""}"),
            Text("Website: ${company!["domain"] ?? ""}"),
          ],
        ),
      ),
    );
  }
}