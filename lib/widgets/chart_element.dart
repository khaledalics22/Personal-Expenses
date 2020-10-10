import 'package:flutter/material.dart';

class ChartElement extends StatelessWidget {
  final String day;
  final double totalTx;
  final double fractionSize;
  ChartElement(this.day, this.totalTx, this.fractionSize);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 20,
              child: FittedBox(
                child: Text('\$${totalTx.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              width: 5,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(220, 220, 220, 1)),
                  ),
                  FractionallySizedBox(
                    heightFactor: fractionSize,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            FittedBox(
              child: Text(day),
            ),
          ],
        ),
      ),
    );
  }
}
