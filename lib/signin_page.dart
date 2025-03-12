import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'forgot_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Menutup keyboard saat klik di luar
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    // Email Input
                    const Text('Email', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                        if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password Input
                    const Text('Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
                        if (value.length < 6) return 'Password harus minimal 6 karakter';
                        return null;
                      },
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                        },
                        child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF497D74))),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Implementasi logika Sign In
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login berhasil!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF497D74),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Sign In', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Divider with OR
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR', style: TextStyle(color: Colors.grey[600])),
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Google Sign In
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Implementasi Google Sign In
                        },
                        icon: Image.asset('assets/google_logo.png', height: 24, width: 24),
                        label: const Text('Sign in with Google', style: TextStyle(color: Colors.black87)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign Up Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                          },
                          child: const Text('Sign Up', style: TextStyle(color: Color(0xFF497D74), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
