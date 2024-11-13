import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/sign_in/role_desesion.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

class ContainerStudentInfo extends StatelessWidget {
  const ContainerStudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, LocalStudent?>(
      builder: (context, user) {
        final imageFullPath = '${ApiConstants.baseUrl}/${user!.imagePath!.replaceFirst('/', '')}';

        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.lerp(
              const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(2),
              ),
              const BorderRadius.vertical(bottom: Radius.circular(20)),
              6.0,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                const Color.fromARGB(255, 151, 196, 248),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocProvider(
                create: (context) =>
                    NetworkImageCubit()..fetchImage(imageFullPath),
                child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black,
                        child: const CircularProgressIndicator(),
                      );
                    } else if (state is ImageLoaded) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(state.imageData),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('asset/static/image/default_avatar.png'),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 80.0, bottom: 10.0, left: 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName ?? "User"} ${user.lastName ?? "Name"}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.userEmail ?? 'Email',
                      style: const TextStyle(
                          fontFamily: 'Roboto', color: Colors.white),
                    ),
                    Text(
                      user.birthDate ?? 'Birth Date',
                      style: const TextStyle(
                          fontFamily: 'Roboto', color: Colors.white),
                    ),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  iconSize: 40,
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RoleDesesion()),
                    );
                    log('Logout Clicked');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
