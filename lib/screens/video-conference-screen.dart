import 'package:flutter/material.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';
import 'package:microteams/video-conference/create-meeting.dart';
import 'package:microteams/video-conference/join-meeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  const VideoConferenceScreen({ Key? key }) : super(key: key);

  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen> 
  with SingleTickerProviderStateMixin {

  late TabController tabController;

  buildtab(String name){
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: mystyle(15, black, FontWeight.w600)
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {

    var appBar = AppBar(
      centerTitle: true,
      backgroundColor: purpleSecondary,
      title: Text(
        "MicroTeams",
        style: mystyle(20, white, FontWeight.w600),
      ),
      bottom: TabBar(
        controller: tabController,
        tabs: [
          buildtab("Join Meeting"),
          buildtab("Create Meeting")
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}