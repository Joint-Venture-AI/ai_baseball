import 'package:baseball_ai/core/utils/theme/app_styles.dart'; // Assuming this path is correct
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Assuming GetX is used for navigation
import 'package:radial_chart_package/widgets/radial_performance_chart.dart';
import 'package:radial_chart_package/widgets/segment_data.dart';

class PerformanceScreen extends StatelessWidget {
  PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.cardColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text('Performance', style: AppStyles.bodyMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Center(
                  child: RadialPerformanceChart(
                    radius: 150,
                    segments: [
                      SegmentData(
                        percentage: 72,
                        color: Colors.lightGreen,
                        label: "72%",
                      ),
                      SegmentData(
                        percentage: 100,
                        color: Colors.amber,
                        label: "100%",
                      ),
                      SegmentData(
                        percentage: 20,
                        color: Colors.red,
                        label: "100%",
                      ),
                      SegmentData(
                        percentage: 60,
                        color: Colors.blue,
                        label: "100%",
                      ),
                      SegmentData(
                        percentage: 80,
                        color: Colors.amber,
                        label: "100%",
                      ),
                      SegmentData(
                        percentage: 70,
                        color: Colors.green,
                        label: "100%",
                      ),
                      SegmentData(
                        percentage: 64,
                        color: Colors.amber,
                        label: "100%",
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h), // Spacer
              Text('Power Ratings', style: AppStyles.bodyMedium),
              SizedBox(height: 10.h), // Spacer

              _buildProgressWidget(Colors.blueAccent, 72, 0.7, 'Visualization'),
              SizedBox(height: 20.h),
              _buildProgressWidget(Colors.amberAccent, 20, 0.2, 'Consistency'),
              SizedBox(height: 20.h),
              _buildProgressWidget(Colors.deepPurpleAccent, 50, 0.5, 'Lifting'),
              SizedBox(height: 20.h),
              _buildProgressWidget(Colors.redAccent, 15, 0.15, 'Recovery'),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildProgressWidget(
    Color color,
    int labelInt,
    double value,
    String label,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$labelInt',
          style: AppStyles.headingLarge.copyWith(
            color: Colors.white,
            fontSize: 40.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.bodyMedium.copyWith(fontSize: 12.sp),
              ),
              SizedBox(height: 5.h),
              LinearProgressIndicator(
                minHeight: 10.h,

                value: value,
                backgroundColor: AppStyles.cardColor,
                borderRadius: BorderRadius.circular(10.r),
                color: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
