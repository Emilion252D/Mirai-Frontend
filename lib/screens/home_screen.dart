import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';
import '../widgets/mirai_bottom_nav.dart';
import '../widgets/mirai_drawer.dart';
import 'catalog_screen.dart';
import 'rating_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentNavIndex = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onAddModel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _AddModelSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.bg,
      drawer: const MiraiDrawer(),
      body: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            // ── App Bar ──────────────────────────────────────
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              backgroundColor: MiraiColors.violet,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF7C5CD4),
                        MiraiColors.violet,
                        Color(0xFF4A2EA8),
                      ],
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  // ── Menu button (top-left) ──
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Добрый день',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Алина ✦',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notification + Avatar
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white.withOpacity(0.6),
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'АС',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Content ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // ── Add 3D Model Card ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _Add3DModelCard(
                      onTap: _onAddModel,
                      pulseAnimation: _pulseAnimation,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── AI Tip Banner ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _AITipBanner(),
                  ),

                  const SizedBox(height: 24),

                  // ── Popular Styles ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _PopularStyles(),
                  ),

                  const SizedBox(height: 24),

                  // ── Trending Catalog ──
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _TrendingSection(),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MiraiBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (i) {
          if (i == 2) {
            _onAddModel();
          } else if (i == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CatalogScreen()));
          } else if (i == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const RatingScreen()));
          } else {
            setState(() => _currentNavIndex = i);
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ADD 3D MODEL CARD
// ─────────────────────────────────────────────────────────────────────────────
class _Add3DModelCard extends StatelessWidget {
  final VoidCallback onTap;
  final Animation<double> pulseAnimation;

  const _Add3DModelCard({
    required this.onTap,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MiraiColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: MiraiColors.border, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: MiraiColors.violet.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Column(
          children: [
            // Animated circle with add icon
            AnimatedBuilder(
              animation: pulseAnimation,
              builder: (_, child) => Transform.scale(
                scale: pulseAnimation.value,
                child: child,
              ),
              child: GestureDetector(
                onTap: onTap,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow ring
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MiraiColors.violet.withOpacity(0.06),
                      ),
                    ),
                    // Mid ring
                    Container(
                      width: 116,
                      height: 116,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MiraiColors.violetLight,
                        border: Border.all(
                          color: MiraiColors.violetMid,
                          width: 1.5,
                        ),
                      ),
                    ),
                    // Inner circle with + icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8B6AE0),
                            MiraiColors.violet,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MiraiColors.violet.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Создать 3D-модель',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MiraiColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Сфотографируй голову спереди —\nMirai создаст твою 3D-модель',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: MiraiColors.textMuted,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 24),

            // CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.camera_alt_rounded, size: 20),
                label: const Text('Добавить 3D-модель'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MiraiColors.violet,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Secondary button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: MiraiColors.violet,
                  side: const BorderSide(color: MiraiColors.violetMid),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Загрузить фото из галереи',
                  style: GoogleFonts.inter(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AI TIP BANNER
// ─────────────────────────────────────────────────────────────────────────────
class _AITipBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MiraiColors.violet.withOpacity(0.08),
            MiraiColors.violet.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MiraiColors.violetMid, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: MiraiColors.violetLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: MiraiColors.violet,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI-рекомендации',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: MiraiColors.violet,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Добавь модель — получишь персональные советы по прическе',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: MiraiColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: MiraiColors.textMuted,
            size: 18,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// POPULAR STYLES
// ─────────────────────────────────────────────────────────────────────────────
class _PopularStyles extends StatefulWidget {
  @override
  State<_PopularStyles> createState() => _PopularStylesState();
}

class _PopularStylesState extends State<_PopularStyles> {
  int _selected = 0;
  final List<String> _styles = [
    'Трендовые',
    'Классика',
    'Боб',
    'Пикси',
    'Кудри',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Популярные стили',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: MiraiColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              _styles.length,
              (i) => GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: i < _styles.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _selected == i
                        ? MiraiColors.violet
                        : MiraiColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _selected == i
                          ? MiraiColors.violet
                          : MiraiColors.border,
                    ),
                  ),
                  child: Text(
                    _styles[i],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _selected == i
                          ? Colors.white
                          : MiraiColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TRENDING SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    final items = [
      _TrendItem('Французское каре', '★ 4.9', const Color(0xFFEDE8FC),
          Icons.content_cut_rounded, const Color(0xFF6C47C4)),
      _TrendItem('Вечерний макияж', '★ 4.7', const Color(0xFFFCE8F0),
          Icons.face_retouching_natural_rounded, const Color(0xFFD85A80)),
      _TrendItem('Украшения', '★ 4.8', const Color(0xFFE8F5E9),
          Icons.diamond_rounded, const Color(0xFF1D9E75)),
      _TrendItem('Очки', '★ 4.6', const Color(0xFFFFF8E1),
          Icons.visibility_rounded, const Color(0xFFE8A020)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Трендовые образы',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: MiraiColors.textPrimary,
              ),
            ),
            Text(
              'Все →',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: MiraiColors.violet,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.1,
          children: items.map((item) => _TrendCard(item: item)).toList(),
        ),
      ],
    );
  }
}

class _TrendItem {
  final String name;
  final String rating;
  final Color bgColor;
  final IconData icon;
  final Color iconColor;

  const _TrendItem(
      this.name, this.rating, this.bgColor, this.icon, this.iconColor);
}

class _TrendCard extends StatelessWidget {
  final _TrendItem item;
  const _TrendCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MiraiColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MiraiColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: item.bgColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: MiraiColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Примерить',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: MiraiColors.violet,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ADD MODEL BOTTOM SHEET
// ─────────────────────────────────────────────────────────────────────────────
class _AddModelSheet extends StatelessWidget {
  const _AddModelSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      decoration: const BoxDecoration(
        color: MiraiColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 44,
            height: 5,
            margin: const EdgeInsets.only(top: 14, bottom: 24),
            decoration: BoxDecoration(
              color: MiraiColors.border,
              borderRadius: BorderRadius.circular(3),
            ),
          ),

          Text(
            'Добавить 3D-модель',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MiraiColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Выберите способ создания модели',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: MiraiColors.textMuted,
            ),
          ),
          const SizedBox(height: 24),

          // Options
          _SheetOption(
            icon: Icons.camera_alt_rounded,
            iconBg: MiraiColors.violetLight,
            iconColor: MiraiColors.violet,
            title: 'Сфотографировать',
            subtitle: 'Открыть камеру и сделать фото',
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 10),
          _SheetOption(
            icon: Icons.photo_library_rounded,
            iconBg: const Color(0xFFE1F5EE),
            iconColor: MiraiColors.green,
            title: 'Из галереи',
            subtitle: 'Выбрать фото из вашего альбома',
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 10),
          _SheetOption(
            icon: Icons.people_alt_rounded,
            iconBg: const Color(0xFFFAEEDA),
            iconColor: const Color(0xFF854F0B),
            title: 'Для другого человека',
            subtitle: 'Создать модель не для себя',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SheetOption({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: MiraiColors.bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MiraiColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MiraiColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: MiraiColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: MiraiColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
