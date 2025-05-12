import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../../../shared_widgets/custom_button.dart';

class HeroSection extends StatelessWidget {
  // Function to launch WhatsApp with the given phone number
  Future<void> _launchWhatsApp() async {
    const String phoneNumber = "+917997990996";
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Consider showing a SnackBar or dialog if WhatsApp can't be launched
      // For a production app, you'd likely want a more user-friendly message.
      print("Could not launch WhatsApp");
      // Example of showing a SnackBar:
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('WhatsApp is not installed or accessible.')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20), // Adjusted vertical padding
      decoration: BoxDecoration(
        // Add the background image
        image: DecorationImage(
          image: AssetImage('temple.jpg'), // Ensure this path is correct and image is in pubspec.yaml
          fit: BoxFit.cover, // Cover the entire area
        ),
        // Apply a gradient overlay to potentially darken the background slightly
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.4), // Darker overlay at the top-left
            Colors.black.withOpacity(0.2), // Slightly less dark at the bottom-right
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center column content horizontally
          children: [
            // Logo and Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the row content
              crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
              children: [
                // VOW Logo
                Image.asset(
                  'VOW-logo-preview.png', // Path to your VOW logo image
                  width: 80.0, // Adjust size as needed
                  height: 80.0, // Adjust size as needed
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 20), // Space between logo and title
                // Title and Slogan Column
                Expanded( // Allows the text column to take remaining space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        'VISTARA ON WHEELS',
                        textAlign: TextAlign.left, // Align text left
                        style: TextStyle(
                          color: Colors.white, // Keep text color white
                          fontSize: 32, // Slightly smaller font size to fit
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.8),
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Your Journey, Our Passion',
                        textAlign: TextAlign.left, // Align text left
                        style: TextStyle(
                          color: Colors.white, // Keep text color white
                          fontSize: 16, // Slightly smaller font size
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black.withOpacity(0.7),
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), // Space between logo/title and button
            // Book Now Button now launches WhatsApp
            CustomButton(
              text: 'Book Now',
              onPressed: () {
                _launchWhatsApp(); // Call the WhatsApp launch function
                print("Book Now Tapped - Launching WhatsApp"); // Optional log
              },
            ),
            SizedBox(height: 30), // Increased spacing for the prominent WhatsApp section
            // Prominent WhatsApp Contact Section (still launches WhatsApp)
            GestureDetector(
              onTap: _launchWhatsApp, // Tap the whole section to launch WhatsApp
              child: Column( // Use Column to stack image and text vertically
                children: [
                  Image.asset(
                    'Digital_Stacked_Green.png', // Path to your WhatsApp image
                    width: 80.0, // Made the image even bigger
                    height: 80.0, // Made the image even bigger
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10), // Space between image and text
                  Text(
                    'Click to reach out on WhatsApp',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.greenAccent[400], // Changed text color to green
                      fontSize: 18, // Slightly larger font size
                      fontWeight: FontWeight.bold, // Made text bold
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      shadows: [ // Add shadow for visibility
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.6),
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}