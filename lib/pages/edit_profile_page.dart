import 'package:flutter/material.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});


  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  bool _isFormValid = false;


  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


  void _validateForm() {
    setState(() {
      _isFormValid = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty;
    });
  }


  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke Home Page
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("First Name"),
              _buildTextField(_firstNameController, "Enter your first name"),
              const SizedBox(height: 15),
              _buildLabel("Last Name"),
              _buildTextField(_lastNameController, "Enter your last name"),
              const SizedBox(height: 15),
              _buildLabel("Email"),
              _buildTextField(_emailController, "Enter your email", email: true),
              const SizedBox(height: 15),
              _buildLabel("Phone"),
              _buildTextField(_phoneController, "Enter your phone number", phone: true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _saveChanges : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? const Color(0xFF497D74) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }


  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool email = false,
    bool phone = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: email
          ? TextInputType.emailAddress
          : phone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return '$hint cannot be empty';
        if (email && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          return 'Enter a valid email address';
        }
        if (phone && !RegExp(r"^\d{10,15}$").hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      },
    );
  }
}
