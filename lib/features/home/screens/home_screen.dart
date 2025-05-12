import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../../../core/models/taxi_package.dart';
import '../widgets/hero_section.dart';
import '../widgets/horizontal_package_list.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TaxiPackage> packages = [
    // ... your package data (kept from previous context) ...
    TaxiPackage(
      name: 'Yatra - 1',
      description: '''Itinerary:
Pick-up → Tirumala Balaji Darshanam → Tirumala Sightseeing → Tirupati Drop''',
      price: 0,
      distance: 0,
    ),
    TaxiPackage(
      name: 'Yatra - 2',
      description: '''Itinerary:
Pick-up → Tirumala Balaji Darshanam → Tirumala Sightseeing → Local Temples → Tirupati Drop

Local Temples:
• Kapila Theertham
• Govindaraja Swamy Temple
• ISKCON Temple Tirupati
• Padmavathi Ammavari Temple
• Sri Suryanarayana Swamy Temple''',
      price: 0,
      distance: 0,
    ),
    TaxiPackage(
      name: 'Yatra - 3',
      description: '''Itinerary:
Pick-up → Tirumala Balaji Darshanam → Tirumala Sightseeing → Local Temples → Kanipakam → Tirupati Drop

Local Temples:
• Kapila Theertham
• Govindaraja Swamy Temple
• ISKCON Temple Tirupati
• Padmavathi Ammavari Temple
• Sri Suryanarayana Swamy Temple''',
      price: 0,
      distance: 0,
    ),
    TaxiPackage(
      name: 'Yatra - 4',
      description: '''Itinerary:
Pick-up → Tirumala Balaji Darshanam → Tirumala Sightseeing → Local Temples → Srikalahasti → Tirupati Drop

Local Temples:
• Kapila Theertham
• Govindaraja Swamy Temple
• ISKCON Temple Tirupati
• Padmavathi Ammavari Temple
• Sri Suryanarayana Swamy Temple''',
      price: 0,
      distance: 0,
    ),
    TaxiPackage(
      name: 'Yatra - 5',
      description: '''Itinerary:
Pick-up → Tirumala Balaji Darshanam → Tirumala Sightseeing → Local Temples → Kanipakam → Srikalahasti → Tirupati Drop

Local Temples:
• Kapila Theertham
• Govindaraja Swamy Temple
• ISKCON Temple Tirupati
• Padmavathi Ammavari Temple
• Sri Suryanarayana Swamy Temple''',
      price: 0,
      distance: 0,
    ),
    TaxiPackage(
      name: 'Yatra - 6',
      description: '''Itinerary:
Pick-up → Tirumala Balaji Darshanam → Tirumala Sightseeing → Kanipakam → Arunachalam (Tiruvannamalai) → Golden Temple''',
      price: 0,
      distance: 0,
    ),
  ];

  // Controller for the horizontal package list
  // Adjust viewportFraction to control how much of the next card is visible
  final PageController _pageController = PageController(viewportFraction: 0.85); // Example: 85% of viewport

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to launch WhatsApp with the given phone number
  Future<void> _launchWhatsApp() async {
    const String phoneNumber = "+917997990996"; // Replace with your actual phone number
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Show a SnackBar or dialog if WhatsApp can't be launched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch WhatsApp. Please check if it is installed.')),
      );
    }
  }

  // Function to scroll the horizontal list to the previous page
  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  // Function to scroll the horizontal list to the next page
  void _goToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    // Define the saffron color for navigation arrows
    const Color saffronColor = Color(0xFFFFA500); // Using the same saffron color as the button

    return Scaffold(
      body: SingleChildScrollView( // Keep overall vertical scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align column children to the start (left)
          children: [
            HeroSection(),
            SizedBox(height: 30), // Space after HeroSection
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Vertical padding for section
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align column children to the start (left)
                children: [
                  Padding( // Add padding only for the title
                    padding: const EdgeInsets.symmetric(horizontal: 20.0), // Horizontal padding for the title
                    child: Text(
                      'Our Packages',
                      textAlign: TextAlign.left, // Ensure text is aligned left
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Space between title and list
                  // Row with navigation arrows and the horizontal package list
                  Row(
                    children: [
                      // Left Arrow Button
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: _goToPreviousPage,
                        color: saffronColor, // Saffron color for the arrow
                      ),
                      Expanded( // Allow the list to take up the remaining space
                        child: HorizontalPackageList(
                          packages: packages,
                          pageController: _pageController, // Pass the page controller
                          onPackageSelected: _launchWhatsApp, // Pass the WhatsApp function
                        ),
                      ),
                      // Right Arrow Button
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: _goToNextPage,
                        color: saffronColor, // Saffron color for the arrow
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Space between package section and footer
            FooterSection(),
            SizedBox(height: 10), // Bottom padding after FooterSection
          ],
        ),
      ),
    );
  }
}