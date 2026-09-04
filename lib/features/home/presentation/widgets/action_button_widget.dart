import 'dart:ui';
import 'package:flutter/material.dart';

class ActionButtonItem {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const ActionButtonItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFF262626),
    this.iconColor = Colors.white,
  });
}

class ActionButton extends StatefulWidget {
  final ActionButtonItem item;
  const ActionButton({super.key, required this.item});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
    reverseDuration: const Duration(milliseconds: 260),
  );

  late final Animation<double> _scale = Tween<double>(
    begin: 1.0,
    end: 0.90,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
    reverseCurve: Curves.elasticOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDown(_) => _controller.forward();
  void _onUp(_) => _controller.reverse();
  void _onCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double outerSize = constraints.maxWidth;
        final double innerInset = outerSize * 0.06;
        final double iconSize = outerSize * 0.34;
        final double innerRadius = outerSize * 0.6;
        final double crescentHeight = outerSize * 0.06; // vertical offset amount

        // Lighter tint of the same color — this is the "base" showing through
        final Color rimColor = Color.lerp(item.color, Colors.white, 0.30)!;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _onDown,
          onTapUp: (details) {
            _onUp(details);
            item.onTap();
          },
          onTapCancel: _onCancel,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Deep elongated ambient shadow
                  Positioned(
                    top: outerSize * 0.18,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: outerSize * 0.16,
                        sigmaY: outerSize * 0.20,
                      ),
                      child: Container(
                        width: outerSize * 0.78,
                        height: outerSize * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(outerSize * 0.4),
                          color: Colors.black.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                  ),

                  // Actual button
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(scale: _scale.value, child: child);
                    },
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: Container(
                        width: outerSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(outerSize * 0.42),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFFFFFFF), Color(0xFFE3E3E6)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.14),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(innerInset),
                          child: DecoratedBox(
                            // subtle highlight on the whole pill, kept separate
                            // from the fill color which now lives in the Stack
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(innerRadius),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(innerRadius),
                              child: Stack(
                                children: [
                                  // BASE layer — the lighter rim color,
                                  // fills the full pill, sits behind everything
                                  AnimatedBuilder(
                                    animation: _controller,
                                    builder: (context, _) {
                                      return Positioned.fill(
                                        child: Opacity(
                                          opacity: 1.0 - _controller.value,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: rimColor,
                                              borderRadius: BorderRadius.circular(innerRadius),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // TOP layer — main color, SAME shape/size,
                                  // just shifted upward. Because both shapes
                                  // share identical rounded geometry, the
                                  // exposed sliver at the bottom naturally
                                  // curves with the pill — a true crescent,
                                  // not a straight cut.
                                  Positioned(
                                    top: -crescentHeight,
                                    left: 0,
                                    right: 0,
                                    bottom: crescentHeight,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: item.color,
                                        borderRadius: BorderRadius.circular(innerRadius),
                                      ),
                                    ),
                                  ),

                                  // Icon, centered on the visible pill area
                                  Positioned.fill(
                                    child: Center(
                                      child: Icon(
                                        item.icon,
                                        color: item.iconColor,
                                        size: iconSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: outerSize * 0.28),
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}