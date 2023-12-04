import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  final count, title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 90,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(title.toString())
            ],
          ),
        ),
      ),
    );
  }
}
