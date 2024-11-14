import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/cubit/pick_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final TextEditingController captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickImageCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('School Name'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<PickImageCubit, PickImageState>(
              builder: (context, state) {
                Widget? preview;

                if (state is PickImageSuccess &&
                    state.selectedFiles.isNotEmpty) {
                  preview = Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: state.selectedFiles.map((file) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          file!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is PickImageFailure) {
                  preview = Text(
                    state.message,
                    style: TextStyle(color: Colors.red),
                  );
                } else if (state is PickImageLoading) {
                  preview = CircularProgressIndicator();
                }

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add Post',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: captionController,
                        decoration: InputDecoration(
                          hintText: 'Write Something.....',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        maxLines: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: context.read<PickImageCubit>().pickImages,
                              child: Icon(Icons.add_a_photo_outlined),
                            ),
                          ),
                        ],
                      ),
                      if (preview != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: preview,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: BlocProvider(
                          create: (context) => PostServicesCubit(),
                          child: Builder(
                            builder: (context) {
                              return ElevatedButton(
                                onPressed: () async {
                                if(state is PickImageSuccess && state.selectedFiles.isNotEmpty){
                                  context.read<PostServicesCubit>().createPost(getIt<UserBox>().getGroupId()!, state.pathes, captionController.text);
                                }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 12),
                                ),
                                child: Text(
                                  'Post',
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
