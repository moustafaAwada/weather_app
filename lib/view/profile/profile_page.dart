import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/auth_cubit/auth_states.dart';
import 'update_profile_page.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 1. Consistent Blue Sky Gradient
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade800, Colors.blue.shade300],
        ),
      ),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 2. Avatar with Shadow and Border
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 70, color: Colors.blue.shade300),
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    Text(
                      state.user.name,
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white
                      ),
                    ),
                    Text(
                      "Weather Enthusiast", 
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 30),

                    // 3. Info Card
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoTile(Icons.email, "Email", state.user.email),
                          Divider(),
                          _buildInfoTile(Icons.phone, "Phone", state.user.phone ?? "Not set"),
                          SizedBox(height: 20),
                          
                          // Edit Button
                          ElevatedButton.icon(
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateProfilePage(user: state.user)));
                            },
                            icon: Icon(Icons.edit),
                            label: Text("Edit Profile"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // 4. Logout Button (Styled as Text Button with Red)
                    TextButton.icon(
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16)),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator(color: Colors.white));
        },
      ),
    );
  }

  // Helper widget to create list tiles easily
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
    );
  }
}