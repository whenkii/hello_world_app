import 'package:flutter/material.dart';
import '../../../core/models/taxi_package.dart';
import '../widgets/hero_section.dart';
import '../widgets/horizontal_package_list.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatelessWidget { // Can be StatelessWidget
  // Updated package list with 10 items
  final List<TaxiPackage> packages = [
    TaxiPackage(name: 'City Local Darshan', description: 'Explore Tirupati\'s local temples (8 Hrs/80 Kms).', price: 2499, distance: 80),
    TaxiPackage(name: 'Airport Transfer', description: 'Hassle-free pickup or drop from Tirupati Airport.', price: 1299, distance: 50),
    TaxiPackage(name: 'Tirumala Hills Trip', description: 'Dedicated round trip to Tirumala Hills (Approx 6 Hrs).', price: 1999, distance: 60),
    TaxiPackage(name: 'Srikalahasti Temple', description: 'Visit the famous Srikalahasti Temple (Approx 4 Hrs).', price: 1799, distance: 70),
    TaxiPackage(name: 'Kanipakam & Vellore', description: 'Day trip to Kanipakam Vinayaka & Vellore Golden Temple.', price: 4999, distance: 200),
    TaxiPackage(name: 'Local Half-Day', description: 'Quick tour of major local spots (4 Hrs/40 Kms).', price: 1499, distance: 40),
    TaxiPackage(name: 'Railway Station Transfer', description: 'Convenient pickup or drop from Tirupati Railway Station.', price: 799, distance: 20),
    TaxiPackage(name: 'Chandragiri Fort Visit', description: 'Explore the historic Chandragiri Fort (Approx 3 Hrs).', price: 1199, distance: 40),
    TaxiPackage(name: 'Tiruchanur Temple', description: 'Visit Padmavathi Ammavari Temple in Tiruchanur.', price: 999, distance: 30),
    TaxiPackage(name: 'Custom Package', description: 'Build your own itinerary with our flexible options.', price: 0, distance: 0), // Example custom
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Keep overall vertical scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroSection(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Vertical padding for section
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding( // Add padding only for the title
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Our Packages',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Space between title and list
                  HorizontalPackageList(packages: packages),
                ],
              ),
            ),            
            FooterSection(), // Added FooterSection
            SizedBox(height: 30), // Add some bottom padding if needed
          ],
        ),
      ),
    );
  }
}