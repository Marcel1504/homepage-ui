import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_button_component.dart';
import 'package:homepage_ui/components/image/hp_round_image_component.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/profile/hp_content_profile_data.dart';
import 'package:homepage_ui/data/content/sociallinks/hp_content_social_link_data.dart';
import 'package:homepage_ui/data/media/hp_media_data.dart';
import 'package:homepage_ui/enums/hp_content_social_link_type.dart';
import 'package:homepage_ui/models/hp_content_model.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/providers/media/hp_media_provider.dart';
import 'package:homepage_ui/services/content/loader/hp_content_profile_loader_service.dart';
import 'package:homepage_ui/services/content/loader/hp_content_social_links_loader_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HpMainPage extends StatefulWidget {
  const HpMainPage({super.key});

  @override
  State<HpMainPage> createState() => _HpMainPageState();
}

class _HpMainPageState extends State<HpMainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HpContentProfileLoaderService().load(context);
      HpContentSocialLinksLoaderService().load(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return HpMainScaffoldComponent(
      child: Consumer<HpContentProvider>(
        builder: (context, provider, _) {
          HpContentModel<HpContentProfileData> profile = HpContentProfileLoaderService().get(context, provider);
          HpContentModel<List<HpContentSocialLinkData>> socialLinks = HpContentSocialLinksLoaderService().get(
            context,
            provider,
          );
          return profile.isLoading || socialLinks.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(HpLayout.pageDefaultSpacing),
                  child: _getContent(context, profile, socialLinks),
                );
        },
      ),
    );
  }

  Widget _getContent(
    BuildContext context,
    HpContentModel<HpContentProfileData> profile,
    HpContentModel<List<HpContentSocialLinkData>> socialLinks,
  ) {
    return HpLayout.isMobile(context)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getContentProfileImage(context, true, profile),
              _getContentInfobox(context, true, profile, socialLinks),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getContentProfileImage(context, false, profile),
              Flexible(child: _getContentInfobox(context, false, profile, socialLinks)),
            ],
          );
  }

  Widget _getContentProfileImage(BuildContext context, bool isMobile, HpContentModel<HpContentProfileData> profile) {
    return Consumer<HpMediaProvider>(
      builder: (context, provider, _) {
        HpMediaData? media = provider.mediaCache[profile.data?.profileMedia];
        Uint8List? mediaData = media?.data;
        return HpRoundImageComponent(
          size: isMobile ? HpLayout.imageProfileMobileSize : HpLayout.imageProfileDesktopSize,
          isLoading: media?.loading ?? true,
          data: mediaData,
        );
      },
    );
  }

  Widget _getContentInfobox(
    BuildContext context,
    bool isMobile,
    HpContentModel<HpContentProfileData> profile,
    HpContentModel<List<HpContentSocialLinkData>> socialLinks,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: isMobile ? 0 : HpLayout.pageDefaultSpacing * 2,
        top: isMobile ? HpLayout.pageDefaultSpacing * 2 : 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          _getContentInfoboxHeader(context, isMobile, profile),
          _getContentInfoboxSocialLinks(context, socialLinks),
        ],
      ),
    );
  }

  Widget _getContentInfoboxHeader(BuildContext context, bool isMobile, HpContentModel<HpContentProfileData> profile) {
    String headerTitle = "";
    String? firstName = profile.data?.firstName;
    String? lastName = profile.data?.lastName;
    if (firstName != null && lastName != null) {
      headerTitle = "$firstName $lastName".toUpperCase();
    }
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          headerTitle,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 35),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        Padding(
          padding: const EdgeInsets.only(top: HpLayout.pageDefaultSpacing * 0.5),
          child: Text(profile.data?.bio ?? "", textAlign: isMobile ? TextAlign.center : TextAlign.start),
        ),
      ],
    );
  }

  Widget _getContentInfoboxSocialLinks(
    BuildContext context,
    HpContentModel<List<HpContentSocialLinkData>> socialLinks,
  ) {
    List<HpContentSocialLinkData> list = socialLinks.data ?? [];
    return Padding(
      padding: const EdgeInsets.only(top: HpLayout.pageDefaultSpacing * 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: list
            .mapIndexed((i, e) => _getContentInfoboxSocialLinksButton(context, i == list.length - 1, e))
            .toList(),
      ),
    );
  }

  Widget _getContentInfoboxSocialLinksButton(BuildContext context, bool isLast, HpContentSocialLinkData socialLink) {
    String? link = socialLink.link;
    return link != null
        ? Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : HpLayout.pageDefaultSpacing),
            child: HpIconButtonComponent(
              icon: socialLink.type?.icon ?? Icons.open_in_new,
              onTap: () => launchUrl(Uri.parse(link)),
              height: HpLayout.buttonSocialLinkSize,
              width: HpLayout.buttonSocialLinkSize,
            ),
          )
        : Container();
  }
}
