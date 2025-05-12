import 'package:flutter/material.dart';
import '../../../core/models/taxi_package.dart';
import '../widgets/package_card.dart'; // Make sure the path is correct

class HorizontalPackageList extends StatelessWidget {
  final List<TaxiPackage> packages;
  // Add the PageController parameter
  final PageController pageController;
  // Add the callback function for when a package is selected
  final VoidCallback onPackageSelected;


  const HorizontalPackageList({
    Key? key,
    required this.packages,
    required this.pageController, // Require the PageController
    required this.onPackageSelected, // Require the callback
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // The width of each card can be calculated based on the viewportFraction
    // defined in the PageController, but here we are explicitly setting a width
    // passed from the parent, which is then enforced by the PackageCard's SizedBox.
    // However, the overall height of the list is controlled by the SizedBox below.

    return SizedBox(
      // *** REDUCE THIS HEIGHT VALUE ***
      height: 280, // Example: Reduced height from 320 or 350
      child: ListView.builder(
        controller: pageController, // Assign the PageController
        scrollDirection: Axis.horizontal,
        itemCount: packages.length,
        // Add padding to the ListView itself for spacing at the start/end
        // padding: EdgeInsets.symmetric(horizontal: 20.0), // Alternative padding method

        itemBuilder: (context, index) {
          final package = packages[index];
          // Using padding on each item for spacing between cards
          return Padding(
            // Adjust horizontal padding between cards and at the ends
            padding: EdgeInsets.only(
              left: index == 0 ? 20.0 : 12.0, // Padding on the left of the first card
              right: index == packages.length - 1 ? 20.0 : 12.0, // Padding on the right of the last card
            ),
            child: PackageCard(
              package: package,
              // The width is often handled by the PageController's viewportFraction
              // but you can pass a suggested width here if needed, though it
              // might be overridden by the viewportFraction behavior.
              // For PageController, letting the items size based on viewportFraction is common.
              // Let's remove the fixed width here if PageController's viewportFraction is used.
              // width: 300.0, // Remove or adjust if using viewportFraction
              onSelect: onPackageSelected, // Pass the callback
            ),
          );
        },
      ),
    );
  }
}