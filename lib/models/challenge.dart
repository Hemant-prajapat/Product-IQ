class Challenge {
  Challenge(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.isCompleted,
      this.isLocked = false,
      this.rating,
      required this.companyLogo,
      required this.topics,
      required this.levelHint,
      required this.sampleAnswer

      });

  final String id;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final int ? rating;
  final String  companyLogo;
  final String  sampleAnswer;
  final List<dynamic>  topics;

  final String  levelHint;
  final bool isLocked;
}
