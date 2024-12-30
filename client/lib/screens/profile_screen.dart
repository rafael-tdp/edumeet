import 'package:client/bloc/profile_bloc.dart';
import 'package:client/bloc/profile_event.dart';
import 'package:client/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/language_dropdown.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:client/components/profile_button.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/i18n/generated/translations.g.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';
  static navigateTo(BuildContext context,
      {required Map<String, dynamic> user}) {
    // Navigator.pushNamed(context, routeName, arguments: user);
    context.go(routeName, extra: user);
  }

  final bool isCurrentUser;

  const ProfilePage({
    super.key,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(UserServices())..add(LoadProfileEvent()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileErrorState) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoadedState) {
              final user = state.user;

              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          user.picture ?? '',
                          scale: 1,
                        ),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                      const SizedBox(height: 20),
                      Text(
                        (user.firstname.isNotEmpty && user.lastname.isNotEmpty)
                            ? '${user.firstname.substring(0, 1).toUpperCase()}${user.firstname.substring(1)} ${user.lastname.substring(0, 1).toUpperCase()}${user.lastname.substring(1)} !'
                            : t.user.anonymous,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.bio != null && user.bio!.isNotEmpty
                            ? user.bio!
                            : t.user.noDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      LanguageDropdown(parentContext: context),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.email,
                                  color: AppColors.purple),
                              title: Text(t.user.email),
                              subtitle: Text(user.email),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.person,
                                  color: AppColors.purple),
                              title: Text(t.user.username),
                              subtitle: Text(user.username),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.phone,
                                  color: AppColors.purple),
                              title: Text(t.user.birthdate),
                              subtitle: Text(
                                custom_date_utils.DateUtils.isoToFormattedDate(
                                  user.birthDate.toString(),
                                ),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.location_on,
                                  color: AppColors.purple),
                              title: Text(t.user.location),
                              subtitle: Text(user.address ?? t.user.noAddress),
                            ),
                            // const Divider(),
                            // ListTile(
                            //   leading: const Icon(Icons.report,
                            //       color: AppColors.purple),
                            //   title: Text(t.user.nbReports),
                            //   subtitle: Text(
                            //     user.reportNumber?.toString() ??
                            //         t.user.noReportsAvailable,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10, // Espacement horizontal entre les widgets
                        runSpacing:
                            10, // Espacement vertical si les widgets passent à une nouvelle ligne
                        alignment: WrapAlignment.center,
                        children: [
                          ProfileButton(
                            text: t.profile.editProfile,
                            backgroundColor: AppColors.purple,
                            onPressed: () async {
                              final updatedUser = await context.push(
                                  '$routeName${EditProfilePage.routeName}',
                                  extra: user) as dynamic;
                              if (updatedUser != null) {
                                context
                                    .read<ProfileBloc>()
                                    .add(UpdateProfileEvent(updatedUser));
                              }
                            },
                          ),
                          ProfileButton(
                            text: t.profile.logout,
                            backgroundColor: Colors.redAccent,
                            onPressed: () async {
                              await AuthServices().logout();
                              context.go(LoginPage.routeName);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
