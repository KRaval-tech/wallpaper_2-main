import 'dart:async';


//import 'package:ads/ads/admob_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'package:wallpaper_2/widgets/custom_bar_app.dart';
import '../../Ads/admob_helper.dart';
import 'bloc/pricing_bloc.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class PaywallScreen extends StatefulWidget {
  final bool fromBottomBar; // Flag to check origin

  const PaywallScreen({super.key, this.fromBottomBar = false});

  //  final Function(bool) onTrialStarted; // Callback to update subscription status
  //
  // PaywallScreen({super.key, required this.onTrialStarted});


  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => PricingBloc(),
      child: const PaywallScreen(
        //onTrialStarted: (bool){},
      ),
    );
  }

  @override
  _PaywallScreenState createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> with TickerProviderStateMixin{

  Map<String, dynamic>? paywallData;
  String? selectedSku;  // Store the selected SKU
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;


  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: const Offset(0, 0), // End at the normal position
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    // Start the animation when the screen appears
    _animationController.forward();

    //checkTrialStatus(); // Check trial status on initialization
    _loadPaywallData().then((_) {
      context.read<PricingBloc>().add(FetchPricingEvent([]));
      selectedSku = paywallData?['pricing']['cards'][1]['sku']; // Assuming the first card is yearly
    });
    InAppPurchase.instance.purchaseStream.listen(_onPurchaseUpdated);
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        print("Purchase successful: ${purchase.productID}");
      } else if (purchase.status == PurchaseStatus.error) {
        print("Purchase failed: ${purchase.error?.message}");
      } else if (purchase.status == PurchaseStatus.restored) {
        print("Purchase restored: ${purchase.productID}");
      }
    }
  }




  Future<void> _loadPaywallData() async {
    final String response = await rootBundle.loadString(
        'assets/paywall_design.json');
    setState(() {
      paywallData = json.decode(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: paywallData == null
             ?  Container()//Center(child: CircularProgressIndicator())
             : SlideTransition(
            position: _slideAnimation,
            child: Stack(
                    children: [
            _buildBackground(paywallData!["background"]),
            BlocBuilder<PricingBloc, PricingState>(
              builder: (context, state) {
                if (state is PricingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PricingLoaded) {
                  return _buildContent(paywallData!, state.prices);
                } else if (state is PricingError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return Container();
              },
            ),
            // SizedBox(height: 20,),
            _buildTopButtons(paywallData!["topButtons"]),
                    ],
                  ),
          ),
    );
  }



  ///for network image
  Widget _buildBackground(Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(data['image']), // Load image from URL
          fit: BoxFit.cover, // Ensures the image covers the container
        ),
      ),
    );
  }


  Widget _buildContent(Map<String, dynamic> data, Map<String, String> prices) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.35), // Space above title

          // Wallpaper PRO text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wallpaper",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: data['header']['title']['style']['fontSize'].toDouble(),
                  color: Colors.white,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 5.h,),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: data['header']['title']['proText']['style']['paddingVertical'].toDouble(),
                  horizontal: data['header']['title']['proText']['style']['paddingHorizontal'].toDouble(),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                      data['header']['title']['proText']['style']['borderRadius'].toDouble()),
                  border: Border.all(
                    color: const Color(0xFFFFD700), // Gold color for border
                  ),
                ),
                child: Text(
                  data['header']['title']['proText']['text'],
                  style: TextStyle(
                      fontSize: data['header']['title']['proText']['style']['fontSize'].toDouble(),
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Text(
            data['header']['subtitle']['text'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: data['header']['subtitle']['style']['fontSize'].toDouble(),
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          _buildFeatureCards(data['features']),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: _buildPriceCard(
                    data['pricing']['cards'][0], prices['android.test.purchased'])),
                const SizedBox(width: 20),
                Expanded(child: _buildPriceCard(
                    data['pricing']['cards'][1], prices['android.test.canceled'])),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      data['cta']['button']['style']['borderRadius'].toDouble()),
                ),
              ),
              onPressed: () => print("Start Trial Pressed"),
              //onPressed: _startTrial,
              child: Container(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      data['cta']['button']['text'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: data['cta']['button']['style']['fontSize'].toDouble(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildFooter(data['footer']),
        ],
      ),
    );
  }


  // void _startTrial() {
  //   // Logic to start the trial subscription
  //   AdMobHelper().isSubscribed = true;
  //   widget.onTrialStarted(true); // Notify AdsScreen that the trial has started
  //   print('Trial started, ads will not be shown.');
  //   //Fluttertoast.showToast(msg: 'Trial started, user is now subscribed. Ads will not be shown.');
  //   Navigator.pop(context); // Close the paywall screen
  // }

  // void _startTrial() async {
  //   // Logic to start the trial subscription
  //   AdMobHelper().isSubscribed = true;
  //
  //   // Set trial end time to 10 minutes from now
  //   final prefs = await SharedPreferences.getInstance();
  //   final trialEndTime = DateTime.now().add(Duration(minutes: 10)).millisecondsSinceEpoch;
  //   await prefs.setInt('trialEndTime', trialEndTime);
  //
  //   widget.onTrialStarted(true); // Notify AdsScreen that the trial has started
  //   print('Trial started, ads will not be shown.');
  //   Navigator.pop(context); // Close the paywall screen
  // }
  //
  // void endSubscription() async {
  //   AdMobHelper().isSubscribed = false; // Set subscription status to false
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('trialEndTime'); // Clear the trial end time
  //
  //   print('Subscription ended, ads will be shown.');
  //   loadAds(); // Load ads after ending the subscription
  // }
  //
  // void loadAds() {
  //   if (!AdMobHelper().isSubscribed) {
  //     // Load and show ads
  //     print('Loading ads...');
  //     // Your ad loading logic here
  //   } else {
  //     print('No ads to show, user is subscribed.');
  //   }
  // }
  //
  //
  // void restoreSubscription() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final trialEndTime = prefs.getInt('trialEndTime');
  //
  //   if (trialEndTime != null) {
  //     // Check if the trial is still active
  //     if (DateTime.now().millisecondsSinceEpoch <= trialEndTime) {
  //       AdMobHelper().isSubscribed = true;
  //       print('Subscription restored, trial is still active.');
  //     } else {
  //       print('No active subscription found.');
  //     }
  //   } else {
  //     print('No active subscription found.');
  //   }
  // }



  Widget _buildFeatureCards(List<dynamic> featureCardsData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: featureCardsData.map<Widget>((card) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.3, // Responsive width
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(card['icon'], height: 24, width: 24, color: Colors.white,),
                  const SizedBox(height: 8),
                  Text(
                    card['text'],
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPriceCard(Map<String, dynamic> card, String? price) {
    bool isSelected = card['sku'] == selectedSku;  // Check if this card is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSku = card['sku'];  // Update selected SKU for visual highlighting
        });
        _subscribeToPlan(card['sku']);  // Call the subscription function
      },
      child: Container(
        width: 150,
        height: 150,
        padding: EdgeInsets.all(card['style']['padding'].toDouble()),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white, // Highlight border when selected
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(card['style']['borderRadius'].toDouble()),
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,  // Highlight background
        ),
        child: Stack(
          children:[ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card['label'],
                style: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
              ),
              //SizedBox(height: 2),  // Reduced padding between label and price
              if (price != null)
                Text(
                  price,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              const SizedBox(height: 15,),
              Text(
                card['billingPeriod'],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
            // Icon in the top-right corner if selected
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: SvgPicture.asset(
                  'assets/images/selected_icon.svg', // Replace with your icon path
                  width: 24,
                  height: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }


  void _subscribeToPlan(String sku) async {
    final ProductDetailsResponse response = await InAppPurchase.instance
        .queryProductDetails({sku});
    if (response.productDetails.isNotEmpty) {
      final PurchaseParam purchaseParam = PurchaseParam(
          productDetails: response.productDetails.first);
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      print("Product not found for SKU: $sku");
    }
  }

  Widget _buildFooter(Map<String, dynamic> footerData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: footerData['links'].map<Widget>((link) {
            return TextButton(
              onPressed: () {
                // Open URL
                print("Opening ${link['url']}");
              },
              child: Text(
                link['label'],
                style: TextStyle(
                  fontSize: footerData['style']['fontSize'].toDouble(),
                  color: Colors.white70,
                ),
              ),
            );
          }).toList(),
        ),
        if (footerData.containsKey('additionalText')) // Display additional text
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              footerData['additionalText']['text'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: footerData['additionalText']['style']['fontSize'].toDouble(),
                color: Colors.white70,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopButtons(List<dynamic> buttonsData) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0), // Adjust this to space everything down
      child: Stack(
        children: [
          // Handling the Leading Icon (Cancel) Button
          if (buttonsData.any((button) => button['onPress'] == 'cancelAction'))
            Positioned(
              top: buttonsData.firstWhere((button) => button['onPress'] == 'cancelAction')['position']['top'].toDouble(),
              left: buttonsData.firstWhere((button) => button['onPress'] == 'cancelAction')['position']['left']?.toDouble() ?? 0.0,
              child: GestureDetector(
                onTap: () {
                  // Cancel Action Logic
                  //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> CustomBottomBarApp()));
                  //Navigator.pop(context);
                  // Navigation logic based on the `fromBottomBar` flag
                  if (widget.fromBottomBar) {
                    // Navigate to CustomBottomBarApp
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomBottomBarApp()),
                          (route) => false, // Clear all previous routes
                    );
                  } else {
                    // Simply pop the current screen
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0), // Adjust space from the left
                  child: SvgPicture.network(
                    buttonsData.firstWhere((button) => button['onPress'] == 'cancelAction')['icon'],
                    height: 32,
                    width: 32, // Leading icon size (32x32)
                  ),
                ),
              ),
            ),

          // Handling the Trailing Icon (Restore) Button
          if (buttonsData.any((button) => button['onPress'] == 'restoreAction'))
            Positioned(
              top: buttonsData.firstWhere((button) => button['onPress'] == 'restoreAction')['position']['top'].toDouble(),
              right: buttonsData.firstWhere((button) => button['onPress'] == 'restoreAction')['position']['right']?.toDouble(),
              child: GestureDetector(
                //onTap: restoreSubscription,
                onTap: () {

                  // Restore Action Logic
                  print("Restore purchases triggered");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0), // Adjust space for trailing icon
                  child: Image.network(
                    buttonsData.firstWhere((button) => button['onPress'] == 'restoreAction')['icon'],
                    height: 32,
                    width: 100, // Trailing icon size (99x32),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // void _restorePurchases() async {
  //   // Logic to restore purchases
  //   // Assuming you have a method to check if the user has an active subscription
  //   bool hasActiveSubscription = await checkActiveSubscription();
  //   if (hasActiveSubscription) {
  //     AdMobHelper().isSubscribed = true; // Set subscription status to true
  //     print('Purchases restored, ads will not be shown.');
  //   } else {
  //     print('No active subscription found.');
  //   }
  // }


}

