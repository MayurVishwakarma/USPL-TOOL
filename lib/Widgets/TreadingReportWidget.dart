
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Models/trade_history_model.dart';
import 'package:uspltool/Provider/TradeBookProvider.dart';
import 'package:uspltool/Widgets/custom_row.dart';
import 'package:uspltool/utils/color_manager.dart';

class TradingReport extends StatelessWidget {
  final bool isExpanded;
  final List<TradeHistoryModel>? tradeList;
  final double balence;
  const TradingReport({super.key, this.isExpanded = false, required this.tradeList,required this.balence});

  @override
  Widget build(BuildContext context) {
    final tdp = Provider.of<TradeBookProvider>(context);
    return Container(
      color: Colors.transparent,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // if(widget.isChip==true)
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Container(
          //     decoration:const BoxDecoration(
          //       color: Colors.deepOrange,
          //       borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(10),
          //         topLeft: Radius.circular(10)
          //       )
          //     ),
          //     child: IconButton(onPressed: (){
          //       setState(() {
          //             isExpanded = !isExpanded;
          //           });
          //     }, icon:isExpanded? Transform.rotate(
          //       angle: pi/2,
          //       child: const Icon(Icons.arrow_back_ios))
          //     :Transform.rotate(
          //       angle: 3*pi/2,
          //       child: const Icon(Icons.arrow_back_ios,))),
          //   ),
          // ),
          Visibility(
            visible: isExpanded,
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation<double>(isExpanded ? 1.0 : 0.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ColorManager.balck255,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomRow(
                              title: "No of Trades",
                              value: tradeList?.length.toString(),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            CustomRow(
                              title: "+ Trades",
                              value: tdp
                                  .getNumberOfPositiveTrades(tradeList ?? [])
                                  .toString(),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            CustomRow(
                              title: "- Trades",
                              value: tdp
                                  .getNumberOfNegativeTrades(tradeList ?? [])
                                  .toString(),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CustomRow(
                            title: "Win Rate",
                            value: tdp.getWinPercent(tradeList ?? []).toStringAsFixed(2),     
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          CustomRow(
                            title: "% Points Gain",            
                            value: tdp.getPercentPointGain(tradeList ?? []).toStringAsFixed(2),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          CustomRow(
                            title: "ROI",
                            value: tdp.getROIPercentage(balence, 100000).toStringAsFixed(2),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
