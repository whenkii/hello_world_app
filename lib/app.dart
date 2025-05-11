import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'features/home/screens/home_screen.dart';

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