import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_loader.dart';
import '../providers/auth_provider.dart';
import '../providers/company_provider.dart';
import '../widgets/company_shimmer.dart';
import 'details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      final provider =
      Provider.of<CompanyProvider>(context, listen: false);

      provider.fetchCompanies();
    });

    controller.addListener(() {

      if (controller.position.pixels ==
          controller.position.maxScrollExtent) {

        Provider.of<CompanyProvider>(
          context,
          listen: false,
        ).fetchCompanies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Companies"),

        actions: [

          IconButton(
            icon: const Icon(Icons.logout),
              onPressed: () {
                showLogoutDialog();
              }
          )
        ],
      ),

      body: Consumer<CompanyProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading && provider.companies.isEmpty) {
            return const CompanyShimmer();
          }

          if (provider.companies.isEmpty) {
            return const Center(
              child: Text(
                "No Companies Found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(

            controller: controller,

            padding: const EdgeInsets.all(12),

            itemCount:
            provider.companies.length +
                (provider.isLoading ? 1 : 0),

            itemBuilder: (context, index) {

              if (index == provider.companies.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: AppLoader(),
                );
              }

              final company = provider.companies[index];

              return Card(

                elevation: 4,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                margin:
                const EdgeInsets.symmetric(vertical: 8),

                child: ListTile(

                  leading: ClipRRect(

                    borderRadius: BorderRadius.circular(8),

                    child: Image.network(
                      company["logo"] ?? "",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,

                      loadingBuilder:
                          (context, child, progress) {

                        if (progress == null) return child;

                        return const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      },

                      errorBuilder:
                          (context, error, stackTrace) {

                        return const Icon(
                          Icons.business,
                          size: 40,
                        );
                      },
                    ),
                  ),

                  title: Text(
                    company["name"] ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    company["industry"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  trailing:
                  const Icon(Icons.arrow_forward_ios),

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          id: company["id"],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showLogoutDialog() {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Logout"),

          content: const Text(
              "Are you sure you want to logout?"),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(

              onPressed: () async {

                Navigator.pop(context);

                await Provider.of<AuthProvider>(
                  context,
                  listen: false,
                ).logout();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const LoginScreen(),
                  ),
                );
              },

              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}