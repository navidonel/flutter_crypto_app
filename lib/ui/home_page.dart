import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu/models/crypto_model/crypto_data.dart';
import 'package:edu/network/respnse_model.dart';
import 'package:edu/providers/crypto_data_provider.dart';
import 'package:edu/ui/global_widget/theme_switcher.dart';
import 'package:edu/ui/helper/decimal_rounder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'global_widget/home_page_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);

  var defaultIndex = 0;

  final List<String> _choicesList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final CryptoDataProvider cryptoDataProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoDataProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoProvider = Provider.of<CryptoDataProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: const [
          ThemeSwitcher(),
        ],
        title: const Text("koala prof"),
        titleTextStyle: textTheme.titleLarge,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                            ),
                            onDotClicked: (index) =>
                                _pageViewController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text:
                      'BTC : 70000\$ | ETC : 4000\$ | DOGE : 0.17000\$ | EURUSD : 1.2 | GOLD : 1200\$ |',
                  style: textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.all(20),
                            primary: Colors.green[700]),
                        child: Text("BUY"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.all(20),
                            primary: Colors.red[700]),
                        child: Text("SELL"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: List.generate(
                        _choicesList.length,
                        (index) => ChoiceChip(
                          label: Text(
                            _choicesList[index],
                            style: textTheme.titleSmall,
                          ),
                          selected: defaultIndex == index,
                          selectedColor: Colors.blue,
                          onSelected: (value) {
                            setState(() {
                              defaultIndex = value ? index : defaultIndex;
                              switch (index) {
                                case 0:
                                  cryptoProvider.getTopMarketCapData();
                                  break;
                                case 1:
                                  cryptoProvider.getTopGainerData();
                                  break;
                                case 2:
                                  cryptoProvider.getTopLosersData();
                                  break;
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Consumer<CryptoDataProvider>(
                  builder: (context, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case SStatus.LOADING:
                        return SizedBox(
                            height: 80,
                            child: Shimmer.fromColors(
                              baseColor: Color(0xff7997B0),
                              highlightColor: Color(0xffE6F1F5),
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, bottom: 8, left: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: SizedBox(
                                          width: 70,
                                          height: 40,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ));
                        break;
                      case SStatus.COMPLETED:
                        List<CryptoData>? model = cryptoDataProvider
                            .dataFuture.data!.cryptoCurrencyList;

                        print(model![1].id);
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            var number = index + 1;
                            MaterialColor filterColor =
                                DecimalRounder.setColorFilter(
                                    model[index].quotes![0].percentChange24h);
                            var finalPrice = DecimalRounder.removePriceDecimals(
                                model[index].quotes![0].price);
                            var percentChange =
                                DecimalRounder.removeChartPriceDecimals(
                                    model[index].quotes![0].percentChange24h);
                            var percentColor =
                                DecimalRounder.setPercentChangesColor(
                                    model[index].quotes![0].percentChange24h);
                            var percentIcon =
                                DecimalRounder.setPercentChangesIcon(
                                    model[index].quotes![0].percentChange24h);
                            return SizedBox(
                              height: height * 0.075,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      number.toString(),
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 15,
                                    ),
                                    child: CachedNetworkImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 500),
                                        height: 32,
                                        width: 32,
                                        imageUrl:
                                            "https://s2.coinmarketcap.com/static/img/coins/64x64/${model[index].id}.png",
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error)),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model[index].name!,
                                          style: textTheme.bodySmall,
                                        ),
                                        Text(
                                          model[index].symbol!,
                                          style: textTheme.labelSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          filterColor, BlendMode.srcATop),
                                      child: SvgPicture.network(
                                          'https://s3.coinmarketcap.com/generated/sparklines/web/7d/2781/${model[index].id}.svg'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "\$$finalPrice",
                                            style: textTheme.bodySmall,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              percentIcon,
                                              Text(
                                                percentChange + "%",
                                                style: GoogleFonts.ubuntu(
                                                    color: percentColor,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: 10,
                        );

                        break;
                      case SStatus.ERROR:
                        return Text(cryptoDataProvider.state.message);

                        break;
                      default:
                        return Text('notiho');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
