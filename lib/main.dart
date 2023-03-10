import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: background,
        body: introductionPage(),
      ),
    );
  }
}

class introductionPage extends StatefulWidget {
  const introductionPage({Key? key}) : super(key: key);

  @override
  State<introductionPage> createState() => _MyAppState();
}

PageModel CreatePage(String header, String content, int imageNumber) {
  return PageModel(
    widget: DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 44, 64, 91),
        border: Border.all(
          width: 0.0,
          color: background,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisSize: MainAxisSize.,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 60.0,
              ),
              child: Image.asset(
                'images/Nakliyeci$imageNumber.png',
                //fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    '$header',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    '$content',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _MyAppState extends State<introductionPage> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    CreatePage('??LANLAR',
        '??lanlar??n g??r??nt??lemek i??in ilanlar sekmesine t??klay??n.', 1),
    CreatePage(
        'F??LTRELER',
        'Size uygun ??ehir, mesafe, ara?? tipini filtrelerden kolayca filtreyebilirsiniz.',
        2),
    CreatePage('Y??KLER', 'Size filtreledi??iniz y??k?? se??in.', 3),
    CreatePage('Y??K SAH??B??NE ULA??MAK',
        'Firma ad?? ve telefon numaras??n?? g??r??nt??lemek i??in NAKU harcay??n.', 4),
    CreatePage(
        '??RT??BAT',
        '??rtibat numaras?? ve firma ismine ula??t??ktan sonra y??k sahibini aray??n.',
        5),
    CreatePage('Y??K ??LANI VER??N',
        'E??er elinizde y??k varsa tedarik??i olup ilan verebilirsiniz.', 6),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: BorderRadius.circular(6.0),
      color: Colors.deepOrange,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 5;
            setIndex(5);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Tan??t??m?? Ge??',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
      color: Colors.deepOrange,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {},
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Uygulamaya D??n',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter onBoard Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                border: Border.all(
                  width: 0.0,
                  color: background,
                ),
              ),
              child: ColoredBox(
                color: Color.fromARGB(255, 44, 64, 91),
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.line(
                            lineDesign: LineDesign(
                              lineType: DesignType.line_uniform,
                            ),
                          ),
                        ),
                      ),
                      index == pagesLength - 1
                          ? _signupButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
