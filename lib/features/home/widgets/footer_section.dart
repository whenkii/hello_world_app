import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Widget _buildSocialIcon(IconData icon, VoidCallback onPressed) { // Kept for reference if needed later
  //   return IconButton(
  //     icon: Icon(icon, color: kDarkBrownText, size: 24), // Updated color
  //     onPressed: onPressed,
  //   );
  // }
  // Widget _buildFooterLink(BuildContext context, String text, VoidCallback onPressed) { // Kept for reference
  //   return GestureDetector(
  //     onTap: onPressed,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 4.0),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           color: kMediumBrownText, // Updated color
  //           fontSize: 14,
  //           fontFamily: GoogleFonts.poppins().fontFamily,
  //           decoration: TextDecoration.underline,
  //           decorationColor: kMediumBrownText // Updated color
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                  // The green circular background is removed as the image likely has its own.
                  // Adjust width and height as needed for your image.
                  child: Image.asset(
                    'Digital_Stacked_Green.png', // Path to your WhatsApp image
                    width: 70.0, // Desired width of the image
                    height: 70.0, // Desired height of the image
                    fit: BoxFit.contain, // Adjust fit as needed (contain, cover, etc.)
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