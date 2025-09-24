import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RateAndReviewModal extends StatefulWidget {
  final Function(bool allRated) onAllRatedChanged;

  const RateAndReviewModal({
    Key? key,
    required this.onAllRatedChanged,
  }) : super(key: key);

  @override
  RateAndReviewModalState createState() => RateAndReviewModalState();
}

class RateAndReviewModalState extends State<RateAndReviewModal> {
  final List<String> questions = [
    'جذابیت و زیبایی بسته‌بندی',
    'نسبت کیفیت به قیمت محصول',
    'طعم محصول',
    'کیفیت بسته‌بندی (چاپ تاریخ انقضا و قیمت روی بسته)'
  ];

  late List<int> ratings;
  final TextEditingController commentController = TextEditingController();
  late List<bool> showRedBorderForQuestion;

  @override
  void initState() {
    super.initState();
    ratings = List<int>.filled(questions.length, 0);
    showRedBorderForQuestion = List<bool>.filled(questions.length, false);
    _notifyParent();
  }

  void _notifyParent() {
    final allRated = ratings.every((r) => r > 0);
    widget.onAllRatedChanged(allRated);
  }

  void highlightUnratedQuestions() {
    setState(() {
      bool hadUnrated = false;
      for (int i = 0; i < ratings.length; i++) {
        if (ratings[i] == 0) {
          showRedBorderForQuestion[i] = true;
          hadUnrated = true;
        } else {
          showRedBorderForQuestion[i] = false;
        }
      }
      if (hadUnrated) {
        // Optionally show a general message or just rely on individual red borders
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(questions.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textDirection: TextDirection.rtl,
                  '${index + 1}. ${questions[index]}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (star) {
                    final val = 5 - star;
                    final selected = ratings[index] == val;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              ratings[index] = val;
                              showRedBorderForQuestion[index] = false;
                              _notifyParent();
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: selected
                                ? const Color(0xFFE6F4EA)
                                : Colors.white,
                            side: BorderSide(
                              color: showRedBorderForQuestion[index] && ratings[index] == 0
                                  ? Color(0xFFF2506E)
                                  : selected
                                  ? const Color(0xFF018A08)
                                  : const Color(0xFFE5E8EB),
                              width: showRedBorderForQuestion[index] && ratings[index] == 0 ? 1.5 : 1.0,
                            ),
                            minimumSize: const Size(40, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            '$val',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.black),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

              ],
            ),
          );
        }),
        const SizedBox(height: 12),
        TextField(
          controller: commentController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Color(0xFF657380)),
            hintText: 'نظر خود را در این قسمت بنویسید. (اختیاری)',
            hintTextDirection: TextDirection.rtl,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF018A08), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}