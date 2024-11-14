import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/widgets/feedback_details.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({
    super.key,
    required this.schoolId,
  });
  final String schoolId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Feedback',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SchoolInfoCubit()..fetchFeedback(schoolId),
          child: BlocConsumer<SchoolInfoCubit, SchoolInfoState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  if (state is SchoolInfoLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is FeedbackLoaded)
                    Column(
                      children: [
                        // Load More Button
                        if (state.hasMore)
                          TextButton(
                            onPressed: () async {
                              if (!state.hasMore || !context.read<SchoolInfoCubit>().isFetching) return;
                              await context.read<SchoolInfoCubit>().fetchFeedback(schoolId);
                            },
                            child: const Text('View More Comments'),
                          ),
                        ListView.builder(
                          shrinkWrap: true, // Allow ListView to take only the required space
                          physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                          itemCount: state.feedbackContents.length,
                          itemBuilder: (context, index) {
                            final feedback = state.feedbackContents[index];
                            return FeedbackDetails(
                              feedbackCreatedAt: feedback.createdAt,
                              feedbackAuthor: feedback.userFirstName,
                              feedbackText: feedback.feedbackDescription,
                            );
                          },
                        ),
                      ],
                    ),
                  if (state is SchoolInfoError)
                    Center(child: Text('Error: ${state.message}')),
                  if (state is FeedbackEmpty)
                    const Center(child: Text('No feedback yet')),
                ],
              );
            },
            listener: (context, state) {
              if (state is SchoolInfoError) {
                final overlayState = Overlay.of(context);
                customSnackbar(
                    overlayState,
                    "${state.message} Please check your internet connection and try again",
                    Icons.error,
                    Colors.red);
              } else if (state is PostServicesLoading) {
                log('Loading comments...');
              }
            },
          ),
        ),
      ),
    );
  }
}
