import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:product_iq/consts.dart';
import 'package:product_iq/models/search_result.dart';
import 'package:product_iq/models/subscription.dart';
import 'package:product_iq/routes/app_route_consts.dart';
import 'package:product_iq/screens/crash_error_screen.dart';
import 'package:product_iq/widgets/common_widgets/search_widget.dart';
import 'package:product_iq/widgets/home_widgets/app_card.dart';
import 'package:product_iq/widgets/home_widgets/offers_widget.dart';
import 'package:http/http.dart' as http;
import 'package:product_iq/widgets/home_widgets/search_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  final purchasedApps = [];
  final unPurchasedApps = [];
  var isLoading = true;
  final List<Subscription> offers = [];

  final List<String> headings = [];
  final List<String> subheadings = [];
  final List<Function> funcs = [];
  final List<String> type = [];
  final List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool noneSelected = true;
  bool isSearch = false;
  bool isOffersLoaded = false;
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    if (MyConsts.isSubscribed) {
      setState(() {
        isOffersLoaded = true;
      });
    }
    getApps();
    super.initState();
  }
  void getApps() async {
    try {
      if (MyConsts.token == '') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        setState(() {
          MyConsts.token = preferences.getString("token")!;
          debugPrint("New token");
        });
      }
      final expiryDate = JwtDecoder.getExpirationDate(MyConsts.token);
      debugPrint(expiryDate.toString());

      debugPrint(MyConsts.token);
      final appsUrl = Uri.parse('${MyConsts.baseUrl}/app/all');
      http.Response response = await http.get(appsUrl, headers: MyConsts.requestHeader);
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = jsonDecode(response.body);
        print("hemant response " + res.toString());
        for (var app in res) {
          if (app["app_type"] == MyConsts.appTypes[3]) {
            continue;
          }
          if (app["is_subscribed"] == true) {
            purchasedApps.add([app["app_name"], app["id"], app["app_type"]]);
            if (app['app_type'] == MyConsts.appTypes[0]) {
              MyConsts.isCoachSubscribed = true;
            } else if (app['app_type'] == MyConsts.appTypes[2]) {
              MyConsts.isIqSubscribed = true;
            }else if (app['app_type'] == MyConsts.appTypes[1]) {
              MyConsts.isWorktoolsSubscribed = true;
            }
          } else {
            unPurchasedApps.add([app["app_name"], app["id"], app["app_type"]]);
          }
        }
      } else {
        debugPrint(response.body);
        throw Exception('Failed to load apps');
      }
    } catch (e) {
      print("error is $e");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CrashErrorScreen(retry: getApps),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });

      if (!MyConsts.isSubscribed) {
        await _getOffers();
      } else {
        setState(() {
          isOffersLoaded = true;
        });
      }
    }
  }

  Future<void> _getOffers() async {
    try {
      final offersUrl = Uri.parse('${MyConsts.baseUrl}/subscription/plans');
      http.Response response = await http.get(offersUrl, headers: MyConsts.requestHeader);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        for (var offer in res) {
          for (var app in offer["apps"]) {
            if (unPurchasedApps.any((element) => element[0] == app)) {
              offers.add(Subscription.fromJson(offer));
              break;
            }
          }
        }
      } else {
        debugPrint(response.body);
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      print("error ${e}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CrashErrorScreen(retry: _getOffers),
        ),
      );
    } finally {
      setState(() {
        isOffersLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(purchasedApps);
    if (MyConsts.isPurchased) {
      setState(() {
        isLoading = true;
        isOffersLoaded = false;
        MyConsts.isPurchased = false;
      });
      purchasedApps.clear();
      unPurchasedApps.clear();
      getApps();
      if (MyConsts.isSubscribed) {
        setState(() {
          isOffersLoaded = true;
        });
      }
    }
    return SafeArea(
        minimum: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  MyConsts.isSubscribed ? "Search" : "Offers",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      color: MyConsts.primaryDark,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              !isOffersLoaded
                  ? SizedBox.shrink()

                  : offers.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context)
                                        .pushNamed(MyAppRouteConst.searchRoute);
                                  },
                                  child: SearchWidget(
                                    focus: false,
                                    hintText: "Search Now",
                                    onSubmitted: (value) async {
                                      isSearch = true;
                                      headings.clear();
                                      subheadings.clear();
                                      funcs.clear();
                                      type.clear();
                                      // Implement search functionality here using the search route
                                      if (MyConsts.token == '') {
                                        SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                        MyConsts.token = prefs.getString('token')!;
                                      }
                                      final searchUrl = Uri.parse(
                                          '${MyConsts.baseUrl}/app/search/$value');

                                      http.Response response = await http.get(
                                          searchUrl,
                                          headers: MyConsts.requestHeader);
                                      final res = jsonDecode(response.body);
                                      if (response.statusCode == 200) {
                                        debugPrint(res.toString());
                                        final result = SearchResult.fromJson(res);
                                        setState(() {});
                                      } else {
                                        debugPrint(response.body);
                                      }
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConst.searchRoute,
                                          extra: SearchResults(
                                              title: headings,
                                              subtitle: subheadings,
                                              onTap: funcs,
                                              type: type,
                                              filters: noneSelected
                                                  ? MyConsts.allTrue
                                                  : isSelected,
                                              isSearch: isSearch));
                                    },
                                  )),
                            )
                          : SizedBox(
                          height: 180,
                          child: PageView.builder(
                              itemCount: offers.length,
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                            MyAppRouteConst.subscriptionRoute,
                                            extra: 0);
                                      },
                                      child: OffersWidget(
                                          productName: offers[index].name,
                                          discountPrice:
                                              offers[index].discountedMonthly,
                                          originalPrice:
                                              offers[index].priceMonthly),
                                    ),
                                  )),
                        ),
              if (offers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < offers.length; ++i)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(4),
                          height: i == _currentIndex ? 8 : 4,
                          width: i == _currentIndex ? 8 : 4,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyConsts.primaryDark),
                        )
                    ],
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "My Apps",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      color: MyConsts.primaryDark,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          children: [
                            for (int i = 0; i < purchasedApps.length; ++i)
                              ZoomTapAnimation(
                                  onTap: () {
                                    print(" purchased $purchasedApps");
                                    if (purchasedApps[i][2] ==
                                        MyConsts.appTypes[0]) {
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConst.coachModulesRoute,
                                          pathParameters: {
                                            'appId': '${purchasedApps[i][1]}'
                                          });
                                    } else if (purchasedApps[i][2] ==
                                        MyConsts.appTypes[1]) {
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConst.worktoolsRoute,
                                      pathParameters: {
                                        'appId': '${purchasedApps[i][1]}'
                                      });
                                    } else if (purchasedApps[i][2] ==
                                        MyConsts.appTypes[2]) {
                                      GoRouter.of(context)
                                          .pushNamed(MyAppRouteConst.iqRoute,
                                          pathParameters: {
                                            'appId': '${purchasedApps[i][1]}'
                                          });
                                    }
                                  },
                                  child: AppCard(
                                    purchasedApps[i][2],
                                    productName: purchasedApps[i][0],
                                  )),
                            for (int i = 0; i < unPurchasedApps.length; ++i)
                              ZoomTapAnimation(
                                  onTap: () {
                                    if (unPurchasedApps[i][2] ==
                                        MyConsts.appTypes[0]) {
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConst.coachRoute,
                                          pathParameters: {
                                            'appId':
                                                unPurchasedApps[i][1].toString()
                                          });
                                    } else if (unPurchasedApps[i][2] ==
                                        MyConsts.appTypes[1]) {
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConst
                                              .worktoolsOnboardingRoute,
                                          pathParameters: {
                                            'appId':
                                                unPurchasedApps[i][1].toString()
                                          });
                                    } else if (unPurchasedApps[i][2] ==
                                        MyConsts.appTypes[2]) {
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConst.iqOnboardingRoute,
                                          pathParameters: {
                                            'appId':
                                                unPurchasedApps[i][1].toString()
                                          });
                                    }
                                  },
                                  child: AppCard(
                                    unPurchasedApps[i][2],
                                    isPurchased: false,
                                    productName: unPurchasedApps[i][0],
                                  )),
                          ],
                        )),
            ],
          ),
        ));
  }
}
