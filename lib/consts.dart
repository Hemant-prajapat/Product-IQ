import 'package:flutter/material.dart';
import 'package:product_iq/routes/app_route_consts.dart';

class MyConsts {
static const iqIndustryColor = Color(0xFF082AA8);
// TEXTS
  static const appName = "Product Cohort";
  static const salesScreenText =
      "Want to stimulate hands-on Product Manager Experience across levels from couch?";
  static const freeText = "GET FOR FREE";
  static final productName = [
    "Product Industry Trainer",
    "PRODUCT WorkTools",
    "Product Flash Tutor",
    "PRODUCT Interview Coach"
  ];
  static final productNameMap = {
    1: "Product Industry Trainer",
    2: "Product Worktools",
    3: "Product Flash Tutor"
  };
  static const buyText = "Buy Now";
  static const signupText = "Signup to Product Cohort!";
  static const signupSubtext =
      "Boost your industry experience in Product Management";
  static const productExperience = [
    "Aspiring Product Manager",
    "Associate Product Manager",
    "Product Manager",
    "Senior Product Manager",
    "Director of Product Management",
    "Head of Product",
    "Vice President of Product",
    "Chief Product Officer",
    "Entrepreneur"
  ];
  static const tncText = "By creating an account you agree to our\n";
  static const tnc = "Terms and Conditions";
  static const selectProductText = "Select your product experience";
  static const name = "Name";
  static const nameError = "Name must not be empty";
  static const mail = "Email";
  static const mailError = "Enter a valid email address";
  static const password = "Password";
  static const passwordError = "Password must be atleast of 8 characters";
  static const signIn = "Sign In";
  static const signUp = "Sign Up";
  static const loginText = "Login to Product Cohort!";
  static const homeButton = "Home";
  static const appButton = "Apps";
  static const profileButton = "Profile";
  static const welcomeText = "Welcome";
  static const startLearning = "Start\nLearning...";
  static const searchText = "What do you want to learn?";
  static const chipsText = [
    "Modules",
    "Challenges",
    "Labels",
    "Categories",
    "Skills",
    "Sections",
    "Topics",
    "Learnings"
  ];
  static const productIcons = [
    'assets/elements/coach.svg',
    'assets/elements/worktools.svg',
    'assets/elements/iq.svg',
  ];
  static const coachBulbPoints = [
    "New or want to grow Product Management ?",
    "Do you find it difficult to build the Product Mindset ?",
    "Do you want to get actual industry product skills?",
    "Are you preparing or transitioning for the Product Manager role ?"
  ];
  static const coachTickPoints = [
    "Become Industry ready as a Product Manager",
    "Develop Product Mindset",
    "Personalized Guided Product Training",
  ];
  static const coachTrainingPoints = [
    "PM interview questions from Meta, Google, Airbnb, Amazon & more",
    "Practice the questions with real-time guidance 24 X 7",
    "Get report and areas to improve for each assignment",
  ];

  static const interviewBulbPoints = [
    "Want the fastest way to gain product knowledge ?",
    "Are you still spending long hours in going through inefficient video courses ?",
    "Are you also struggling with just the theory circulating on the web ?",
    "Have not using AI moved your behind the peers?"
  ];
  static const interviewTickPoints = [
    "Crafted Product knowledge for day-to-day discussions",
    "Precise reads for faster consumption and reference",
    "Refer business case-studies to back your research",
  ];

  static const iqBulbPoints = [
    "Want the fastest way to gain product knowledge ?",
    "Are you still spending long hours in going through inefficient video courses?",
    "Do you want to optimize your time with key product knowledge?",
    "Are you also struggling with just the theory circulating on the web"
  ];
  static const iqWorktoolsBulbPoints = [
    "Already a Product Manager ?",
    "Are you spending long hours to write product documents, instead want to save time?",
    "Do you want to get all possible ideas to pick for your product tasks, without missing any?",
    "Have not using AI moved your behind the peers?"
  ];

  static const iqWorktoolsTickPoints = [
    "Auto-generate product documents quickly with one-liners",
    "Get instant ideas on newer skills",
    "Personalized Guided Product Training",
  ];
  static const iqTickPoints = [
    "Crafted Product knowledge for day-to-day discussions",
    "Precise reads for faster consumption and reference",
    "Refer business case-studies to back your research",
  ];

  static const dummyText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.";

  static const dummyDP =
      "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";

  static const settingsOptions = [
    "Purchases / Subscription",
    "Edit Profile",
    "Refer and Earn",
    "Help & Support"
  ];

  static const worktoolsChipText = [
    "Discover",
    "Define",
    "Strategy",
    "UX",
    "UI",
    "Product"
  ];

  static const worktoolsRevenueText =
      "Enables you to explore options of revenue model based on your market";
  static const worktoolsResponseText = [
    "Revenue try the only “First person Product manager simulation”",
    "Become Industry Ready",
    "Self paced learning, no months of theory training",
    "Daily Product Industry Challenge",
    "Practice infinite times",
    "Product Management Comes from Experience",
    "Personalized Guided Product training"
  ];
  static const learning = "Learning";

  static const baseUrl = "https://productiq-api.wemofy.in/api/v1";
  static const imageUrl = "https://productiq-api.wemofy.in/media/";

  static String token = '';
  static const tokenNotValid = "token_not_valid";
  static final requestHeader = {
    'Content-type': 'application/json',
    'Authorization': 'bearer ${MyConsts.token}'
  };

  static final appTypes = ["modules", "worktools", "productiq", "hidden"];

  static String moduleName = '';
  static String moduleId = '';

  static bool isSubscribed = false;
  static bool isCoachSubscribed = false;
  static bool isWorktoolsSubscribed = false;
  static bool isIqSubscribed = false;

  static bool isPurchased = false;

  static const allTrue = [true, true, true, true, true, true, true, true];

// COLORS
  static const bgColor = Color(0xFFF3F2FC);
  static const primaryLight = Color(0xFFCDC9F3);
  static const primaryDark = Color(0xFF0C092A);
  static const primaryColorFrom = Color(0xFF6E6CCE);
  static const primaryColorTo = Color(0xFF514ED7);
  static const productColors = [
    [Color(0xFF3629B7), Color(0xFF3629B7)],
    [Color(0xFF998EFF), Color(0xFF998EFF)],
    [Color(0xFF73D2F2), Color(0xFF02A8E0)],
    [Color(0xFF082AA8), Color(0xFF082AA8)],
  ];
  static const productimage = [
    "assets/elements/coach.svg",
    "assets/elements/interview.svg",
    "assets/elements/worktools.svg",
    "assets/elements/iq.svg"
  ];
  static const primaryGrey = Color(0xFF444444);
  static const coachLight = Color(0xFFD8D5F6);
  static const primaryRed = Color(0xFFF45051);
  static const primaryOrange = Color(0xFFEFB389);
  static const primaryGreen = Color(0xFF6DAC28);

//SHADOWS
  static const shadow1 = BoxShadow(
      color: Color.fromRGBO(100, 100, 111, 0.2),
      offset: Offset(0, 4),
      blurRadius: 16);
  static const shadow2 = BoxShadow(
      color: Color.fromRGBO(100, 100, 111, 0.1),
      offset: Offset(0, 4),
      blurRadius: 20,
      spreadRadius: 2);
  static final coachShadow = BoxShadow(
      color: productColors[0][0].withOpacity(0.15),
      blurRadius: 28,
      spreadRadius: 12);

//ICONS
  static const settingsOptionsIcons = [
    Icons.subscriptions_outlined,
    Icons.translate_outlined,
    //Icons.person_2_outlined,
    Icons.wallet_giftcard_outlined,
    Icons.support_agent_outlined
  ];
  static const iqCardIcons = [
    Icons.storefront_outlined,
    Icons.manage_accounts_outlined,
    Icons.shopping_cart_outlined,
    Icons.compass_calibration_outlined,
  ];
}
