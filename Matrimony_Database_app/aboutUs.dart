// import 'package:flutter/material.dart';
//
// class AboutUsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About Us'),
//         backgroundColor: Color(0xFFD1B2D1), // Light purple header
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/background.png'), // Background image
//             fit: BoxFit.cover,
//           ),
//         ),
//         padding: EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 color: Color(0xFFC9A4C9), // Light purple matching theme
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Icon(Icons.favorite, size: 50, color: Colors.white),
//                       SizedBox(height: 10),
//                       Text(
//                         'Welcome to Matrimonial App!',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Finding a life partner is an important step, and we are here to make this journey smooth and meaningful for you. Our platform ensures secure and genuine connections.',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Mission Section
//               buildInfoCard(
//                 title: "Our Mission",
//                 content:
//                 "Our mission is to connect hearts and build lifelong relationships through a trusted and transparent platform.",
//                 icon: Icons.next_plan,
//               ),
//
//               // Vision Section
//               buildInfoCard(
//                 title: "Our Vision",
//                 content:
//                 "We envision a world where love knows no barriers. Our goal is to bring people together based on compatibility, values, and trust.",
//                 icon: Icons.visibility,
//               ),
//
//               // Services Section
//               buildInfoCard(
//                 title: "Our Services",
//                 content:
//                 "✔ Verified Profiles\n✔ Advanced Matchmaking Algorithm\n✔ Privacy Protection\n✔ Chat and Video Call Features\n✔ Wedding Planning Assistance",
//                 icon: Icons.handshake,
//               ),
//
//               // Contact Information
//               buildInfoCard(
//                 title: "Contact Us",
//                 content:
//                 "📍 Address: 123 Matrimony Street, Love City\n📞 Phone: +123 456 7890\n📧 Email: support@matrimonialapp.com\n🌍 Website: www.matrimonialapp.com",
//                 icon: Icons.contact_mail,
//               ),
//
//               SizedBox(height: 20),
//
//               // Back Button
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back, color: Colors.white),
//                 label: Text('Go Back'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFD1B2D1), // Light pink button
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget to create an info card
//   Widget buildInfoCard({required String title, required String content, required IconData icon}) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       color: Colors.white.withOpacity(0.9),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, size: 40, color: Color(0xFFC9A4C9)),
//             SizedBox(height: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 8),
//             Text(
//               content,
//               style: TextStyle(fontSize: 14, color: Colors.black87),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Color(0xFFD1B2D1), // Light purple header
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 50, color: Color(0xFFC9A4C9)),
            SizedBox(height: 10),
            Text(
              'Welcome to Matrimonial App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'We help people find their perfect life partner with a simple, safe, and trusted matchmaking platform.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '📞 +123 456 7890\n📧 support@matrimonialapp.com',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD1B2D1), // Light pink button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
