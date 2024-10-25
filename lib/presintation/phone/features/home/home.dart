import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/school_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolCubit = GetIt.I<SchoolPagingCubit>();

    return BlocProvider(
      create: (context) => schoolCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Madrasati'),
          centerTitle: true,
        ),
        body: BlocBuilder<SchoolPagingCubit, SchoolPagingState>(
          builder: (context, state) {
            if (state is SchoolInitial) {
              // Fetch schools on initial load
              schoolCubit.fetchSchools();
              return const Center(
                  child:
                      CircularProgressIndicator()); // Show loading indicator on initial load
            } else if (state is SchoolError) {
              return Center(child: Text(state.message));
            } else if (state is SchoolLoaded) {
              return ScrollNotificationWidget(
                scrollController: schoolCubit.scrollController,
                hasMore: state.hasMore,
                onScrollEnd: () {
                  // Trigger fetch only if not already fetching
                  if (!schoolCubit.isFetching) {
                    schoolCubit.fetchSchools();
                  }
                },
                child: ListView.builder(
                  controller: schoolCubit.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.schools.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    
                    if (index == state.schools.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return state.schools[
                        index];
                  },
                ),
              );
            }
            return const Center(child: Text('No schools available.'));
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
