import 'package:flutter/material.dart';

class LocationControls extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onRefresh;
  final bool showSettingsButton;
  final VoidCallback? onOpenSettings;

  const LocationControls({
    super.key,
    required this.isLoading,
    required this.onRefresh,
    this.showSettingsButton = false,
    this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      right: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showSettingsButton && onOpenSettings != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FloatingActionButton.small(
                onPressed: onOpenSettings,
                backgroundColor: Colors.orange,
                child: const Icon(Icons.settings, color: Colors.white, size: 18),
              ),
            ),
          FloatingActionButton.small(
            onPressed: onRefresh,
            backgroundColor: Colors.white,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
