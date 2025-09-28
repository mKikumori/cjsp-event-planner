import 'package:event_planner/widgets/background_widget.dart';
import 'package:event_planner/widgets/custom_row_slider_widget.dart';
import 'package:event_planner/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required String contentId});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
        child: Expanded(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeaderWidget(),
          const SizedBox(height: 20),
          Text(
            'Let\'s Get It Started - The Black Eyed Peas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Música",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                " - ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "Eletrônica",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text('Ensaiando', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          //CustomRowSliderWidget(),
          const SizedBox(height: 15),
        ],
      ),
    )));
  }
}
