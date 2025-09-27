import 'package:flutter/cupertino.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required String contentId});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text('Detalhes do Evento'),
      ),
    );
  }
}
