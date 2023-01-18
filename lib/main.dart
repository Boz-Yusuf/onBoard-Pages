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
    CreatePage('İLANLAR',
        'İlanların görüntülemek için ilanlar sekmesine tıklayın.', 1),
    CreatePage(
        'FİLTRELER',
        'Size uygun şehir, mesafe, araç tipini filtrelerden kolayca filtreyebilirsiniz.',
        2),
    CreatePage('YÜKLER', 'Size filtrelediğiniz yükü seçin.', 3),
    CreatePage('YÜK SAHİBİNE ULAŞMAK',
        'Firma adı ve telefon numarasını görüntülemek için NAKU harcayın.', 4),
    CreatePage(
        'İRTİBAT',
        'İrtibat numarası ve firma ismine ulaştıktan sonra yük sahibini arayın.',
        5),
    CreatePage('YÜK İLANI VERİN',
        'Eğer elinizde yük varsa tedarikçi olup ilan verebilirsiniz.', 6),
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
            'Tanıtımı Geç',
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
            'Uygulamaya Dön',
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
