import 'package:flutter/material.dart';
import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/widget/widget_wave_animation.dart';
import 'package:software_studio_project/service/service_authentication.dart';
import 'package:provider/provider.dart';
import 'package:software_studio_project/widget/widget_adjust_timetable.dart';

class PageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            Text('User Profile',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        Expanded(
          child: ListView(children: <Widget>[
            Center(
              child: WaveAnimation(
                  size: 200,
                  color: Theme.of(context).colorScheme.onPrimary,
                  centerChild: CircleAvatar(
                    backgroundImage: NetworkImage(
                      userAvatarUrl,
                    ),
                    radius: 50,
                  )),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  userName,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  userEmail,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 262,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              const WidgetAdjustTimetable());
                    },
                    child: Text(
                      'Adjust Time Schedule',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 262,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      'Set Start of Semester',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 262,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ]),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Provider.of<AuthenticationService>(context, listen: false)
                    .logOut();
                isLogin.value = false;
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
              label: Text(
                'Log Out',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (startDate != null && picked != startDate) {
      startDate = picked;
      weekX = (calculateDaysDifference(startDate!)/7).ceil();
    }
  }

  int calculateDaysDifference(DateTime pickedDate) {
    DateTime now = DateTime.now();
    return now.difference(pickedDate).inDays;
  }
}
