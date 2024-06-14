class onboardingContent {
  String image;
  String description;
  String btnText = "NEXT";

  onboardingContent({required this.image, required this.description});
}

List<onboardingContent> contents = [
  onboardingContent(
    image: "assets/screen1.png",
    description: "welcome To \n SAC system",
  )
];
