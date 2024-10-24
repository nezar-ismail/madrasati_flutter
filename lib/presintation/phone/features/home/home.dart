import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/school_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolCubit = GetIt.I<SchoolCubit>();

    return BlocProvider(
      create: (context) => schoolCubit..fetchSchools(), // Pass your token here
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Madrasati'),
          centerTitle: true,
        ),
        body: BlocBuilder<SchoolCubit, SchoolState>(
          builder: (context, state) {
            if (state is SchoolLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SchoolError) {
              return Center(child: Text(state.message));
            } else if (state is SchoolLoaded) {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && state.hasMore) {
                    context.read<SchoolCubit>().fetchSchools();
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: state.schools.length + (state.hasMore ? 1 : 0), // Show loading indicator if more schools are available
                  itemBuilder: (context, index) {
                    if (index == state.schools.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SchoolDetailPage()),
                        );
                      },
                     child: state.schools[index], // This is now a widget
                    );
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
