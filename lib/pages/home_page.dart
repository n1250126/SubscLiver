
import 'package:flutter/material.dart';
import '../models/subscription.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final List<Subscription> subs = [
    Subscription('Netflix', 1490, '月額'),
    Subscription('Spotify', 980, '月額'),
    Subscription('Amazon Prime', 600, '月額'),
  ];

  int get total =>
      subs.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('サブスク管理')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '月額合計：¥$total',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '登録中のサブスク',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: subs.length,
                itemBuilder: (context, index) {
                  final s = subs[index];
                  return Card(
                    child: ListTile(
                      title: Text(s.name),
                      subtitle: Text(s.cycle),
                      trailing: Text('¥${s.price}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
