import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';
import 'package:mission_diary/widgets/user_profile/widgets/editable_avatar.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  const UserProfileEditScreen({super.key});

  static const String routePath = "/edit-profile";
  static const String routeName = "edit-profile";

  @override
  ConsumerState<UserProfileEditScreen> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditScreen> {
  late final TextEditingController _bioController;
  late final TextEditingController _nameController;

  bool _isEditActive = false;

  void _onChangedField() {
    setState(() {
      final bio = ref.read(profileProvider).value?.bio;
      final username = ref.read(profileProvider).value?.userName;
      final typedBio = _bioController.text;
      final typedName = _nameController.text;

      _isEditActive = ((bio != typedBio && typedBio.isNotEmpty) ||
              (username != typedName)) &&
          typedName.isNotEmpty;
    });
  }

  Future<void> _onEditTap() async {
    await ref.read(profileProvider.notifier).editUserProfile(
          userName: _nameController.text,
          bio: _bioController.text,
        );
    if (mounted) {
      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(
      text: ref.read(profileProvider).value?.bio,
    );
    _nameController = TextEditingController(
      text: ref.read(profileProvider).value?.userName,
    );
    _isEditActive =
        ref.read(profileProvider).value?.bio != _bioController.text &&
            _bioController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _bioController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: ref.watch(profileProvider).when(
              data: (profile) {
                return ConstraintedBody(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        EditableAvatar(
                          profile: profile,
                          size: Sizes.size48,
                        ),
                        Gaps.v32,
                        TextField(
                          controller: _nameController,
                          maxLines: 1,
                          onChanged: (value) => _onChangedField(),
                          decoration: const InputDecoration(
                            label: Text("username"),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: "Type your username",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Gaps.v32,
                        TextField(
                          controller: _bioController,
                          maxLines: 5,
                          onChanged: (value) => _onChangedField(),
                          decoration: const InputDecoration(
                            label: Text("Description"),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: "Type your info",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Gaps.v48,
                        RoundedButton(
                          onTap: () => _onEditTap(),
                          text: "Edit Profile",
                          centerWidget: ref.watch(profileProvider).isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : null,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          fontColor: Colors.white,
                          isActive: _isEditActive &&
                              !ref.watch(profileProvider).isLoading,
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (err, stack) => Center(
                child: Text("error: $err"),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
      ),
    );
  }
}
