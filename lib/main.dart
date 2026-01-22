import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SubscriptionPage(),
    );
  }
}

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<String> subscriptions = [];

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      subscriptions = prefs.getStringList('subscriptions') ?? [];
    });
  }

  Future<void> _addSubscription() async {
    if (_serviceController.text.isEmpty ||
        _priceController.text.isEmpty) return;

    final newItem =
        '${_serviceController.text} / ${_priceController.text}';

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      subscriptions.add(newItem);
    });
    await prefs.setStringList('subscriptions', subscriptions);

    _serviceController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サブスク管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _serviceController,
              decoration: const InputDecoration(
                labelText: 'サービス名',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: '月額料金（例：990円）',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addSubscription,
              child: const Text('追加する'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(subscriptions[index]),
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
