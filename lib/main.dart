// educonnect_modern.dart
// Modernized mockup with improved mobile UI
// Flutter SDK >=3.0 (null safety)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(EduConnectApp());
}

class EduConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConnect',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final _pages = [
    DashboardPage(),
    PaymentsPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  final _titles = [
    'Dashboard',
    'Payments',
    'Messages',
    'Profile',
  ];

  void _onTap(int i) => setState(() => _selectedIndex = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex],
            style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: "Dashboard"),
          NavigationDestination(icon: Icon(Icons.payment), label: "Payments"),
          NavigationDestination(icon: Icon(Icons.message), label: "Messages"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text("New Payment"),
              onPressed: () {},
            )
          : null,
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.school, size: 36, color: Colors.indigo),
              ),
              accountName: Text("SMP Harapan Bangsa"),
              accountEmail: Text("Admin • admin@school.id"),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("School Info"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Bank & Payment Setup"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text("Reports"),
              onTap: () {},
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Dashboard ------------------
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: _SummaryCard("Total Collected", "IDR 120.450.000", Colors.green)),
            SizedBox(width: 12),
            Expanded(child: _SummaryCard("Pending", "IDR 12.500.000", Colors.orange)),
            SizedBox(width: 12),
            Expanded(child: _SummaryCard("Students", "560", Colors.blue)),
          ],
        ),
        SizedBox(height: 20),
        _SectionCard(
          title: "Recent Payments",
          child: Column(
            children: List.generate(4, (i) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo.shade100,
                  child: Text("S${i + 1}"),
                ),
                title: Text("SPP Month ${i + 1}"),
                subtitle: Text("Parent: Budi — IDR 350.000"),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              );
            }),
          ),
        ),
        SizedBox(height: 20),
        _SectionCard(
          title: "Recent Messages",
          trailing: TextButton(onPressed: () {}, child: Text("See all")),
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text("Field Trip Reminder"),
                subtitle: Text("Tomorrow: Bring permission slip"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("New Parent Message"),
                subtitle: Text("Question about payments"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title, value;
  final Color color;
  const _SummaryCard(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
            SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  const _SectionCard({required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                if (trailing != null) trailing!,
              ],
            ),
            Divider(),
            child,
          ],
        ),
      ),
    );
  }
}

// ------------------ Payments ------------------
class PaymentsPage extends StatelessWidget {
  final List<Map<String, String>> payments = List.generate(6, (i) => {
        "title": "SPP Bulan ${i + 1}",
        "amount": "IDR ${300000 + i * 25000}",
        "status": i % 3 == 0 ? "paid" : (i % 3 == 1 ? "pending" : "overdue")
      });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: payments.length,
      itemBuilder: (context, i) {
        final p = payments[i];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.receipt_long, color: Colors.indigo),
            title: Text(p["title"]!),
            subtitle: Text("${p["amount"]} • ${(p["status"] ?? '').toUpperCase()}"),
            trailing: _statusIcon(p["status"]!),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                builder: (_) => PaymentDetailSheet(payment: p),
              );
            },
          ),
        );
      },
    );
  }

  Icon _statusIcon(String status) {
    if (status == "paid") return Icon(Icons.check_circle, color: Colors.green);
    if (status == "pending") return Icon(Icons.hourglass_empty, color: Colors.orange);
    return Icon(Icons.error, color: Colors.red);
  }
}

class PaymentDetailSheet extends StatelessWidget {
  final Map<String, String> payment;
  const PaymentDetailSheet({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(payment["title"]!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Amount: ${payment["amount"]}"),
          SizedBox(height: 8),
          Text("Status: ${payment["status"]}"),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.qr_code),
                  label: Text("Pay via QR")),
              SizedBox(width: 12),
              OutlinedButton(onPressed: () {}, child: Text("Mark as Paid")),
            ],
          )
        ],
      ),
    );
  }
}

// ------------------ Messages ------------------
class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search messages...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: 8,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, i) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo.shade100,
                  child: Text("P${i + 1}"),
                ),
                title: Text("Parent ${i + 1}"),
                subtitle: Text("Message preview — please confirm payment"),
                trailing: Text("2m"),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ------------------ Profile ------------------
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.indigo.shade100,
              child: Icon(Icons.person, size: 36, color: Colors.indigo),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Admin — SMP Harapan Bangsa",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("admin@school.id"),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Card(
          child: Column(
            children: const [
              ListTile(leading: Icon(Icons.settings), title: Text("App Settings")),
              Divider(),
              ListTile(
                  leading: Icon(Icons.receipt), title: Text("Payment Settings")),
              Divider(),
              ListTile(
                  leading: Icon(Icons.account_tree),
                  title: Text("Manage Classes & Students")),
            ],
          ),
        ),
      ],
    );
  }
}

