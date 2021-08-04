import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobServices {
  static String get bannerAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1025019081676424/3157077690"
      : "ca-app-pub-1025019081676424/3157077690";

  static String get rewardAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1025019081676424/1022687181"
      : "ca-app-pub-1025019081676424/1022687181";

  static String get interstitialAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1025019081676424/9877564563"
      : "ca-app-pub-1025019081676424/9877564563";

  static initialize() {
    MobileAds.instance.initialize();
  }

  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;
  int num_of_attempt_load = 0;

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
        size: AdSize.fullBanner,
        adUnitId: bannerAdUnitId,
        listener: AdManagerBannerAdListener(
          onAdLoaded: (Ad ad) {
            print("Ad Loaded");
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
          onAdOpened: (Ad ad) {
            print("Ad Opened");
          },
          onAdClosed: (Ad ad) {
            print("On ad closed");
          },
        ),
        request: AdRequest());
    return ad;
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback:
          RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
        this._rewardedAd = ad;
      }, onAdFailedToLoad: (LoadAdError error) {
        loadRewardedAd();
      }),
    );
  }

  void showRewardedAd() {
    _rewardedAd!.show(
      onUserEarnedReward: (RewardedAd ad, RewardItem rpoint) {},
    );

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {},
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) {
        print('$ad immpression occured');
      },
    );
  }

  void createInterad() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          num_of_attempt_load = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          num_of_attempt_load++;
          _interstitialAd = null;

          if (num_of_attempt_load <= 2) {
            createInterad();
          }
        },
      ),
    );
  }

  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("On ad showed full screen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print("Dispose");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print("$ad OnAdFailed $error");
        ad.dispose();
        createInterad();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
