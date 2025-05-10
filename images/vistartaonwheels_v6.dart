import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Ensure this import is present
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

void main() {
  // Define app-wide color constants
  // const Color kAppPrimaryDark = Color(0xFF0A192F); // Example: A very dark blue
  const Color kAppAccentOrange = Color(0xFFFF7A00); // Bright orange for actions
  runApp(VistaraOnWheels());
}

// Models
class TaxiPackage {
  final String name;
  final String description;
  final double price;
  final int distance; // Assuming distance might be used later

  TaxiPackage({
    required this.name,
    required this.description,
    required this.price,
    required this.distance,
  });
}

// Define app-wide color constants (can be accessed by widgets if not passed via theme)
const Color kAppAccentOrange = Color(0xFFFF7A00); // Bright orange for actions

// Widgets

// CustomButton Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kAppAccentOrange, // Updated: Background color
        foregroundColor: Colors.white, // Updated: Text/icon color
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }
}

// HeroSection Widget
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        // Add the background image
        image: DecorationImage(
          image: AssetImage('images/temple.jpg'), // Ensure this path is correct and image is in pubspec.yaml
          fit: BoxFit.cover, // Cover the entire area
        ),
        // Apply a gradient overlay
        gradient: LinearGradient(
          colors: [
            Color(0xAA1A1F2C), // Dark blue/grey with transparency (e.g., AA for ~67% opacity)
            Color(0xAA2C1F3C), // Dark purple/blue with transparency
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // The gradient will be drawn on top of the image
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VISTARA ON WHEELS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your Journey, Our Passion',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 32),
            CustomButton(
              text: 'Book Now',
              onPressed: () {
                // TODO: Implement navigation logic for booking
                print("Book Now Tapped");
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking feature coming soon!')),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// PackageCard Widget (Modified for Horizontal List)
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

// HorizontalPackageList Widget (Stateful)
class HorizontalPackageList extends StatefulWidget {
  final List<TaxiPackage> packages;

  const HorizontalPackageList({Key? key, required this.packages}) : super(key: key);

  @override
  _HorizontalPackageListState createState() => _HorizontalPackageListState();
}

class _HorizontalPackageListState extends State<HorizontalPackageList> {
  late ScrollController _scrollController;
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  // Configuration
  final double cardHeight = 170.0; // Target height for the list area - INCREASED
  final double visibleItems = 3.0; // Number of items roughly visible
  final double spacing = 16.0; // Space between cards

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    // Initial check if the list is scrollable
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollability();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
     if (!_scrollController.hasClients) return;
     final maxScroll = _scrollController.position.maxScrollExtent;
     final currentScroll = _scrollController.position.pixels;
     // Add a small tolerance to avoid floating point issues
     final tolerance = 1.0;
     setState(() {
       _showLeftArrow = currentScroll > tolerance;
       _showRightArrow = currentScroll < (maxScroll - tolerance);
     });
  }

  void _checkScrollability() {
     if (!_scrollController.hasClients) return;
     final maxScroll = _scrollController.position.maxScrollExtent;
     setState(() {
       // Only show right arrow if content width exceeds viewport width
       _showRightArrow = maxScroll > 0;
       _showLeftArrow = false; // Initially hide left arrow
     });
  }


  void _scroll(double offset) {
    if (!_scrollController.hasClients) return;
    final targetScroll = (_scrollController.offset + offset)
        .clamp(_scrollController.position.minScrollExtent, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      targetScroll,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate card width based on screen size and desired visible items
    final screenWidth = MediaQuery.of(context).size.width;
    // Subtract padding (e.g., 20 on each side) and space for arrows
    final availableWidth = screenWidth - (2 * 20) - (2 * 40); // Adjust arrow space (40*2) as needed
    final cardWidth = (availableWidth - (spacing * (visibleItems - 1))) / visibleItems;

    // Ensure cardWidth is reasonable, prevent negative values on very small screens
    final finalCardWidth = cardWidth > 100 ? cardWidth : 150.0; // Minimum width fallback

    return SizedBox(
      height: cardHeight + 20, // Add padding for shadow/visuals
      child: Stack(
        alignment: Alignment.center,
        children: [
          // --- Horizontal List View ---
          Padding(
            // Add padding so arrows don't overlap cards too much
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.packages.length,
              itemBuilder: (context, index) {
                return Padding(
                  // Add spacing between items
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : spacing / 2, // No left padding for first item
                    right: index == widget.packages.length - 1 ? 0 : spacing / 2, // No right padding for last
                  ),
                  child: PackageCard(
                    package: widget.packages[index],
                    width: finalCardWidth, // Pass calculated width
                  ),
                );
              },
            ),
          ),

          // --- Left Arrow ---
          if (_showLeftArrow) // Conditionally show arrow
            Positioned(
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ).copyWith(color: kAppAccentOrange), // Updated arrow background
                child: IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () => _scroll(-(finalCardWidth + spacing)),
                ),
              ),
            ),

          // --- Right Arrow ---
          if (_showRightArrow) // Conditionally show arrow
            Positioned(
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ).copyWith(color: kAppAccentOrange), // Updated arrow background
                child: IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () => _scroll(finalCardWidth + spacing),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// HomeScreen Widget (Updated to use HorizontalPackageList)
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

                  // --- Use the new HorizontalPackageList ---
                  HorizontalPackageList(packages: packages),

                ],
              ),
            ),            
            FooterSection(), // Added FooterSection
            // Add some bottom padding if needed
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// FooterSection Widget
class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  // Define colors for the Kashayam theme footer
  static const Color kLightKashayam = Color(0xFFFFE0B2); // Light Saffron/Ochre
  static const Color kDarkBrownText = Color(0xFF4E342E); // Brown 800 for main text
  static const Color kMediumBrownText = Color(0xFF6D4C41); // Brown 700 for secondary text/icons
  static const Color kBrownDivider = Color(0x556D4C41); // Brown 700 with ~33% opacity for divider

  // Function to launch WhatsApp
  Future<void> _launchWhatsApp() async {
    const String phoneNumber = "+917997990996";
    // Encode the URL properly. For just opening a chat, this is usually enough.
    // For pre-filled messages, you'd add &text=Hello%20World
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Consider showing a SnackBar or dialog if WhatsApp can't be launched
      print("Could not launch WhatsApp");
    }
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: kDarkBrownText, size: 24), // Updated color
      onPressed: onPressed,
    );
  }
  Widget _buildFooterLink(BuildContext context, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(
            color: kMediumBrownText, // Updated color
            fontSize: 14,
            fontFamily: GoogleFonts.poppins().fontFamily,
            decoration: TextDecoration.underline,
            decorationColor: kMediumBrownText // Updated color
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Updated to use temple.jpg background with gradient overlay
      decoration: BoxDecoration(
        color: kLightKashayam, // Updated to light kashayam color
      ),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20), // Reduced vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Vistara on Wheels',
            style: TextStyle(
              color: kDarkBrownText, // Updated color
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          SizedBox(height: 8), // Reduced spacing
          Text(
            'Your trusted partner for comfortable and reliable taxi services in Tirupati.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kMediumBrownText, // Updated color
              fontSize: 15,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          SizedBox(height: 20), // Reduced spacing
          // Directly using Column for Contact Info as Quick Links are removed
          // If more sections were needed, Wrap would be good. For one, Column is fine.
          Column( // Changed from Wrap to Column as QuickLinks is removed
            crossAxisAlignment: CrossAxisAlignment.center, // Center the contact info block
            children: [
              // Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Us', style: TextStyle(color: kDarkBrownText, fontSize: 16, fontWeight: FontWeight.bold)), // Updated color
                  SizedBox(height: 8),
                  Row(children: [Icon(Icons.phone, color: kMediumBrownText, size: 18), SizedBox(width: 8), Text('+91 799 799 0996', style: TextStyle(color: kMediumBrownText, fontSize: 14))]), // Updated color
                  SizedBox(height: 4),
                  Row(children: [Icon(Icons.email, color: kMediumBrownText, size: 18), SizedBox(width: 8), Text('office@vistaraonwheels.com', style: TextStyle(color: kMediumBrownText, fontSize: 14))]), // Updated color
                  SizedBox(height: 4),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.location_on, color: kMediumBrownText, size: 18), SizedBox(width: 8), Expanded(child: Text('1-43/6, KR Nagar, 1st Lane, Near Mangoyard, Tanapalli Road, Tirupati - 517501', style: TextStyle(color: kMediumBrownText, fontSize: 14)))]), // Updated color
                ],
              )
            ],
          ),
          SizedBox(height: 25), // Adjusted spacing
          // Removed "Follow Us" text and social icons row
          // Add a prominent WhatsApp icon to the right
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align to the right
            children: [
              GestureDetector(
                onTap: _launchWhatsApp,
                child: Container(
                  padding: const EdgeInsets.all(15.0), // Adjust padding for size
                  decoration: BoxDecoration(
                    color: Colors.green, // WhatsApp green
                    shape: BoxShape.circle, // Circular background
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline, // Placeholder, consider using a WhatsApp logo asset
                    color: Colors.white,
                    size: 60.0, // Larger icon size
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25), // Adjusted spacing
          Divider(color: kBrownDivider, thickness: 0.5), // Updated color
          SizedBox(height: 15), // Reduced spacing
          Text('© ${DateTime.now().year} Vistara on Wheels. All Rights Reserved.', style: TextStyle(color: kMediumBrownText, fontSize: 12)), // Updated color
        ],
      ),
    );
  }
}

// VistaraOnWheels App Widget (MaterialApp Setup)
class VistaraOnWheels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vistara on Wheels',
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: ThemeData(
        primaryColor: Color(0xFF1A1F2C), // Keep primary color if needed directly
        fontFamily: GoogleFonts.poppins().fontFamily, // Set default font
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1A1F2C), // Base color for scheme generation
          primary: Color(0xFF1A1F2C),    // Explicit primary color (dark blue/grey)
          secondary: kAppAccentOrange,  // Updated: Explicit secondary color (orange)
          brightness: Brightness.light, // Assuming a light theme overall
        ),
        // Define TextTheme explicitly for better control
        textTheme: TextTheme(
           headlineMedium: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
           titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
           bodyMedium: GoogleFonts.poppins(fontSize: 14),
           labelLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold), // For button text
        ).apply( // Apply default text colors
           bodyColor: Colors.black87,
           displayColor: Colors.black,
        ),
        // Define ElevatedButtonTheme globally
         elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kAppAccentOrange, // Updated: Default button background to orange
            foregroundColor: Colors.white,      // Updated: Default button text color to white
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: GoogleFonts.poppins(
               fontSize: 15,
               fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardTheme: CardTheme( // Define CardTheme globally
           elevation: 3,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12),
           ),
           margin: EdgeInsets.zero, // Let HorizontalPackageList handle spacing
        ),
        useMaterial3: true, // Enable Material 3 features
      ),
      home: HomeScreen(),
    );
  }
}
