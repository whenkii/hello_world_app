import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import '../../../core/models/taxi_package.dart';

class PackageCard extends StatelessWidget {
  final TaxiPackage package;
  final double? width;
  final VoidCallback? onSelect;

  const PackageCard({
    Key? key,
    required this.package,
    this.width,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a custom saffron color (you can adjust this Hex code)
    const Color saffronColor = Color(0xFFFFA500); // A vibrant orange/saffron
    const Color lightSaffronColor = Color(0xFFFFD700); // A lighter goldenrod/saffron

    return SizedBox(
      width: width,
      child: Card(
        elevation: 4, // Increased elevation for a more pronounced look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // More rounded corners
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.white, // Pure white background for contrast
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Name (Styled - Light Saffron Header)
              Text(
                package.name,
                style: GoogleFonts.poppins(
                  fontSize: 22, // Larger header font size
                  fontWeight: FontWeight.bold,
                  color: lightSaffronColor, // Light saffron color for the header
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16), // Increased space

              // Package Description (Styled - Slightly bolder)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    package.description,
                    style: GoogleFonts.openSans(
                      fontSize: 15, // Slightly larger description text
                      height: 1.6, // Increased line height
                      color: Colors.black87, // Darker color for better contrast
                      fontWeight: FontWeight.w500, // Slightly bolder
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Increased space

              // Select Button (Styled - Saffron)
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: onSelect, // This still calls the onSelect (WhatsApp launch) function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: saffronColor, // Saffron color for the button background
                    foregroundColor: Colors.white, // White text color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Larger button padding
                    textStyle: GoogleFonts.poppins( // Use Poppins for button text
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // Semi-bold button text
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded button corners
                    ),
                    elevation: 5, // Button elevation
                  ),
                  child: const Text('Select'), // Changed button text back to "Select"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}