import 'package:flutter/material.dart';
import '../../domain/entities/company.dart';

class CompanyTile extends StatelessWidget {

  final Company company;
  final VoidCallback onTap;

  const CompanyTile({
    super.key,
    required this.company,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(

        leading: ClipRRect(

          borderRadius: BorderRadius.circular(8),

          child: Image.network(
            company.logo,
            width: 50,
            height: 50,
            fit: BoxFit.cover,

            errorBuilder: (context, error, stackTrace) {

              return const Icon(
                Icons.business,
                size: 40,
              );
            },
          ),
        ),

        title: Text(
          company.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          company.industry,
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }
}