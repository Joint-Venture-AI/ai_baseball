import 'package:baseball_ai/core/models/chart_data.dart';
import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/const/app_images.dart';
import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/main_parent/home/sub_screens/performance/performance_screen.dart';
import 'package:baseball_ai/views/features/main_parent/home/sub_screens/visualization/screens/visualization_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Add this dependency

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Define colors for easy reuse and modification
  static const Color darkBackground = Color(0xFF1E1E1E); // Adjust as needed
  static const Color cardBackground = Color(0xFF2C2C2E); // Adjust as needed
  static const Color primaryYellow = Color(0xFFFFD60A); // Adjust as needed
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey;
  static const Color greenCheck = Colors.green;
  static const Color redCross = Colors.red;
  static const Color pillarFocusBg = Color(0xFF4A4A4A); // Example color
  static const Color pillarConsistencyBg = Color(0xFF2E7D32); // Example color
  static const Color pillarGritBg = Color(0xFFC62828); // Example color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: AppStyles.cardColor,
        elevation: 0,
        leadingWidth: 80, // Increased width to accommodate padding + avatar
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 5.h),
          child: CircleAvatar(
            radius: 25,
            // Replace with your actual image asset
            backgroundImage: AssetImage(AppImages.avatarLogo), // Placeholder
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'hey 👋,',
              style: TextStyle(color: textSecondary, fontSize: 16),
            ),
            Text(
              'Good Morning',
              style: TextStyle(
                color: textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: AppStyles.cardColor,
              child: IconButton(
                icon: SvgPicture.asset(AppIcons.bell, color: Colors.white),
                onPressed: () {
                  // Handle notification tap
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCompletionSection(),
              const SizedBox(height: 24),
              _buildVisualizationCard(),
              const SizedBox(height: 24),
              _buildCorePillars(),
              const SizedBox(height: 24),
              _buildDailyCheckinCard(),
              const SizedBox(height: 24),
              _buildQuickAccessButtons(),
              const SizedBox(height: 24),
              _buildLast7DaysOverview(),
              const SizedBox(height: 24), // Add some padding at the bottom
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildCompletionSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Completion",
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildTaskItem('Wellness Log', true),
                const SizedBox(height: 8),
                _buildTaskItem('Throwing Journal', false),
                const SizedBox(height: 8),
                _buildTaskItem('Arm Care', false),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 10.0,
            percent: 0.62,
            center: const Text(
              "62%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: textPrimary,
              ),
            ),
            progressColor: primaryYellow,
            backgroundColor: Colors.grey.shade700,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, bool completed) {
    return Row(
      children: [
        Icon(
          completed ? Icons.check_circle_outline : Icons.cancel_outlined,
          color: completed ? greenCheck : redCross,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: textPrimary, fontSize: 14)),
      ],
    );
  }

  Widget _buildVisualizationCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_pin_circle_outlined,
                color: primaryYellow,
                size: 24,
              ), // Example icon
              SizedBox(width: 8),
              Text(
                "Visualization",
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Time to start visualizing for success – make this a daily habit to lock in your focus, sharpen your concentration, and gear up for peak performance. Experience a 10-minute guided visualization that primes you mentally and readies you to compete at your very best on the field.',
            style: TextStyle(color: textSecondary, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryYellow,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {
                Get.toNamed(AppRoute.visualation);
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorePillars() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Core Pillars",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPillarChip(
                'Focus',
                Icons.track_changes,
                pillarFocusBg,
              ), // Example Icon
              _buildPillarChip(
                'Consistency',
                Icons.sync_alt,
                pillarConsistencyBg,
              ), // Example Icon
              _buildPillarChip(
                'Grit',
                Icons.whatshot,
                pillarGritBg,
              ), // Example Icon
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPillarChip(String label, IconData icon, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.8), // Slightly transparent bg
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textPrimary, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCheckinCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Check-In",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'This short survey is designed to track how you\'re feeling day in and day out in order to establish a baseline of how you\'re feeling overall. From there, we can identify when changes need to be made or simply stay the course.',
            style: TextStyle(color: textSecondary, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryYellow,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {
                // Handle Let's Go tap
                Get.toNamed(AppRoute.dailyShort);
              },
              child: const Text(
                "Let's Go",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: buildAccessButton(
            'Throwing\nJournal',
            AppIcons.throwIcon,
            () => Get.toNamed(AppRoute.homethrowing),
          ),
        ), // Example Icon
        const SizedBox(width: 12),
        Expanded(
          child: buildAccessButton(
            'Arm Care',
            AppIcons.arm,
            () => Get.toNamed(AppRoute.armCare),
          ),
        ), // Example Icon
        const SizedBox(width: 12),
        Expanded(
          child: buildAccessButton(
            'Lifting Log',
            AppIcons.lifting,
            () => Get.toNamed(AppRoute.lifting),
          ),
        ), // Example Icon
      ],
    );
  }

  Widget buildAccessButton(String label, String icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 104.h,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: primaryYellow,
              height: 30.h,
              width: 30.w,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLast7DaysOverview() {
    return InkWell(
      onTap: () => Get.to(PerformanceScreen()),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Last 7 Days Overview",
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle Details tap
                  },
                  child: const Text(
                    'Details',
                    style: TextStyle(
                      color: primaryYellow,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween, // Distributes space between items
              children: [
                Expanded(
                  child: _buildChartPreview(
                    'Hydration',
                    chartData1, // <-- Provide the data for the first chart
                  ),
                ),
                const SizedBox(width: 12), // Spacing
                Expanded(
                  child: _buildChartPreview(
                    'Soreness',
                    chartData2, // <-- Provide the data for the second chart
                  ),
                ),
                const SizedBox(width: 12), // Spacing
                Expanded(
                  child: _buildChartPreview(
                    'Bullpen Volume',
                    chartData3, // <-- Provide the data for the third chart
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartPreview(String title, List<ChartData> data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(color: textSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: chartContainerBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(
                isVisible: false,
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
              ),
              plotAreaBorderWidth: 0,
              margin: EdgeInsets.zero,
              backgroundColor: chartBackground,
              // *** CORRECTED LINE HERE ***
              series: <CartesianSeries<ChartData, double>>[
                // Or you could often use the less specific but still correct:
                // series: <CartesianSeries>[
                SplineAreaSeries<ChartData, double>(
                  dataSource: data,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y,
                  borderColor: primaryYellow,
                  borderWidth: 2,
                  gradient: LinearGradient(
                    colors: [
                      primaryYellow.withOpacity(0.7),
                      primaryYellow.withOpacity(0.3),
                      primaryYellow.withOpacity(0.05),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  // splineType: SplineType.cardinal, // Optional
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
