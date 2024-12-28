import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto_wallet_app/widget/bottom_navigation_bar.dart';

class SendBalancePage extends StatefulWidget {
  const SendBalancePage({Key? key}) : super(key: key);

  @override
  _SendBalancePageState createState() => _SendBalancePageState();
}

class _SendBalancePageState extends State<SendBalancePage> {
  final TextEditingController _receiverIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendBalance() async {
    final senderId = Supabase.instance.client.auth.currentUser?.id;
    final receiverId = _receiverIdController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());

    if (senderId != null &&
        receiverId.isNotEmpty &&
        amount != null &&
        amount > 0) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response =
            await Supabase.instance.client.rpc('process_transaction', params: {
          'sender_id': senderId,
          'receiver_id': receiverId,
          'amount': amount,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Balance sent successfully')),
        );
      } catch (error) {
        print('Errr $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error occurred: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Send Balance'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _receiverIdController,
              decoration: InputDecoration(
                labelText: 'Receiver ID',
                labelStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellowAccent[700]!),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellowAccent[700]!),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent[700],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _isLoading ? null : _sendBalance,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text(
                      'Send Balance',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
