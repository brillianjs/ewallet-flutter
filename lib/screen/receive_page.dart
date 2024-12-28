import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  String selectedCurrency = "Bitcoin";
  final String walletAddress = "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2";
  final double amount = 0.42933687; // Example value
  Duration countdownDuration = const Duration(minutes: 15, seconds: 00);
  late Timer timer;

  final List<String> currencies = ["Bitcoin", "Ethereum", "Litecoin", "Ripple"];

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 1), (_) => updateCountdown());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateCountdown() {
    setState(() {
      if (countdownDuration.inSeconds > 0) {
        countdownDuration = countdownDuration - const Duration(seconds: 1);
      } else {
        timer.cancel();
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      }
    });
  }

  String formatTime(int time) => time.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final minutes = formatTime(countdownDuration.inMinutes.remainder(60));
    final seconds = formatTime(countdownDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive Payment'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Currency",
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  dropdownColor: Colors.grey[800],
                  value: selectedCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCurrency = newValue!;
                    });
                  },
                  items:
                      currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            QrImageView(
              data: walletAddress,
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              " $selectedCurrency",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      walletAddress,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white),
                    onPressed: () {
                      // Copy logic here
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "This payment will expire soon, please send your payment within",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                TimeBox(label: "MINUTES", value: minutes),
                const SizedBox(width: 5),
                TimeBox(label: "SECONDS", value: seconds),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeBox extends StatelessWidget {
  final String label;
  final String value;

  const TimeBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
