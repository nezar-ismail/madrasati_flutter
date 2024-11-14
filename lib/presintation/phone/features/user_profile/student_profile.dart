import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/core/utils/button_service.dart';
import 'package:madrasati/presintation/phone/features/user_profile/widgets/edit_password.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    String imageUrl = getIt<UserBox>().getUser()!.imagePath!;
    String imageFullUrl = ApiConstants.baseUrl + imageUrl;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Student Profile'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: getIt<UserBox>().getUser() == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: BlocProvider(
                      create: (_) =>
                          NetworkImageCubit()..fetchImage(imageFullUrl),
                      child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                        builder: (context, state) {
                          if (state is ImageLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is ImageLoaded) {
                            return DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(50),
                              dashPattern: const [10, 10],
                              color: Colors.blueAccent,
                              strokeWidth: 2,
                              strokeCap: StrokeCap.round,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(state.imageData),
                              ),
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/images/default_profile.png'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${getIt<UserBox>().getUser()!.firstName ?? ""} ${getIt<UserBox>().getUser()!.lastName ?? ""}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      getIt<UserBox>().getUser()!.userEmail ??
                          "Email not available",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Column(children: [
                      Expanded(
                        child: ProfileInfoRow(
                          label: "Gender",
                          value: getIt<UserBox>().getUser()!.gender ??
                              "Not specified",
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoRow(
                          label: "Birth Date",
                          value: getIt<UserBox>().getUser()!.birthDate ??
                              "Not specified",
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoRow(
                          label: "School Name",
                          value: getIt<UserBox>().getUser()!.schoolName ??
                              "Not specified",
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoRow(
                          label: "Password",
                          value: "********",
                        ),
                      ),
                    ]),
                  ),
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width - 100,
                      child: ButtonService(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditPasswordScreen(),
                            ),
                          );
                        },
                        text: 'Edit Password',
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Expanded(
          child: Row(
            children: [
              Text(
                '$label:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
