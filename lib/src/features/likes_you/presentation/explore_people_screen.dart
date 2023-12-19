import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_widgets/explore_people_app_bar_widget.dart';
import 'package:sarang_app/src/common_widgets/explore_people_button_widget.dart';
import 'package:sarang_app/src/common_widgets/match_card_widget.dart';
import 'package:sarang_app/src/features/likes_you/data/data_user_account_local.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_account.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/explore_people/explore_people_bloc.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/people_loved/people_loved_bloc.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';

class ExplorePeopleScreen extends StatefulWidget {
  static const String routeName = '/explore-people';
  const ExplorePeopleScreen({super.key});

  @override
  State<ExplorePeopleScreen> createState() => _ExplorePeopleScreenState();
}

class _ExplorePeopleScreenState extends State<ExplorePeopleScreen> {
  UserAccount? account;
  final cardController = AppinioSwiperController();

  getDataUserAccount() async {
    final data = await DataUserAccountLocal.getDataUserAccountFromStorage();
    final result = UserAccount.fromMap(data);
    account = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<ExplorePeopleBloc>().add(OnExplorePeopleEventCalled());
    getDataUserAccount();
  }

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p40,
          horizontal: AppPadding.p24,
        ),
        child: Column(
          children: [
            ExplorePeopleAppBarWidget(
              imagePath: account?.imageProfile,
            ),
            SizedBox(
              height: AppSize.s50,
            ),
            BlocBuilder<ExplorePeopleBloc, ExplorePeopleState>(
              builder: (context, state) {
                if (state is ExplorePeopleLoading) {
                  return CircularProgressIndicator();
                }
                if (state is ExplorePeopleLoaded) {
                  final users = state.result;
                  List<Widget> cards = [];
                  for (var user in users){
                    cards.add(MatchCardWidget(user: user));
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: AppinioSwiper(
                            direction: AppinioSwiperDirection.top,
                            controller: cardController,
                            onSwipe: (
                              int index,
                              AppinioSwiperDirection direction
                            ){
                              if (direction == AppinioSwiperDirection.top) {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Yey!, you matched with ${users[index].fullName}'
                                    ),
                                  ),
                                );
                                if (direction != AppinioSwiperDirection.left && 
                                    direction != AppinioSwiperDirection.right && 
                                    direction != AppinioSwiperDirection.bottom) {
                                  context.read<PeopleLovedBloc>().add(
                                    AddPeopleLoved(user: users[index]),
                                  );
                                }
                              }
                            },
                            onEnd: () {
                              context
                                  .read<ExplorePeopleBloc>()
                                  .add(OnExplorePeopleEventCalled());
                            },
                            padding: EdgeInsets.zero,
                            cards: cards,
                        ),
                      ),
                        SizedBox(
                          height: AppSize.s50,
                        ),
                        ExplorePeopleButtonWidget(
                          controller: cardController,
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
