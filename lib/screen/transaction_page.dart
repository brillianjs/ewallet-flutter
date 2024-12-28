import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List _transactions = [];
  bool _isLoading = true;

  Future<void> fetchTransactions() async {
    try {
      final response = await Supabase.instance.client
          .from('transactions')
          .select(
              'created_at, sender_id, receiver_id, status, amount, transaction_type')
          .order('created_at', ascending: false);

      if (response != null) {
        setState(() {
          _transactions = response as List<dynamic>;
          _isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching transactions: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Recent Transactions'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _transactions.isEmpty
              ? const Center(
                  child: Text(
                    'No transactions found.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) =>
                      _buildTransactionItem(_transactions[index]),
                ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final isCredit = transaction['transaction_type'] == 'credit';

    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            isCredit ? 'C' : 'D',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: isCredit ? Colors.green : Colors.red,
        ),
        title: Text(
          'From: ${transaction['sender_id']}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'To: ${transaction['receiver_id']}\nStatus: ${transaction['status']}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          '${transaction['amount']}',
          style: TextStyle(
            color: isCredit ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
