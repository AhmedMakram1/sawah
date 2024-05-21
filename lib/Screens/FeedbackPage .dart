import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Expression {
  veryDissatisfied,
  dissatisfied,
  neutral,
  satisfied,
  verySatisfied,
}

class FeedbackPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Feedback',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'How was your whole experience?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _emojiButton(context, '😣', Colors.red, Expression.veryDissatisfied),
                _emojiButton(context, '😔', Colors.orange, Expression.dissatisfied),
                _emojiButton(context, '😐', Colors.yellow, Expression.neutral),
                _emojiButton(context, '😊', Colors.lightGreen, Expression.satisfied),
                _emojiButton(context, '😁', Colors.green, Expression.verySatisfied),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emojiButton(BuildContext context, String emoji, Color color, Expression expression) {
    return Column(
      children: [
        IconButton(
          icon: Text(
            emoji,
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            _saveRatingToFirestore(expression);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You selected: ${_getExpressionText(expression)}'),
                backgroundColor: color,
              ),
            );
          },
        ),
        Text(
          _getExpressionText(expression),
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }

  String _getExpressionText(Expression expression) {
    switch (expression) {
      case Expression.veryDissatisfied:
        return 'Very Dissatisfied';
      case Expression.dissatisfied:
        return 'Dissatisfied';
      case Expression.neutral:
        return 'Neutral';
      case Expression.satisfied:
        return 'Satisfied';
      case Expression.verySatisfied:
        return 'Very Satisfied';
      default:
        return '';
    }
  }

  Future<void> _saveRatingToFirestore(Expression expression) async {
    await _firestore.collection('feedback').add({
      'expression': _getExpressionText(expression),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
