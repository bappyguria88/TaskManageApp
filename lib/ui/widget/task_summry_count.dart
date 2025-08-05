import 'package:flutter/material.dart';

class CardSummaryCount extends StatelessWidget {
  const CardSummaryCount({
    super.key,
    required this.count,
    required this.title,
  });
  final String count;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text(title,style: const TextStyle(fontSize: 16,color: Colors.grey))
          ],
        ),
      ),
    );
  }
}