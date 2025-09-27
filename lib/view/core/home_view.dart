import 'package:event_planner/view/core/event_details_view.dart';
import 'package:event_planner/view_model/core/home_viewmodel.dart';
import 'package:event_planner/widgets/background_widget.dart';
import 'package:event_planner/widgets/custom_content_widget.dart';
import 'package:event_planner/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  /// Loads home screen data asynchronously.
  // void _loadHomeData() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<HomeViewModel>(context, listen: false).loadHomeData();
  //   });
  // }

  /// Refreshes home screen data.
  /*Future<void> _refresh() async {
    print('[HomeView] pull-to-refresh');
    await Provider.of<HomeViewModel>(context, listen: false).loadHomeData();
    print('[HomeView] refresh completed');
  }*/

  @override
  Widget build(BuildContext context) {
    print("[HomeView] Building HomeView");

    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return BackgroundWidget(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeaderWidget(),
            Expanded(
              child: ListView(
                  padding: const EdgeInsets.all(16),
                  scrollDirection: Axis.vertical,
                  children: [
                    // Add your home view content here.
                    const SizedBox(height: 20),

                    // Tag scroller
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  CupertinoColors.systemBlue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Tag ${index + 1}',
                              style: const TextStyle(
                                color: CupertinoColors.systemBlue,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Content area
                    const SizedBox(height: 20),

                    CustomContentWidget(
                      contentId: '123456789',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                EventDetailsView(contentId: '123456789'),
                          ),
                        );
                      },
                      eventName: 'Lanterna dos Afogados - Cássia Eller',
                      currentMembers: [
                        'Alice',
                        'Bob',
                        'Charlie',
                      ],
                      category: 'MPB',
                      remarks: 'Quero tocar essa música!',
                      totalMembers: 4,
                      intrumentsList: [
                        'Guitarra',
                        'Bateria',
                        'Piano',
                      ],
                      timeFrame: 'No Final',
                      seekingMembers: true,
                      status: 'Organizando',
                      type: 'Música',
                    ),

                    const SizedBox(height: 20),

                    CustomContentWidget(
                      contentId: '987654321',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                EventDetailsView(contentId: '987654321'),
                          ),
                        );
                      },
                      eventName: "Let's Get It Started - Black Eyed Peas",
                      currentMembers: [
                        'Dave',
                        'Eve',
                        'Frank',
                      ],
                      category: 'Eletrônica',
                      remarks: 'Animar a galera!',
                      totalMembers: 5,
                      intrumentsList: [
                        'Guitarra',
                        'Microfone',
                        'Piano',
                      ],
                      timeFrame: 'No Começo',
                      seekingMembers: true,
                      status: 'Ensaiando',
                      type: 'Música',
                    ),

                    const SizedBox(height: 20),

                    CustomContentWidget(
                      contentId: '76234876',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                EventDetailsView(contentId: '76234876'),
                          ),
                        );
                      },
                      eventName: "Sexy And I Know It - LMFAO",
                      currentMembers: [
                        'Dave',
                        'Frank',
                      ],
                      category: 'Eletrônica',
                      remarks: 'Preciso do palco limpo para dançar',
                      totalMembers: 2,
                      timeFrame: 'No Meio',
                      seekingMembers: false,
                      status: 'Pronto',
                      type: 'Dança',
                    ),

                    const SizedBox(height: 20),

                    CustomContentWidget(
                      contentId: '926423186',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                EventDetailsView(contentId: '926423186'),
                          ),
                        );
                      },
                      eventName:
                          "Canto de regresso à pátria - Oswald de Andrade",
                      currentMembers: [
                        'Gabriel',
                      ],
                      category: 'Posia',
                      remarks: 'Quero usar o telão',
                      totalMembers: 1,
                      timeFrame: 'No Fim',
                      seekingMembers: false,
                      status: 'Ensaiando',
                      type: 'Poesia',
                    ),
                  ]),
            ),
          ],
        ));
      },
    );
  }
}
