import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/pay/pay_view_model.dart';
import 'package:griffin/presentation/pay/ticket_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PayScreen extends StatefulWidget {
  final List<int> forPayBookIdList;

  @override
  State<PayScreen> createState() => _PayScreenState();

  const PayScreen({
    super.key,
    required this.forPayBookIdList,
  });
}

class _PayScreenState extends State<PayScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  void initState() {
    Future.microtask(() {
      final payViewModel = context.read<PayViewModel>();

      payViewModel.init(widget.forPayBookIdList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PayViewModel>();
    final state = viewModel.state;
    final pages = List.generate(
        (state.forPaymentList.length / 2).ceil(),
        (i) => TicketWidgets(
            twoTicketList: state.forPaymentList.sublist(
                i * 2,
                (i + 1) * 2 > state.forPaymentList.length
                    ? state.forPaymentList.length
                    : (i + 1) * 2)));
    final totalAmount =
        state.forPaymentList.fold(0.0, (e, v) => e + v.payAmount!);
    return Scaffold(
      body: SafeArea(
        child: (state.isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        controller: controller,
                        itemCount: pages.length,
                        itemBuilder: (_, index) {
                          return pages[index % pages.length];
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller,
                      count: pages.length,
                      effect: const WormEffect(
                        dotHeight: 16,
                        dotWidth: 16,
                        type: WormType.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 22, right: 22),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'TOTAL FARE',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                    '${NumberFormat('###,###,###,###').format(totalAmount)} USD'),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    viewModel.bootpayPayment(context,
                                        state.forPaymentList, totalAmount);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFF88264),
                                          Color(0xFFFFE3C5),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: (){
                                    context.go('/myBooks');
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFF88264),
                                          Color(0xFFFFE3C5),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
