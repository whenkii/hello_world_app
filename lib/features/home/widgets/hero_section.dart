import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared_widgets/custom_button.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        // Add the background image
        image: DecorationImage(
          image: AssetImage('temple.jpg'), // Ensure this path is correct and image is in pubspec.yaml
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