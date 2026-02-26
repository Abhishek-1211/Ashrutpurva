import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogout() {
    context.read<AuthBloc>().add(AuthLoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _MobileLayout(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onLogout: _handleLogout,
      ),
      desktop: _DesktopLayout(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onLogout: _handleLogout,
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback onLogout;

  const _MobileLayout({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ashrutpurva'),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            onPressed: () => _ThemePicker.show(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _HomeContent(isMobile: true, selectedIndex: selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Poetry'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback onLogout;

  const _DesktopLayout({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Navigation Bar for Web
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'ASH RUT PUR VA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Spacer(),
                _navItem(context, 'Home', 0),
                _navItem(context, 'Poetry', 1),
                _navItem(context, 'Events', 2),
                _navItem(context, 'Profile', 3),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.palette_outlined),
                  onPressed: () => _ThemePicker.show(context),
                  tooltip: 'Themes',
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: onLogout,
                  tooltip: 'Logout',
                ),
              ],
            ),
          ),
          Expanded(
            child: _HomeContent(isMobile: false, selectedIndex: selectedIndex),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String label, int index) {
    final active = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () => onItemTapped(index),
        child: Text(
          label,
          style: TextStyle(
            color: active 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7),
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final bool isMobile;
  final int selectedIndex;
  const _HomeContent({required this.isMobile, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    if (selectedIndex != 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForIndex(selectedIndex),
              size: 64,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '${_getTitleForIndex(selectedIndex)} Section',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Coming soon in the next update...'),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200), // Constrain width on large screens
          padding: EdgeInsets.all(isMobile ? 20.0 : 40.0),
          child: isMobile 
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _contentSections(context),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Content (2/3 width)
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _welcomeMessage(context),
                          const SizedBox(height: 40),
                          _sectionHeader(context, 'Featured Poem'),
                          const SizedBox(height: 16),
                          _featuredCard(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Sidebar (1/3 width)
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100), // Align with main content flow
                          _sectionHeader(context, 'Activities'),
                          const SizedBox(height: 16),
                          _activityGrid(context, crossAxisCount: 1),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 1: return Icons.menu_book;
      case 2: return Icons.event;
      case 3: return Icons.person;
      default: return Icons.help_outline;
    }
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 1: return 'Poetry';
      case 2: return 'Events';
      case 3: return 'Profile';
      default: return 'Unknown';
    }
  }

  List<Widget> _contentSections(BuildContext context) {
    return [
      _welcomeMessage(context),
      const SizedBox(height: 40),
      _sectionHeader(context, 'Featured Poem'),
      const SizedBox(height: 16),
      _featuredCard(context),
      const SizedBox(height: 32),
      _sectionHeader(context, 'Recent Activities'),
      const SizedBox(height: 16),
      _activityGrid(context, crossAxisCount: 2),
    ];
  }

  Widget _welcomeMessage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore the echoes of history through poetry.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: isMobile ? 16 : 18,
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _featuredCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '"The Silent Echo"',
            style: TextStyle(
              fontSize: 28,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'By Anonymous',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            'History is not just dates and wars; it is the silent heartbeat of generations long gone, whispered through the ink and paper of those who dared to remember.',
            style: TextStyle(fontSize: 18, height: 1.6),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Read Full Poem'),
          ),
        ],
      ),
    );
  }

  Widget _activityGrid(BuildContext context, {required int crossAxisCount}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isMobile ? 1.5 : 2.5,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                index == 0 ? Icons.history_edu : Icons.campaign,
                color: Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  index == 0 ? 'Archive Update: New Manuscripts' : 'New Event: Poetry Night',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemePicker {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Theme',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _themeOption(context, AppThemeType.koraClassic, 'Kora Classic (Paper)'),
              _themeOption(context, AppThemeType.midnightMushaira, 'Midnight Mushaira (Dark)'),
              _themeOption(context, AppThemeType.dhartiEarth, 'Dharti Earth (Warm)'),
              _themeOption(context, AppThemeType.monsoonMist, 'Monsoon Mist (Cool)'),
            ],
          ),
        );
      },
    );
  }

  static Widget _themeOption(BuildContext context, AppThemeType type, String label) {
    final palette = AppPalette.fromType(type);
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: palette.background,
          border: Border.all(color: palette.primary),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: palette.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      title: Text(label),
      onTap: () {
        context.read<ThemeCubit>().updateTheme(type);
        Navigator.pop(context);
      },
    );
  }
}
