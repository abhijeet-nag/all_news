import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobServices {
  static String get bannerAdUnitId => Platform.isAndroid
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-3940256099942544/6300978111";

  static String get rewardAdUnitId => Platform.isAndroid
      ? "ca-app-pub-3940256099942544/5224354917"
      : "ca-app-pub-3940256099942544/5224354917";

  static initialize() {
    MobileAds.instance.initialize();
  }

  RewardedAd? _rewardedAd;

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
}
