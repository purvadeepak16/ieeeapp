import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const double fieldHeight = 45; // EXACT from Figma

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 14),

              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2A66),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 20),
                    onPressed: () => context.go('/login'),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logos/ieee_main_logo.png',
                    height: 34,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'IEEE-VESIT',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2A66),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5B6B8C),
                ),
              ),

              const SizedBox(height: 28),

              _shadowInput(Icons.person, 'Username'),
              const SizedBox(height: 14),
              _shadowInput(Icons.email, 'Email'),
              const SizedBox(height: 14),
              _shadowInput(Icons.lock, 'Password', obscure: true),
              const SizedBox(height: 14),
              _shadowInput(Icons.lock_outline, 'Confirm Password',
                  obscure: true),

              const SizedBox(height: 28),

              _registerButton(context),

              const SizedBox(height: 28),

              const Text(
                '— Or Register with Google —',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5B6B8C),
                ),
              ),

              const SizedBox(height: 22),

              Center(
                child: _socialIcon('google_logo.png'),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A2A66),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INPUT WITH SHADOW =================

  Widget _shadowInput(
      IconData icon,
      String hint, {
        bool obscure = false,
      }) {
    return Container(
      height: fieldHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFD1D5DB),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF0A2A66),
              width: 1.2,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9AA3AF),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Container(
            width: fieldHeight,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF0A2A66),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }

  // ================= REGISTER BUTTON =================

  Widget _registerButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A2A66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () => context.go('/home'),
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ================= GOOGLE ICON =================

  Widget _socialIcon(String asset) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logos/$asset',
          height: 26,
          width: 26,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
