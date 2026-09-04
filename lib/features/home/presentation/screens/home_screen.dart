import 'package:expense_tracker/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../widgets/action_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    // appbar
                    Row(
                      children: [
                      Image.asset(AppAssets.logo,height: 60,width: 60,fit: .contain,),
                      Text("Finora",
                        style: GoogleFonts.plusJakartaSans(fontWeight: .bold,fontSize: 25),
                      ),
                      const Spacer(),
                        _appBarIcon(
                          onTap: () {},
                          icon: const Icon(
                            LucideIcons.bell,
                            color: Color(0xFF161616),
                            size: 22,
                          ),
                        ),
                      const SizedBox(width: 10,),
                        _appBarIcon(onTap: (){}, icon: Text("S",
                          style: GoogleFonts.plusJakartaSans(fontWeight: .bold,fontSize: 30,color: Color(0xFF111111)),
                        )),
                    ],),
                    // expense
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Icon(LucideIcons.wallet,color: Colors.black,size: 15,),
                        const SizedBox(width: 5,),
                        Text("Main Wallet   ●●●●4556")
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Text("Total Balance",
                      style: GoogleFonts.plusJakartaSans(fontSize: 18,color: Colors.grey.shade400),
                    ),
                    const SizedBox(height: 10,),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "\$163.92"),
                          TextSpan(
                            text: ".38",
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ],
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: ActionButton(item: ActionButtonItem(
                          icon: Icons.add, label: 'Buy',
                          color: const Color(0xFF2F9BFF), onTap: () {},
                        ))),
                        const SizedBox(width: 5),
                        Expanded(child: ActionButton(item: ActionButtonItem(
                          icon: LucideIcons.arrowLeftRight, label: 'Swap', onTap: () {},
                        ))),
                        const SizedBox(width: 5),
                        Expanded(child: ActionButton(item: ActionButtonItem(
                          icon: LucideIcons.piggyBank, label: 'Stake', onTap: () {},
                        ))),
                        const SizedBox(width: 5),
                        Expanded(child: ActionButton(item: ActionButtonItem(
                          icon: LucideIcons.arrowUp, label: 'Send', onTap: () {},
                        ))),
                        const SizedBox(width: 5),
                        Expanded(child: ActionButton(item: ActionButtonItem(
                          icon: LucideIcons.arrowDown, label: 'Receive', onTap: () {},
                        ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _appBarIcon({required VoidCallback onTap, required Widget icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEFEFEF)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 15,
              spreadRadius: -2,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 2,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: const Alignment(0.0, -1.0),
                    radius: 1.0,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.6],
                  ),
                ),
              ),
            ),
            Center(child: icon),
          ],
        ),
      ),
    );
  }

}
