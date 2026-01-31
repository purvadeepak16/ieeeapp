import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../core/theme/app_colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
  }
  Future<void> _pickImage() async {
  final XFile? image =
      await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    setState(() {
      selectedImage = File(image.path);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          AppColors.primaryBlue.withOpacity(0.15),
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : widget.user.photoPath != null
                              ? FileImage(File(widget.user.photoPath!))
                              : null,
                      child: selectedImage == null &&
                              widget.user.photoPath == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primaryBlue,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone number"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.user.copyWith(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    photoPath: selectedImage?.path,
                  ),
                );
              },

              child: const Text("UPDATE PROFILE"),
            ),
          ],
        ),
      ),
    );
  }
}
