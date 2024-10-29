import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SchoolPagingCubit>()..fetchSchools(),
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
                if (!cubit.isFetching) {
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
                    child: cubit.schools[index],
                  );
                },
              ),
            );
          }, listener: (BuildContext context, SchoolPagingState state) {
            if (state is SchoolError) {
              log(state.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("${state.message} Please check your internet connection and try again"),
                ),
              );
            }else if (state is SchoolLoading) {
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
