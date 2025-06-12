// import 'package:flutter/material.dart';
// import 'package:inventech/Core/constant/constant.dart';
// import 'package:inventech/Login_page/data/Datamodel/user_model.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: kWhite,
//       appBar: AppBar(
//         title: const Text("My Profile", style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: kWhite,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Profile Header
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     radius: 50,
//                     backgroundImage: NetworkImage(
//                       "https://i.pravatar.cc/150?img=3", // Replace with your image URL or Asset
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   final user =UserModel;
//                   const Text(
//                     "John Doe",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     "johndoe@example.com",
//                     style: TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Profile Options
//             ListTile(
//               leading: const Icon(Icons.edit, color: Colors.blue),
//               title: const Text("Edit Profile"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // Navigate to Edit Profile
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(
//                 Icons.account_balance_wallet,
//                 color: Colors.green,
//               ),
//               title: const Text("Wallet"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // Navigate to Wallet Page
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.history, color: Colors.orange),
//               title: const Text("Order History"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // Navigate to Order History Page
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.settings, color: Colors.deepPurple),
//               title: const Text("Settings"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // Navigate to Settings
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout, color: Colors.red),
//               title: const Text("Logout"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // Perform Logout
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
