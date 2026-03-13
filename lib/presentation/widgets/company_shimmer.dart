import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CompanyShimmer extends StatelessWidget {
  const CompanyShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      padding: const EdgeInsets.all(12),

      itemCount: 6,

      itemBuilder: (context, index) {

        return Shimmer.fromColors(

          baseColor: Colors.grey.shade300,

          highlightColor: Colors.grey.shade100,

          child: Card(

            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            child: ListTile(

              leading: Container(
                width: 50,
                height: 50,
                color: Colors.white,
              ),

              title: Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),

              subtitle: Container(
                margin: const EdgeInsets.only(top: 8),
                height: 10,
                width: 100,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}