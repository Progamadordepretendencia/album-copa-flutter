import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fwc_album_app/app/core/ui/helpers/loader.dart';
import 'package:fwc_album_app/app/core/ui/helpers/messages.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/home/presenter/home_presenter.dart';
import 'package:fwc_album_app/app/pages/home/view_bloc/home_state.dart';
import 'package:fwc_album_app/app/pages/home/view_bloc/home_view.dart';
import 'package:fwc_album_app/app/pages/home/widgets/status_tile.dart';
import 'package:fwc_album_app/app/pages/home/widgets/sticker_percent_widget.dart';
// import 'package:fwc_album_app/app/pages/home/widgets/sticker_percent_dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  final HomeView view;

  const HomePage({
    Key? key,
    required this.presenter,
    required this.view,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with Loader<HomePage>, Messages<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.presenter.getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeView, HomeState>(
      bloc: widget.view,
      listener: (context, state) {
        switch (state.status) {
          case HomeStatus.initial:
            break;
          case HomeStatus.logout:
            hideLoader();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/auth/login', (route) => false);
            break;
          case HomeStatus.error:
            hideLoader();
            showError(state.message ?? '');
            break;
          case HomeStatus.loaded:
            hideLoader();
            break;
          case HomeStatus.loading:
            showLoader();
            break;
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.primary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.colors.primary,
          actions: [
            IconButton(
                onPressed: () => widget.presenter.logout(),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
          ),
          child: LayoutBuilder(
            builder: (_, constrains) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constrains.maxHeight),
                child: Center(
                  child: SingleChildScrollView(
                    child: BlocBuilder<HomeView, HomeState>(
                      bloc: widget.view,
                      builder: (context, state) {
                        final user = state.user;
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 35),
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                'assets/images/bola.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            StickerPercentWidget(
                              percent: user?.totalCompletePercent ?? 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${user?.totalStickers ?? 0} figurinhas',
                              style: context.textStyles.titleWhite,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StatusTile(
                              icon: Image.asset('assets/images/all_icon.png'),
                              label: 'Todas',
                              value: user?.totalAlbum ?? 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StatusTile(
                              icon: Image.asset('assets/images/missing_icon.png'),
                              label: 'Faltando',
                              value: user?.totalComplete ?? 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StatusTile(
                              icon: Image.asset('assets/images/repeated_icon.png'),
                              label: 'Repetidas',
                              value: user?.totalDuplicates ?? 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Button(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/my-stickers');
                              },
                              width: MediaQuery.of(context).size.width * .9,
                              outline: true,
                              style: context.buttonStyles.yellowOutlineButton,
                              labelStyle: context
                                  .textStyles.textSecondaryFontExtraBold
                                  .copyWith(color: context.colors.yellow),
                              label: 'Minhas Figurinhas',
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
