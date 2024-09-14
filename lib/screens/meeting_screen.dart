import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vidConnect/resources/jitsi_meeting_methods.dart';
import 'package:vidConnect/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final JitsiMeetingMethod jitsiMeetingMethod = JitsiMeetingMethod();

  void createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(100000000) + 10000000).toString();
    jitsiMeetingMethod.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  void joinMeeting(BuildContext context) async {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
                onPressed: createNewMeeting,
                icon: Icons.videocam,
                text: 'New Meeting'),
            HomeMeetingButton(
                onPressed: () {
                  joinMeeting(context);
                },
                icon: Icons.add_box_rounded,
                text: 'Join Meeting'),
            HomeMeetingButton(
                onPressed: () {}, icon: Icons.calendar_today, text: 'Schedule'),
            HomeMeetingButton(
                onPressed: () {},
                icon: Icons.arrow_upward_rounded,
                text: 'Share Screen'),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with a click',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
