// lib/presentation/your_approach/views/your_approach_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_gradients.dart';
import '../controllers/your_approach_controller.dart';

const double _kMaxContentWidth = 448;
const double _kHeaderPaddingH = 20;
const double _kHeaderPaddingV = 16;
const double _kBackBtnSize = 40;
const double _kBackIconSize = 20;
const double _kBackRadius = 12;
const double _kSpacerSize = 40;
const double _kContentPaddingH = 20;
const double _kContentPaddingTop = 32;
const double _kHeroSize = 80;
const double _kHeroRadius = 24;
const double _kHeroIconSize = 40;
const double _kHeroMb = 24;
const double _kCardRadius = 20;
const double _kCardPadding = 24;
const double _kCardBorderWidth = 2;
const double _kHeartBoxSize = 48;
const double _kHeartBoxRadius = 16;
const double _kHeartIconSize = 24;
const double _kHeartMb = 16;
const double _kTitleMb = 24;
const double _kGuidanceRadius = 16;
const double _kGuidancePadding = 24;
const double _kGuidanceMb = 16;
const double _kChipPaddingH = 16;
const double _kChipPaddingV = 8;
const double _kChipGap = 8;
const double _kCardMb = 16;
const double _kScrollBottom = 48;

class YourApproachScreen extends StatelessWidget {
  const YourApproachScreen({super.key});

  static String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<YourApproachController>();
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.homePageBg),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, c, topPad),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kContentPaddingH,
                    right: _kContentPaddingH,
                    top: _kContentPaddingTop,
                    bottom: _kScrollBottom + bottomPad,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Column(
                        children: [
                          _buildHeroIcon(),
                          SizedBox(height: _kHeroMb),
                          _buildCard(c),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, YourApproachController c, double topPad) {
    return Container(
      padding: EdgeInsets.fromLTRB(_kHeaderPaddingH, topPad + _kHeaderPaddingV, _kHeaderPaddingH, _kHeaderPaddingV),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(_kBackRadius),
              child: Container(
                width: _kBackBtnSize,
                height: _kBackBtnSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(_kBackRadius),
                  border: Border.all(color: Color(0xFFC084FC)),
                  boxShadow: [
                    BoxShadow(offset: Offset(0, 4), blurRadius: 6, color: Color(0x33000000)),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Your approach with ${c.lovedOneName.toLowerCase()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: _kSpacerSize, height: _kSpacerSize),
        ],
      ),
    );
  }

  Widget _buildHeroIcon() {
    return Container(
      width: _kHeroSize,
      height: _kHeroSize,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFA78BFA), Color(0xFFEC4899), Color(0xFFF43F5E)],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(_kHeroRadius),
        boxShadow: [
          BoxShadow(offset: Offset(0, 25), blurRadius: 50, spreadRadius: -12, color: Color(0x40000000)),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(Icons.explore_rounded, size: _kHeroIconSize, color: Colors.white),
    );
  }

  Widget _buildCard(YourApproachController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: Color(0xFFFBCFE8), width: _kCardBorderWidth),
        boxShadow: [
          BoxShadow(offset: Offset(0, 10), blurRadius: 25, spreadRadius: -5, color: Color(0x30000000)),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: _kHeartBoxSize,
              height: _kHeartBoxSize,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFBCFE8), Color(0xFFE9D5FF)],
                ),
                borderRadius: BorderRadius.circular(_kHeartBoxRadius),
                boxShadow: [
                  BoxShadow(offset: Offset(0, 2), blurRadius: 6, color: Color(0x1A000000)),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(Icons.favorite_border, size: _kHeartIconSize, color: Color(0xFFEC4899)),
            ),
          ),
          SizedBox(height: _kHeartMb),
          Text(
            'Your approach with ${_capitalize(c.lovedOneName)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF1F2937), height: 1.25),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: _kTitleMb),
          Obx(() => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(_kGuidancePadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0x80FAF5FF), Color(0x80FDF2F8)],
                  ),
                  borderRadius: BorderRadius.circular(_kGuidanceRadius),
                  border: Border.all(color: Color(0x80E9D5FF)),
                ),
                child: Text(
                  c.guidance.value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF374151), height: 1.5),
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          SizedBox(height: _kGuidanceMb),
          Obx(() => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFF3E8FF), Color(0xFFFCE7F3)],
                      ),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Color(0xFFE9D5FF)),
                    ),
                    child: Text(c.relationshipType.value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF7C3AED))),
                  ),
                  SizedBox(height: _kChipGap),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFFFF1F2), Color(0xFFFCE7F3)],
                      ),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Color(0xFFFECDD3)),
                    ),
                    child: Text(c.primaryGoal.value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFE11D48))),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
