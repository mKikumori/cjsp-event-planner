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
          CustomRowSliderWidget(
            rowId: '8973690414',
            title: 'Membros - Total 4 (1 faltante)',
            contentTypeToggle: 1, // 1 for members and 2 for intruments
            items: [
              {
                'id': 1,
                'name': 'Matheus',
              },
              {
                'id': 2,
                'name': 'João',
              },
              {
                'id': 3,
                'name': 'Maria',
              },
            ],
            onCardTap: (int index, Map<String, dynamic> item) {},
            onSeeMoreTap: (int memberId) {},
          ),
          const SizedBox(height: 15),
          Text('Horário: Início do Espetáculo', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          CustomRowSliderWidget(
            rowId: '9078926349',
            title: 'Instrumentos - Total 4 (1 faltante)',
            contentTypeToggle: 2, // 1 for members and 2 for intruments
            items: [
              {
                'id': 1,
                'name': 'Guitarra',
              },
              {
                'id': 2,
                'name': 'Microfone',
              },
              {
                'id': 3,
                'name': 'Bateria',
              },
              {
                'id': 4,
                'name': 'Teclado',
              },
            ],
            onCardTap: (int index, Map<String, dynamic> item) {},
            onSeeMoreTap: (int instrumentId) {},
            instruments: true,
          ),
          const SizedBox(height: 15),
          Text('Observações:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Quero tocar essa música! Tenho guitarra e microfone, mas falta a bateria.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    )));
  }
}
