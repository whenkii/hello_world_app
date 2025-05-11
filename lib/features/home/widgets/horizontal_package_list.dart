import 'package:flutter/material.dart';
import '../../../core/models/taxi_package.dart';
import 'package_card.dart';
import '../../../core/constants/app_colors.dart';

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