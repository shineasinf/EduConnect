// educonnect_mockup.dart
// Simplified version — removed Reconciliation menu
// Flutter SDK >=2.12 (null safety)

import 'package:flutter/material.dart';

void main() {
  runApp(EduConnectMockApp());
}

class EduConnectMockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConnect Mockup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduConnect — ${_titles[_selectedIndex]}'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[800],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: Text('New Payment'),
              icon: Icon(Icons.add),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[700]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.school, color: Colors.blue[700], size: 36),
                  ),
                  SizedBox(height: 12),
                  Text('SMP Harapan Bangsa',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 4),
                  Text('Admin • admin@school.id',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('School Info'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Bank & Payment Setup'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('Reports'),
              onTap: () {},
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Pages ----------
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          SizedBox(height: 16),
          _buildRecentPaymentsCard(),
          SizedBox(height: 16),
          _buildMessagesCard(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _SummaryCard(title: 'Total Collected', amount: 'IDR 120.450.000')),
        SizedBox(width: 12),
        Expanded(child: _SummaryCard(title: 'Pending', amount: 'IDR 12.500.000')),
        SizedBox(width: 12),
        Expanded(child: _SummaryCard(title: 'Students', amount: '560')),
      ],
    );
  }

  Widget _buildRecentPaymentsCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Payments', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(child: Text('S${i + 1}')),
                  title: Text('SPP Month ${i + 1}'),
                  subtitle: Text('Parent: Budi — IDR 350.000'),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Messages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: Text('See all'))
              ],
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('Field Trip Reminder'),
              subtitle: Text('Tomorrow: Bring permission slip'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('New Parent Message'),
              subtitle: Text('Question about payments'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  const _SummaryCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 8),
            Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class PaymentsPage extends StatelessWidget {
  final List<Map<String, String>> samplePayments = List.generate(6, (i) => {
        'title': 'SPP Bulan ${i + 1}',
        'amount': 'IDR ${300000 + i * 25000}',
        'status': i % 3 == 0 ? 'paid' : (i % 3 == 1 ? 'pending' : 'overdue')
      });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: samplePayments.length,
      itemBuilder: (context, i) {
        final p = samplePayments[i];
        return Card(
          child: ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text(p['title']!),
            subtitle: Text(p['amount']! + ' • Status: ${p['status']}'),
            trailing: _statusIcon(p['status']!),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => PaymentDetailSheet(payment: p),
              );
            },
          ),
        );
      },
    );
  }

  Widget _statusIcon(String status) {
    if (status == 'paid') return Icon(Icons.check_circle, color: Colors.green);
    if (status == 'pending') return Icon(Icons.hourglass_empty, color: Colors.orange);
    return Icon(Icons.error, color: Colors.red);
  }
}

class PaymentDetailSheet extends StatelessWidget {
  final Map<String, String> payment;
  const PaymentDetailSheet({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(payment['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Amount: ${payment['amount']}'),
          SizedBox(height: 8),
          Text('Status: ${payment['status']}'),
          SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(onPressed: () {}, icon: Icon(Icons.qr_code), label: Text('Pay via QR')),
              SizedBox(width: 12),
              OutlinedButton(onPressed: () {}, child: Text('Mark as Paid')),
            ],
          ),
        ],
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search messages or parents...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: 8,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, i) {
              return ListTile(
                leading: CircleAvatar(child: Text('P${i + 1}')),
                title: Text('Parent ${i + 1}'),
                subtitle: Text('Message preview — please confirm payment'),
                trailing: Text('2m'),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Admin — SMP Harapan Bangsa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('admin@school.id'),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          ListTile(leading: Icon(Icons.settings), title: Text('App Settings')),
          ListTile(leading: Icon(Icons.receipt), title: Text('Payment Settings')),
          ListTile(leading: Icon(Icons.account_tree), title: Text('Manage Classes & Students')),
        ],
      ),
    );
  }
}
