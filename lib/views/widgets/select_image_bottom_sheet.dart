import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageBottomSheet extends StatefulWidget {
  XFile? image;
   SelectImageBottomSheet({super.key,required this.image});

  @override
  State<SelectImageBottomSheet> createState() => _SelectImageBottomSheetState();
}

class _SelectImageBottomSheetState extends State<SelectImageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
          children: [
            // Semi-transparent background overlay
            GestureDetector(
              onTap: () => Navigator.pop(
                  context), // Close the sheet when background is tapped
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent background
              ),
            ),
            Align(
              alignment:
                  Alignment.bottomCenter, // Align the content at the bottom
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyLarge?.color ==
                            Colors.white
                        ? const Color(0xff100C26)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                        color: Colors.transparent), // Transparent side borders
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Adjust the height based on content
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 72,
                              width: 72,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xff004CFF),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Choose from gallery or",
                            style: TextStyle(
                              color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color ==
                                      Colors.white
                                  ? Colors.white
                                  : const Color(0xff0C091C),
                              fontFamily: "Pulp",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "click with camera",
                            style: TextStyle(
                              color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color ==
                                      Colors.white
                                  ? Colors.white
                                  : const Color(0xff0C091C),
                              fontFamily: "Pulp",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Choose a photo that represents you.",
                            style: TextStyle(
                              color: const Color(0xff948FAD),
                              fontFamily: "Pulp",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Upload from gallery or take a picture",
                            style: TextStyle(
                              color: const Color(0xff948FAD),
                              fontFamily: "Pulp",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "instantly!",
                            style: TextStyle(
                              color: const Color(0xff948FAD),
                              fontFamily: "Pulp",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                      try {
                                        final XFile? image =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (image != null) {
                                       if(this.mounted){
                                           setState(() {
                                            widget.image = image;
                                          });
                                       }
                                        }
                                      } catch (e) {
                                        print(
                                            "Error picking image from gallery: $e");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color ==
                                                Colors.white
                                            ? Colors.white.withOpacity(0.06)
                                            : const Color(0xff0C091C),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 19),
                                        child: Center(
                                          child: Text(
                                            "Choose from gallery",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Pulp",
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                      try {
                                        final XFile? image =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.camera,
                                        );
                                        if (image != null) {
                                     if(this.mounted){
                                           setState(() {
                                            widget.image = image;
                                          });
                                     }
                                        }
                                      } catch (e) {
                                        print(
                                            "Error picking image from camera: $e");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xff5858CC),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 19),
                                        child: Center(
                                          child: Text(
                                            "Click From Camera",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Pulp",
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}