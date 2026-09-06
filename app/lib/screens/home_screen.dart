import 'package:flutter/material.dart';
import '../widgets/crown_logo.dart';
import '../widgets/energy_core.dart';
import '../widgets/status_bar.dart';
import '../widgets/nav_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  @override
  void initState() {
    super.initState();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(['Trade', 'Wallet', 'AI', 'Settings'][index] + ' tapped (placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeController,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              const CrownLogo(),
              const SizedBox(height: 8),
              const StatusBar(),
              const SizedBox(height: 20),
              const Expanded(
                child: Center(child: EnergyCore()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: NavCard(
                        tag: 'trade',
                        icon: Icons.show_chart,
                        label: 'Trade',
                        color: Colors.blueAccent,
                        onTap: () => _onNavTapped(0),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NavCard(
                        tag: 'wallet',
                        icon: Icons.account_balance_wallet,
                        label: 'Wallet',
                        color: Colors.tealAccent,
                        onTap: () => _onNavTapped(1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NavCard(
                        tag: 'ai',
                        icon: Icons.memory,
                        label: 'AI',
                        color: Colors.purpleAccent,
                        onTap: () => _onNavTapped(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NavCard(
                        tag: 'settings',
                        icon: Icons.settings,
                        label: 'Settings',
                        color: Colors.orangeAccent,
                        onTap: () => _onNavTapped(3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Trade'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
