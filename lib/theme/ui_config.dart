import 'package:flutter/material.dart';

class UIColors {
  static const Color scaffoldBackground = Color(0xFFF8FAFC);
  static const Color appBarBackground = Color(0xFFFFFFFF);
  static const Color appBarForeground = Color(0xFF111827);

  static const Color summaryBackground = Color(0xFFFFFFFF);
  static const Color summaryDivider = Color(0xFFE5E7EB);

  static const Color calendarCellBackground = Color(0xFFFFFFFF);
  static const Color calendarCellBorder = Color(0xFFE5E7EB);
  static const Color selectedCellBackground = Color(0xFFDBEAFE);
  static const Color selectedCellBorder = Color(0xFF2563EB);
  static const Color todayCellBackground = Color(0xFFE0F2FE);
  static const Color todayCellBorder = Color(0xFF0284C7);

  static const Color indicatorDot = Color(0xFF2563EB);
  static const Color indicatorBadgeBackground = Color(0xFF2563EB);
  static const Color indicatorBadgeText = Color(0xFFFFFFFF);

  static const Color movieCardBackground = Color(0xFFFFFFFF);
  static const Color moviePosterBackground = Color(0xFFF3F4F6);
  static const Color sidePanelBackground = Color(0xFFFFFFFF);

  static const Color rereleaseBadgeBackground = Color(0xFFFDE68A);
  static const Color rereleaseBadgeText = Color(0xFF92400E);

  static const Color titleText = Color(0xFF111827);
  static const Color bodyText = Color(0xFF374151);
  static const Color subText = Color(0xFF6B7280);
  static const Color todayText = Color(0xFFDC2626);

  static const Color divider = Color(0xFFE5E7EB);
  static const Color icon = Color(0xFF374151);

  static const Color primaryButtonBackground = Color(0xFF2563EB);
  static const Color primaryButtonForeground = Color(0xFFFFFFFF);
  static const Color loadingIndicator = Color(0xFF2563EB);
  static const Color errorIcon = Color(0xFFDC2626);
  static const Color errorText = Color(0xFF111827);
}

class UISpacing {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
}

class UISizes {
  static const double cardRadius = 16;
  static const double summaryRadius = 16;
  static const double calendarCellRadius = 16;
  static const double movieCardRadius = 16;
  static const double posterRadius = 10;
  static const double badgeRadius = 999;

  static const double selectedBorderWidth = 1.6;
  static const double normalBorderWidth = 1.0;
  static const double summaryDividerWidth = 1.0;

  static const double movieListHeight = 320;
  static const double compactMovieListRatio = 0.34;
  static const double compactScreenHeightThreshold = 700;

  static const double moviePosterWidth = 42;
  static const double moviePosterHeight = 56;
  static const double dialogPosterWidth = 96;
  static const double dialogPosterHeight = 136;

  static const double movieDotSize = 6;
  static const double movieDotRowHeight = 14;
  static const double movieDotSpacing = 2;

  static const double errorIconSize = 40;
  static const double loadingStrokeWidth = 3;
  static const double sidePanelWidthFactor = 0.5;
}

class UIText {
  static const double appBarTitle = 18;
  static const double monthTitle = 22;

  static const double summaryLabel = 14;
  static const double summaryValue = 18;

  static const double weekday = 14;
  static const double dayNumber = 13;
  static const double indicatorBadge = 9;

  static const double selectedDateTitle = 16;
  static const double movieTitle = 15;
  static const double movieMeta = 13;
  static const double movieDirector = 12;
  static const double dialogTitle = 18;
  static const double dialogBody = 14;
  static const double badge = 12;

  static const double emptyText = 14;
  static const double errorText = 14;
  static const double retryButton = 14;

  static const FontWeight appBarTitleWeight = FontWeight.w700;
  static const FontWeight monthTitleWeight = FontWeight.w700;
  static const FontWeight summaryLabelWeight = FontWeight.w500;
  static const FontWeight summaryValueWeight = FontWeight.w700;
  static const FontWeight weekdayWeight = FontWeight.w700;
  static const FontWeight dayNumberWeight = FontWeight.w700;
  static const FontWeight selectedDateTitleWeight = FontWeight.w700;
  static const FontWeight movieTitleWeight = FontWeight.w700;
  static const FontWeight badgeWeight = FontWeight.w700;
  static const FontWeight indicatorBadgeWeight = FontWeight.bold;
  static const FontWeight retryButtonWeight = FontWeight.w600;
}

class UILayout {
  static const double pageHorizontalPadding = 16;

  static const double monthHeaderLeft = 8;
  static const double monthHeaderTop = 8;
  static const double monthHeaderRight = 8;
  static const double monthHeaderBottom = 4;

  static const double weekdayHorizontalPadding = 12;
  static const double calendarHorizontalPadding = 12;
  static const double calendarTopPadding = 8;

  static const double calendarMainAxisSpacing = 8;
  static const double calendarCrossAxisSpacing = 8;

  static const double selectedListLeft = 16;
  static const double selectedListTop = 12;
  static const double selectedListRight = 16;
  static const double selectedListBottom = 16;
}

class UICalendar {
  static const double cellPaddingHorizontal = 4;
  static const double cellPaddingVertical = 5;
  static const double weekdayVerticalPadding = 5;
}

class UIMovieCard {
  static const double padding = 12;
  static const double gapBetweenPosterAndText = 12;
}

class UIBadge {
  static const double horizontalPadding = 8;
  static const double verticalPadding = 4;
}

class UIAdaptive {
  static const bool enableSwipeMonth = true;
}

class UIAnimation {
  static const Duration pageDuration = Duration(milliseconds: 280);
  static const Curve pageCurve = Curves.easeInOut;
}
