import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_iq/widgets/sales_widgets/rps_custom_painter.dart';
import 'package:product_iq/consts.dart';
import 'package:product_iq/widgets/sales_widgets/sales_bulb_point.dart';
import 'package:product_iq/widgets/sales_widgets/sales_tick_point.dart';

class ProductSalesScreen extends StatelessWidget {
  const ProductSalesScreen(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  size: Size(deviceWidth, deviceWidth * 0.95),
                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(
                      MyConsts.productColors[index - 1][0],
                      MyConsts.productColors[index - 1][1]),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Stack(
                        children: [
                          SizedBox(
                              width: deviceWidth,
                              child: Text(
                                MyConsts.appName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white,fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )),
                          Image.asset("assets/elements/ratebar.png",width: 20,color: Colors.white,)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        index == 1
                            ? MyConsts.coachBulbPoints[0]
                            : index == 2
                                ? MyConsts.iqWorktoolsBulbPoints[0]
                                : index == 3 ? MyConsts.interviewBulbPoints[0] :MyConsts.iqBulbPoints[0]  ,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w900,color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 1; i <= 3; ++i)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SalesBulbPoint(
                              index == 1
                                  ? MyConsts.coachBulbPoints[i]
                                  : index == 2
                                      ? MyConsts.iqWorktoolsBulbPoints[i]
                                      : index == 3 ? MyConsts.interviewBulbPoints[i] : MyConsts.iqBulbPoints[i],
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 32, 30, 12),
                child: Text(
                  MyConsts.productName[index - 1].toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge!,
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                top: 20,
                right: -10,
                  child: SvgPicture.asset(MyConsts.productimage[index - 1],width: 85.94,))
            ],
          ),
          Opacity(
            opacity: 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 3; ++i)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: SalesTickPoint(
                        index == 1
                            ? MyConsts.coachTickPoints[i]
                            : index == 2
                                ? MyConsts.iqWorktoolsTickPoints[i]
                                : index == 3
                            ? MyConsts.interviewTickPoints[i]
                            : MyConsts.iqTickPoints[i],
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const Spacer(),
          //     GestureDetector(
          //       onTap: () {
          //         GoRouter.of(context)
          //             .pushNamed(MyAppRouteConst.subscriptionRoute, extra: index-1);
          //       },
          //       child: Container(
          //         margin:
          //             const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8),
          //             boxShadow: const [MyConsts.shadow1],
          //             gradient: LinearGradient(colors: [
          //               MyConsts.productColors[index - 1][0],
          //               MyConsts.productColors[index - 1][1]
          //             ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          //         child: Text(
          //           MyConsts.buyText,
          //           style: Theme.of(context).textTheme.titleSmall,
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
