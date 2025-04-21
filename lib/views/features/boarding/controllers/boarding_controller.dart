import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
import 'package:baseball_ai/views/features/main_parent/bottom_nav/main_parent_screen.dart';
import 'package:get/get.dart';

class BoardingController extends GetxController {
  var isShowLoadingSection = RxBool(true);
  var contentIndex = 0.obs;

  List<String> titlesText = [
    'Discover your athletic identity',
    'Unlock Your Potential',
    'Peak performance starts here',
  ];

  List<String> subTitleText = [
    'Understand what drives you-your core values are your compass when is on and everybody’s watching.',
    'Define your goals and map out the steps to achieve greatness.', // Placeholder - replace if needed
    'It’s time to lock it in, define your direction, and take the first step towards finding your daily blueprint',
  ];

  List<String> adviceText = [
    '"l never let winning define me. I define myself by how I carry my character and values, whether I win or lose."__Simone Biles',
    '"Success isn\'t always about greatness. It\'s about consistency. Consistent hard work leads to success."__Dwayne Johnson', // Placeholder - replace if needed
    '"...Results come when you commit to the work nobody sees. "__Alex Rodriguez',
  ];

  @override
  void onInit() async {
    super.onInit();
    assert(
      titlesText.length == subTitleText.length &&
          titlesText.length == adviceText.length,
      "Boarding content lists must have the same number of items.",
    );
    assert(titlesText.length == 3, "Expected 3 boarding screens.");

    await Future.delayed(const Duration(seconds: 3));
    isShowLoadingSection.value = false;
  }

  void changeContent() {
    // Check if the current index is the last index
    if (contentIndex.value == titlesText.length - 1) {
      print("Onboarding finished. Navigating to MainScreen...");

      Get.to(WelcomeScreen());
    } else {
      // Not on the last screen yet, just increment the index
      contentIndex.value++;
      print("Moving to content index: ${contentIndex.value}");
    }
  }
}
