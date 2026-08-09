class OnboardingItem {
  final String image;
  final String title;
  final String description;
  final String icon;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
    required this.icon,
  });
}
final List<OnboardingItem> onboardingData = [
  OnboardingItem(
    image: 'assets/images/Rectangle 145.png',
    title: 'Order For Food',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
    icon: 'assets/images/Transfer Document icon.png',
  ),
  OnboardingItem(
    image: 'assets/images/Rectangle 147.png',
    title: 'Easy Payment',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
    icon: 'assets/images/Card icon.png',
  ),
  OnboardingItem(
    image: 'assets/images/Rectangle 147 (1).png',
    title: 'Fast Delivery',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
    icon: 'assets/images/Vector.png',
  ),
];