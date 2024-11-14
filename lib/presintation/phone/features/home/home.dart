import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolPagingCubit()..fetchSchools(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Madrasati'),
          centerTitle: true,
        ),
        body: BlocConsumer<SchoolPagingCubit, SchoolPagingState>(
          builder: (context, state) {
            final cubit = context.read<SchoolPagingCubit>();
            return ScrollNotificationWidget(
              scrollController: cubit.scrollController,
              hasMore: cubit.hasMore,
              onScrollEnd: () {
                if (!cubit.isFetching && cubit.hasMore) {
                  cubit.fetchSchools();
                }
              },
              child: ListView.builder(
                controller: cubit.scrollController,
                itemCount: cubit.schools.length + (cubit.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == cubit.schools.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SchoolCard(
                      schoolName: cubit.schools[index].schoolName,
                      schoolType: cubit.schools[index].schoolType,
                      rating: cubit.schools[index].averageRating??0,
                      id: cubit.schools[index].id,
                      imagePath: cubit.schools[index].schoolCoverImage,
                    ),
                  );
                },
              ),
            );
          },
          listener: (BuildContext context, SchoolPagingState state) {
            if (state is SchoolError) {
              log(state.message);
              final overLay = Overlay.of(context);
              customSnackbar(overLay, state.message, Icons.error, Colors.red);
            } else if (state is SchoolLoading) {
              log('SchoolLoading');
            }
          },
        ),
      ),
    );
  }
}

class ScrollNotificationWidget extends StatelessWidget {
  final bool hasMore;
  final VoidCallback onScrollEnd;
  final Widget child;
  final ScrollController scrollController;

  const ScrollNotificationWidget({
    super.key,
    required this.hasMore,
    required this.onScrollEnd,
    required this.child,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            hasMore) {
          onScrollEnd();
        }
        return true;
      },
      child: child,
    );
  }
}
