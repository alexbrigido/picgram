import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:picgram/app/Constants.dart';
import 'package:picgram/app/modules/onboarding/onboarding_store.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  const OnboardingPage({Key? key, this.title = 'PicGram'}) : super(key: key);

  @override
  OnboardingPageState createState() => OnboardingPageState();
}
class OnboardingPageState extends State<OnboardingPage> {

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          _OnboardingItem(
              image: AssetImage('assets/undraw_group.png'),
              text: 'Compartilhe e veja fotos dos seus amigos!'
          ),
          _OnboardingItem(
              image: AssetImage('assets/undraw_mobile.png'),
              text: 'Compartilhe e veja fotos dos seus amigos!'
          ),
          _OnboardingItem(
              image: AssetImage('assets/undraw_swipe.png'),
              text: 'Compartilhe seus melhores momentos!',
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      store.markOnboardingDone();
                      Modular.to.pushReplacementNamed(Constants.Routes.REGISTER);
                    },
                    child: Text('CADASTRE-SE')
                ),
                SizedBox(height: 24),
                TextButton(
                    child: Text('Já tem cadastro?'),
                    onPressed: () {
                      store.markOnboardingDone();
                      Modular.to.pushReplacementNamed(Constants.Routes.LOGIN);
                  },
                )

              ],
            ),
          ),
        ],
      )
    );
  }
}


class _OnboardingItem extends StatelessWidget {

  final ImageProvider image;
  final String text;
  final Widget? child;

  _OnboardingItem({
    required this.image,
    required this.text,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 96
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image(image: image, fit: BoxFit.fitWidth),
          ),
          SizedBox(height: 32),
          Text(text, style: TextStyle(fontSize: 20, fontWeight:  FontWeight.w200),
          textAlign: TextAlign.center
          ),
          child ?? SizedBox.fromSize(size: Size.zero)
        ],
      ),
    );
  }

}