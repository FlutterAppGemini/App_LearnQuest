import 'package:flutter/material.dart';
import 'package:learnquest/generated/l10n.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          S.of(context).help_option,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFAQItem(
                context,
                S.of(context).faq_what_is_learnquest,
                S.of(context).faq_what_is_learnquest_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_how_does_learnquest_work,
                S.of(context).faq_how_does_learnquest_work_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_need_internet,
                S.of(context).faq_need_internet_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_how_to_register,
                S.of(context).faq_how_to_register_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_is_learnquest_free,
                S.of(context).faq_is_learnquest_free_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_change_language,
                S.of(context).faq_change_language_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_track_progress,
                S.of(context).faq_track_progress_answer,
              ),
              _buildFAQItem(
                context,
                S.of(context).faq_multiple_devices,
                S.of(context).faq_multiple_devices_answer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
