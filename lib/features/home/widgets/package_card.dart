import 'package:flutter/material.dart';
import '../../../core/models/taxi_package.dart';

class PackageCard extends StatelessWidget {
  final TaxiPackage package;
  // Define a fixed width for the card when used in the horizontal list
  final double? width;

  const PackageCard({Key? key, required this.package, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Use SizedBox to enforce width if provided
      width: width,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Slightly reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out content vertically
            children: [
              Text(
                package.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Slightly smaller title
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                package.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  fontSize: 13, // Smaller description text
                ),
                maxLines: 2, // Limit to 2 lines
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    // Handle custom package price display
                    package.price > 0 ? '₹${package.price.toStringAsFixed(0)}' : 'Custom',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Slightly smaller price
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                       print("Select Package Tapped: ${package.name}");
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Selected package: ${package.name}')),
                       );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Smaller button padding
                      textStyle: TextStyle(fontSize: 12), // Smaller button text
                    ),
                    child: Text('Select'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}