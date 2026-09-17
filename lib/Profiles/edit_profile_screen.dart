import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Initial profile values
  final String _initialName = 'Sarima Hassan';
  final String _initialEmail = 'sarima.hassan@email.com';
  final String _initialPhone = '0806 123 4567';
  final String _initialGender = 'Female';
  final String _initialDob = '14 July 1994';
  final String _initialAddress = '12 Victoria Island, Lagos, Nigeria';

  // Text Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _genderController;
  late final TextEditingController _dobController;
  late final TextEditingController _addressController;

  bool _isFormChanged = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _initialName);
    _emailController = TextEditingController(text: _initialEmail);
    _phoneController = TextEditingController(text: _initialPhone);
    _genderController = TextEditingController(text: _initialGender);
    _dobController = TextEditingController(text: _initialDob);
    _addressController = TextEditingController(text: _initialAddress);

    // Listen to field changes to enable/disable button
    _nameController.addListener(_checkFormChanges);
    _emailController.addListener(_checkFormChanges);
    _phoneController.addListener(_checkFormChanges);
    _genderController.addListener(_checkFormChanges);
    _dobController.addListener(_checkFormChanges);
    _addressController.addListener(_checkFormChanges);
  }

  void _checkFormChanges() {
    final hasChanged = _nameController.text != _initialName ||
        _emailController.text != _initialEmail ||
        _phoneController.text != _initialPhone ||
        _genderController.text != _initialGender ||
        _dobController.text != _initialDob ||
        _addressController.text != _initialAddress;

    if (hasChanged != _isFormChanged) {
      setState(() {
        _isFormChanged = hasChanged;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: topPadding + 12),

          // 1. App Bar Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF0B192C),
                    size: 22,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                ),
                const SizedBox(width: 22),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Profile Image with Edit Badge
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=250',
                              ),
                            ),
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0B192C),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Change Photo',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B192C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Form Fields
                  _buildInputField(
                    label: 'Full Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),

                  _buildInputField(
                    label: 'Email Address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  _buildInputField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  _buildInputField(
                    label: 'Gender',
                    controller: _genderController,
                  ),
                  const SizedBox(height: 16),

                  _buildInputField(
                    label: 'Date of Birth',
                    controller: _dobController,
                  ),
                  const SizedBox(height: 16),

                  _buildInputField(
                    label: 'Residential Address',
                    controller: _addressController,
                  ),

                  const SizedBox(height: 32),

                  // Save Changes Button (Active / Disabled Dynamic State)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isFormChanged
                          ? () {
                        // Perform save action
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC727),
                        disabledBackgroundColor: const Color(0xFFF4F4F5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _isFormChanged
                              ? const Color(0xFF0B192C)
                              : const Color(0xFFA1A1AA),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0B192C),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}