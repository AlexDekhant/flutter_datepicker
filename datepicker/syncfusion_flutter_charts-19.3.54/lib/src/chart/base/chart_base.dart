import 'dart:ui';
import 'dart:ui' as dart_ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/src/common/user_interaction/tooltip_rendering_details.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_core/tooltip_internal.dart';

import '../../common/common.dart';
import '../../common/event_args.dart';
import '../../common/legend/legend.dart';
import '../../common/legend/renderer.dart';
import '../../common/rendering_details.dart';
import '../../common/series/chart_series.dart';
import '../../common/template/rendering.dart';
import '../../common/user_interaction/selection_behavior.dart';
import '../../common/user_interaction/tooltip.dart';
import '../../common/utils/enum.dart';
import '../../common/utils/helper.dart';
import '../../common/utils/typedef.dart';
import '../annotation/annotation_settings.dart';
import '../axis/axis.dart';
import '../axis/axis_panel.dart';
import '../axis/axis_renderer.dart';
import '../axis/numeric_axis.dart';
import '../axis/plotband.dart';
import '../base/series_base.dart';
import '../chart_segment/chart_segment.dart';
import '../chart_segment/column_segment.dart';
import '../chart_series/error_bar_series.dart';
import '../chart_series/series.dart';
import '../chart_series/series_renderer_properties.dart';
import '../chart_series/xy_data_series.dart';
import '../common/cartesian_state_properties.dart';
import '../common/common.dart';
import '../common/data_label_renderer.dart';
import '../common/marker.dart';
import '../common/renderer.dart';
import '../common/segment_properties.dart';
import '../series_painter/area_painter.dart';
import '../series_painter/bar_painter.dart';
import '../series_painter/box_and_whisker_painter.dart';
import '../series_painter/bubble_painter.dart';
import '../series_painter/candle_painter.dart';
import '../series_painter/column_painter.dart';
import '../series_painter/error_bar_painter.dart';
import '../series_painter/fastline_painter.dart';
import '../series_painter/hilo_painter.dart';
import '../series_painter/hiloopenclose_painter.dart';
import '../series_painter/histogram_painter.dart';
import '../series_painter/line_painter.dart';
import '../series_painter/range_area_painter.dart';
import '../series_painter/range_column_painter.dart';
import '../series_painter/scatter_painter.dart';
import '../series_painter/spline_area_painter.dart';
import '../series_painter/spline_painter.dart';
import '../series_painter/spline_range_area_painter.dart';
import '../series_painter/stacked_area_painter.dart';
import '../series_painter/stacked_bar_painter.dart';
import '../series_painter/stacked_column_painter.dart';
import '../series_painter/stacked_line_painter.dart';
import '../series_painter/step_area_painter.dart';
import '../series_painter/stepline_painter.dart';
import '../series_painter/waterfall_painter.dart';
import '../technical_indicators/technical_indicator.dart';
import '../trendlines/trendlines.dart';
import '../trendlines/trendlines_painter.dart';
import '../user_interaction/crosshair.dart';
import '../user_interaction/crosshair_painter.dart';
import '../user_interaction/selection_renderer.dart';
import '../user_interaction/trackball.dart';
import '../user_interaction/trackball_marker_setting_renderer.dart';
import '../user_interaction/trackball_painter.dart';
import '../user_interaction/trackball_template.dart';
import '../user_interaction/zooming_painter.dart';
import '../user_interaction/zooming_panning.dart';
import '../utils/enum.dart';
import '../utils/helper.dart';

///Renders the Cartesian type charts.
///
///Cartesian charts are generally charts with horizontal and vertical axes.[SfCartesianChart] provides options to customize
/// chart types using the `series` property.
///
///```dart
///Widget build(BuildContext context) {
///  return Center(
///    child:SfCartesianChart(
///      title: ChartTitle(text: 'Flutter Chart'),
///     legend: Legend(isVisible: true),
///     series: getDefaultData(),
///     tooltipBehavior: TooltipBehavior(enable: true),
///    )
/// );
///}
///static List<LineSeries<SalesData, num>> getDefaultData() {
///    final List<SalesData> chartData = <SalesData>[
///      SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
///      SalesData(DateTime(2006, 0, 1), 'China', 2.2, 24, 44, 550, 880),
///      SalesData(DateTime(2007, 0, 1), 'USA', 3.32, 36, 48, 440, 788),
///      SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 38, 50, 350, 560),
///      SalesData(DateTime(2009, 0, 1), 'Russia', 5.87, 54, 66, 444, 566),
///      SalesData(DateTime(2010, 0, 1), 'France', 6.8, 57, 78, 780, 650),
///     SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 70, 84, 450, 800)
///    ];
///   return <LineSeries<SalesData, num>>[
///      LineSeries<SalesData, num>(
///          enableToolTip: isTooltipVisible,
///          dataSource: chartData,
///          xValueMapper: (SalesData sales, _) => sales.numeric,
///          yValueMapper: (SalesData sales, _) => sales.sales1,
///          width: lineWidth ?? 2,
///          enableAnimation: false,
///         markerSettings: MarkerSettings(
///              isVisible: isMarkerVisible,
///              height: markerWidth ?? 4,
///              width: markerHeight ?? 4,
///              shape: DataMarkerType.Circle,
///              borderWidth: 3,
///              borderColor: Colors.red),
///          dataLabelSettings: DataLabelSettings(
///              visible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto)),
///      LineSeries<SalesData, num>(
///          enableToolTip: isTooltipVisible,
///          dataSource: chartData,
///          enableAnimation: false,
///          width: lineWidth ?? 2,
///          xValueMapper: (SalesData sales, _) => sales.numeric,
///          yValueMapper: (SalesData sales, _) => sales.sales2,
///          markerSettings: MarkerSettings(
///              isVisible: isMarkerVisible,
///              height: markerWidth ?? 4,
///              width: markerHeight ?? 4,
///              shape: DataMarkerType.Circle,
///              borderWidth: 3,
///              borderColor: Colors.black),
///          dataLabelSettings: DataLabelSettings(
///              isVisible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto))
///    ];
///  }
///  ```
///
// ignore: must_be_immutable
class SfCartesianChart extends StatefulWidget {
  /// Creating an argument constructor of SfCartesianChart class.
  SfCartesianChart(
      {Key? key,
      this.backgroundColor,
      this.enableSideBySideSeriesPlacement = true,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.plotAreaBackgroundColor,
      this.plotAreaBorderColor,
      this.plotAreaBorderWidth = 0.7,
      this.plotAreaBackgroundImage,
      this.onTooltipRender,
      this.onActualRangeChanged,
      //ignore: deprecated_member_use_from_same_package
      @deprecated this.onAxisLabelRender,
      this.onDataLabelRender,
      this.onLegendItemRender,
      this.onTrackballPositionChanging,
      this.onCrosshairPositionChanging,
      this.onZooming,
      this.onZoomStart,
      this.onZoomEnd,
      this.onZoomReset,
      @deprecated this.onPointTapped,
      this.onAxisLabelTapped,
      this.onDataLabelTapped,
      this.onLegendTapped,
      this.onSelectionChanged,
      this.onChartTouchInteractionUp,
      this.onChartTouchInteractionDown,
      this.onChartTouchInteractionMove,
      this.onMarkerRender,
      this.isTransposed = false,
      this.enableAxisAnimation = false,
      this.annotations,
      this.loadMoreIndicatorBuilder,
      this.onPlotAreaSwipe,
      this.palette = const <Color>[
        Color.fromRGBO(75, 135, 185, 1),
        Color.fromRGBO(192, 108, 132, 1),
        Color.fromRGBO(246, 114, 128, 1),
        Color.fromRGBO(248, 177, 149, 1),
        Color.fromRGBO(116, 180, 155, 1),
        Color.fromRGBO(0, 168, 181, 1),
        Color.fromRGBO(73, 76, 162, 1),
        Color.fromRGBO(255, 205, 96, 1),
        Color.fromRGBO(255, 240, 219, 1),
        Color.fromRGBO(238, 238, 238, 1)
      ],
      this.axisLabelFormatter,
      ChartAxis? primaryXAxis,
      ChartAxis? primaryYAxis,
      EdgeInsets? margin,
      TooltipBehavior? tooltipBehavior,
      ZoomPanBehavior? zoomPanBehavior,
      Legend? legend,
      SelectionType? selectionType,
      ActivationMode? selectionGesture,
      bool? enableMultiSelection,
      CrosshairBehavior? crosshairBehavior,
      TrackballBehavior? trackballBehavior,
      dynamic series,
      ChartTitle? title,
      List<ChartAxis>? axes,
      List<TechnicalIndicators<dynamic, dynamic>>? indicators})
      : primaryXAxis = primaryXAxis ?? NumericAxis(),
        primaryYAxis = primaryYAxis ?? NumericAxis(),
        title = title ?? ChartTitle(),
        axes = axes ?? <ChartAxis>[],
        series = series ?? <ChartSeries<dynamic, dynamic>>[],
        margin = margin ?? const EdgeInsets.all(10),
        zoomPanBehavior = zoomPanBehavior ?? ZoomPanBehavior(),
        tooltipBehavior = tooltipBehavior ?? TooltipBehavior(),
        crosshairBehavior = crosshairBehavior ?? CrosshairBehavior(),
        trackballBehavior = trackballBehavior ?? TrackballBehavior(),
        legend = legend ?? Legend(),
        selectionType = selectionType ?? SelectionType.point,
        selectionGesture = selectionGesture ?? ActivationMode.singleTap,
        enableMultiSelection = enableMultiSelection ?? false,
        indicators = indicators ?? <TechnicalIndicators<dynamic, dynamic>>[],
        super(key: key);

  ///Customizes the chart title
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Area with animation',
  ///                    alignment: ChartAlignment.center,
  ///                    backgroundColor: Colors.white,
  ///                    borderColor: Colors.transparent,
  ///                    borderWidth: 0)
  ///        ));
  ///}
  ///```
  final ChartTitle title;

  ///Customizes the legend in the chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(isVisible: true),
  ///        ));
  ///}
  ///```
  final Legend legend;

  ///Background color of the chart.
  ///
  ///Defaults to `Colors.transparent`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color? backgroundColor;

  ///Color of the chart border.
  ///
  ///Defaults to `Colors.transparent`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            borderColor: Colors.red
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Width of the chart border.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            borderColor: Colors.red,
  ///            borderWidth: 2
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Background color of the plot area.
  ///
  ///Defaults to `Colors.transparent`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBackgroundColor: Colors.red,
  ///        ));
  ///}
  ///```
  final Color? plotAreaBackgroundColor;

  ///Border color of the plot area.
  ///
  ///Defaults to `Colors.grey`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBorderColor: Colors.red,
  ///        ));
  ///}
  ///```
  final Color? plotAreaBorderColor;

  ///Border width of the plot area.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBorderColor: Colors.red,
  ///            plotAreaBorderWidth: 2
  ///        ));
  ///}
  ///```
  final double plotAreaBorderWidth;

  ///Customizes the primary x-axis in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: DateTimeAxis(interval: 1)
  ///        ));
  ///}
  ///```
  final ChartAxis primaryXAxis;

  ///Customizes the primary y-axis in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryYAxis: NumericAxis(isinversed: false)
  ///        ));
  ///}
  ///```
  final ChartAxis primaryYAxis;

  ///Margin for chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            margin: const EdgeInsets.all(2),
  ///            borderColor: Colors.blue
  ///        ));
  ///}
  ///```
  final EdgeInsets margin;

  ///Customizes the additional axes in the chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///             axes: <ChartAxis>[
  ///                NumericAxis(
  ///                             majorGridLines: MajorGridLines(
  ///                                     color: Colors.transparent)
  ///                             )]
  ///        ));
  ///}
  ///```
  final List<ChartAxis> axes;

  ///Enables or disables the placing of series side by side.
  ///
  ///Defaults to `true`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           enableSideBySideSeriesPlacement: false
  ///        ));
  ///}
  ///```
  final bool enableSideBySideSeriesPlacement;

  /// Occurs while tooltip is rendered. You can customize the position and header.
  /// Here, you can get the text, header, point index, series, x and y-positions.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///            onTooltipRender: (TooltipArgs args) => tool(args)
  ///        ));
  ///}
  ///void tool(TooltipArgs args) {
  ///   args.locationX = 30;
  ///}
  ///```
  final ChartTooltipCallback? onTooltipRender;

  /// Occurs when the visible range of an axis is changed, i.e. value changes for minimum,
  ///  maximum, and interval. Here, you can get the actual and visible range of an axis.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onActualRangeChanged: (ActualRangeChangedArgs args) => range(args)
  ///        ));
  ///}
  ///void range(ActualRangeChangedArgs args) {
  ///   print(args.visibleMin);
  ///}
  ///```
  final ChartActualRangeChangedCallback? onActualRangeChanged;

  /// Occurs while rendering the axis labels. Text and text styles such as color, font size,
  /// and font weight can be customized.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onAxisLabelRender: (AxisLabelRenderArgs args) => axis(args),
  ///        ));
  ///}
  ///void axis(AxisLabelRenderArgs args) {
  ///   args.text = 'axis Label';
  ///}
  ///```
  //ignore: deprecated_member_use_from_same_package
  final ChartAxisLabelRenderCallback? onAxisLabelRender;

  /// Occurs when tapping the axis label. Here, you can get the appropriate axis that is
  /// tapped and the axis label text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onDataLabelRender: (DataLabelRenderArgs args) => dataLabel(args),
  ///        ));
  ///}
  ///void dataLabel(DataLabelRenderArgs args) {
  ///   args.text = 'data Label';
  ///}
  ///```
  final ChartDataLabelRenderCallback? onDataLabelRender;

  /// Occurs when the legend item is rendered. Here, you can get the legend’s text,
  /// shape, series index, and point index of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(isVisible: true),
  ///            onLegendItemRender: (LegendRenderArgs args) => legend(args)
  ///        ));
  ///}
  ///void legend(LegendRenderArgs args) {
  ///   args.seriesIndex = 2;
  ///}
  ///```
  final ChartLegendRenderCallback? onLegendItemRender;

  /// Occurs while the trackball position is changed. Here, you can customize the text of
  /// the trackball.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            trackballBehavior: TrackballBehavior(enable: true),
  ///            onTrackballPositionChanging: (TrackballArgs args) => trackball(args)
  ///        ));
  ///}
  ///void trackball(TrackballArgs args) {
  ///    args.chartPointInfo = ChartPointInfo();
  ///}
  ///```
  final ChartTrackballCallback? onTrackballPositionChanging;

  /// Occurs when tapping the axis label. Here, you can get the appropriate axis that is
  /// tapped and the axis label text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            crosshairBehavior: CrosshairBehavior(enable: true),
  ///            onCrosshairPositionChanging: (CrosshairRenderArgs args) => crosshair(args)
  ///        ));
  ///}
  ///void crosshair(CrosshairRenderArgs args) {
  ///    args.text = 'crosshair';
  ///}
  ///```
  final ChartCrosshairCallback? onCrosshairPositionChanging;

  /// Occurs when zooming action begins. You can customize the zoom factor and zoom
  /// position of an axis. Here, you can get the axis, current zoom factor, current
  /// zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZoomStart: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///void zoom(ZoomPanArgs args) {
  ///    args.currentZoomFactor = 0.2;
  ///}
  ///```
  final ChartZoomingCallback? onZoomStart;

  /// Occurs when the zooming action is completed. Here, you can get the axis, current
  /// zoom factor, current zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZoomEnd: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///void zoom(ZoomPanArgs args) {
  ///    print(args.currentZoomPosition);
  ///}
  ///```
  final ChartZoomingCallback? onZoomEnd;

  /// Occurs when zoomed state is reset. Here, you can get the axis, current zoom factor,
  /// current zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZoomReset: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///void zoom(ZoomPanArgs args) {
  ///    print(args.currentZoomPosition);
  ///}
  ///```
  final ChartZoomingCallback? onZoomReset;

  /// Occurs when Zooming event is performed. Here, you can get the axis, current zoom factor,
  /// current zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZooming: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///void zoom(ZoomPanArgs args) {
  ///    print(args.currentZoomPosition);
  ///}
  ///```
  final ChartZoomingCallback? onZooming;

  /// Occurs when tapping the series point. Here, you can get the series, series index
  /// and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onPointTapped: (PointTapArgs args) => point(args),
  ///        ));
  ///}
  ///void point(PointTapArgs args) {
  ///   print(args.seriesIndex);
  ///}
  ///```
  @Deprecated('Use onPointTap in ChartSeries instead.')
  final ChartPointTapCallback? onPointTapped;

  ///Called when the data label is tapped.
  ///
  ///Whenever the data label is tapped, `onDataLabelTapped` callback will be called. Provides options to
  /// get the position of the data label, series index, point index and its text.
  ///
  ///_Note:_  This callback will not be called, when the builder is specified for data label
  /// (data label template). For this case, custom widget specified in the `DataLabelSettings.builder` property
  /// can be wrapped using the `GestureDetector` and this functionality can be achieved in the application level.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onDataLabelTapped: (DataLabelTapDetails args) {
  ///                 print(arg.seriesIndex);
  ///                  }
  ///        ));
  ///}
  ///
  ///```

  final DataLabelTapCallback? onDataLabelTapped;

  ///Occurs when tapping the axis label. Here, you can get the appropriate axis that is
  /// tapped and the axis label text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onAxisLabelTapped: (AxisLabelTapArgs args) => axis(args),
  ///        ));
  ///}
  ///void axis(AxisLabelTapArgs args) {
  ///   print(args.text);
  ///}
  ///```
  final ChartAxisLabelTapCallback? onAxisLabelTapped;

  /// Occurs when the legend item is rendered. Here, you can get the legend’s text,
  /// shape, series index, and point index of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onLegendTapped: (LegendTapArgs args) => legend(args),
  ///        ));
  ///}
  ///void legend(LegendTapArgs args) {
  ///   print(args.pointIndex);
  ///}
  ///```
  final ChartLegendTapCallback? onLegendTapped;

  /// Occurs while selection changes. Here, you can get the series, selected color,
  /// unselected color, selected border color, unselected border color, selected border
  ///  width, unselected border width, series index, and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onSelectionChanged: (SelectionArgs args) => print(args.selectedColor),
  ///        ));
  ///}
  final ChartSelectionCallback? onSelectionChanged;

  /// Occurs when tapped on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onChartTouchInteractionUp: (ChartTouchInteractionArgs args){
  ///               print(args.position.dx.toString());
  ///               print(args.position.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final ChartTouchInteractionCallback? onChartTouchInteractionUp;

  /// Occurs when touched on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onChartTouchInteractionDown: (ChartTouchInteractionArgs args){
  ///               print(args.position.dx.toString());
  ///               print(args.position.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final ChartTouchInteractionCallback? onChartTouchInteractionDown;

  /// Occurs when touched and moved on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onChartTouchInteractionMove: (ChartTouchInteractionArgs args){
  ///               print(args.position.dx.toString());
  ///               print(args.position.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final ChartTouchInteractionCallback? onChartTouchInteractionMove;

  /// Occurs when the marker is rendered. Here, you can get the marker pointIndex
  /// shape, height and width of data markers.
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///               onMarkerRender: (MarkerRenderArgs markerargs)
  ///            {
  ///              if(markerargs.pointIndex==2)
  ///              {
  ///              markerargs.markerHeight=20.0;
  ///              markerargs.markerWidth=20.0;
  ///              markerargs.shape=DataMarkerType.triangle;
  ///              }
  ///            },
  ///        ));
  ///}
  ///```
  ///
  final ChartMarkerRenderCallback? onMarkerRender;

  ///Customizes the tooltip in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///        ));
  ///}
  ///```
  final TooltipBehavior tooltipBehavior;

  ///Customizes the crosshair in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            crosshairBehavior: CrosshairBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final CrosshairBehavior crosshairBehavior;

  ///Customizes the trackball in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            trackballBehavior: TrackballBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final TrackballBehavior trackballBehavior;

  ///Customizes the zooming and panning settings.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior( enablePanning: true),
  ///        ));
  ///}
  ///```
  final ZoomPanBehavior zoomPanBehavior;

  ///Mode of selecting the data points or series.
  ///
  ///Defaults to `SelectionType.point`.
  ///
  ///Also refer [SelectionType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionType: SelectionType.series,
  ///        ));
  ///}
  ///```
  final SelectionType selectionType;

  ///Customizes the annotations. Annotations are used to mark the specific area of interest
  /// in the plot area with texts, shapes, or images.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///                 ),
  ///             ],
  ///        ));
  ///}
  ///```
  final List<CartesianChartAnnotation>? annotations;

  ///Enables or disables the multiple data points or series selection.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            enableMultiSelection: true,
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                  selectionBehavior: SelectionBehavior(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool enableMultiSelection;

  ///Gesture for activating the selection. Selection can be activated in tap,
  ///double tap, and long press.
  ///
  ///Defaults to `ActivationMode.tap`.
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                  selectionBehavior: SelectionBehavior(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ActivationMode selectionGesture;

  ///Background image for chart.
  ///
  ///Defaults to `null`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBackgroundImage: const AssetImage('images/bike.png'),
  ///        ));
  ///}
  ///```
  final ImageProvider? plotAreaBackgroundImage;

  ///Data points or series can be selected while performing interaction on the chart.
  ///It can also be selected at the initial rendering using this property.
  ///
  ///Defaults to `[]`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                 initialSelectedDataIndexes: <int>[2, 0],
  ///                  selectionBehavior: SelectionBehavior(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```

  ///By setting this, the orientation of x-axis is set to vertical and orientation of
  ///y-axis is set to horizontal.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            isTransposed: true,
  ///        ));
  ///}
  ///```
  final bool isTransposed;

  ///Axis elements animation on visible range change.
  ///
  ///Axis elements like grid lines, tick lines and labels will be animated when the axis range is changed dynamically.
  /// Axis visible range will be changed while zooming, panning or while updating the data points.
  ///
  ///The elements will be animated on setting `true` to this property and this is applicable for all primary and secondary axis in the chart.
  ///
  ///Defaults to `false`
  ///
  ///See also [ChartSeries.animationDuration] for changing the series animation duration.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            enableAxisAnimation: true,
  ///        ));
  ///}
  ///```
  final bool enableAxisAnimation;

  ///Customizes the series in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           series: <ChartSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                    dataSource: chartData,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final List<ChartSeries<dynamic, dynamic>> series;

  ///Color palette for chart series. If the series color is not specified, then the series
  ///will be rendered with appropriate palette color. Ten colors are available by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            palette: <Color>[Colors.red, Colors.green]
  ///        ));
  ///}
  ///```
  final List<Color> palette;

  ///Called while rendering each axis label in the chart.
  ///
  ///Provides label text, axis name, orientation of the axis, trimmed text and text styles such as color,
  /// font size, and font weight to the user using the `AxisLabelRenderDetails` class.
  ///
  ///You can customize the text and text style using the `ChartAxisLabel` class and can return it.
  final ChartLabelFormatterCallback? axisLabelFormatter;

  ///Technical indicators for charts.
  final List<TechnicalIndicators<dynamic, dynamic>> indicators;

  ///A builder that builds the widget (ex., loading indicator or load more button)
  ///to display at the top of the chart area when horizontal scrolling reaches
  ///the start or end of the chart.
  ///
  ///This can be used to achieve the features like load more and infinite
  ///scrolling in the chart. Also provides the swiping direction value to the user.
  ///
  ///If the chart is transposed, this will be called when the vertical scrolling
  ///reaches the top or bottom of the chart.
  ///
  ///## Infinite scrolling
  ///
  ///The below example demonstrates the infinite scrolling by showing
  ///the circular progress indicator until the data is loaded when horizontal
  ///scrolling reaches the end of the chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           loadMoreIndicatorBuilder:
  ///             (BuildContext context, ChartSwipeDirection direction) =>
  ///                 getLoadMoreViewBuilder(context, direction),
  ///           series: <ChartSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                    dataSource: chartData,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///Widget getLoadMoreViewBuilder(
  ///      BuildContext context, ChartSwipeDirection direction) {
  ///     if (direction == ChartSwipeDirection.end) {
  ///       return FutureBuilder<String>(
  ///         future: _updateData(), /// Adding data by updateDataSource method
  ///         builder:
  ///          (BuildContext futureContext, AsyncSnapshot<String> snapShot) {
  ///           return snapShot.connectionState != ConnectionState.done
  ///               ? const CircularProgressIndicator()
  ///               : SizedBox.fromSize(size: Size.zero);
  ///         },
  ///     );
  ///     } else {
  ///       return SizedBox.fromSize(size: Size.zero);
  ///     }
  /// }
  ///```
  ///
  ///## Load more
  ///
  ///The below example demonstrates how to show a button when horizontal
  ///scrolling reaches the end of the chart.
  ///On tapping the button circular indicator will be displayed and data will be
  ///loaded to the chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           loadMoreIndicatorBuilder:
  ///             (BuildContext context, ChartSwipeDirection direction) =>
  ///                 _buildLoadMoreView(context, direction),
  ///           series: <ChartSeries<SalesData, num>>[
  ///                LineSeries<SalesData, num>(
  ///                    dataSource: chartData,
  ///                ),
  ///              ],
  ///        ));
  ///}
  /// Widget _buildLoadMoreView(
  ///       BuildContext context, ChartSwipeDirection direction) {
  ///     _visible = true;
  /// if (direction == ChartSwipeDirection.end) {
  ///     return StatefulBuilder(
  ///         builder: (BuildContext context, StateSetter stateSetter) {
  ///       return Visibility(
  ///         visible: _visible,
  ///         child: RaisedButton(
  ///             child: const Text('Load More'),
  ///             onPressed: () async{
  ///               stateSetter(() {
  ///                   _visible = false;
  ///               });
  ///               await loadMore();
  ///             }),
  ///       );
  ///     });
  ///  } else {
  ///     return null;
  ///  }
  /// }
  ///FutureBuilder<String> loadMore() {
  ///       return FutureBuilder<String>(
  ///         future: _updateData(), /// Adding data by updateDataSource method
  ///         builder:
  ///          (BuildContext futureContext, AsyncSnapshot<String> snapShot) {
  ///           return snapShot.connectionState != ConnectionState.done
  ///               ? const CircularProgressIndicator()
  ///               : SizedBox.fromSize(size: Size.zero);
  ///         },
  ///     );
  /// }
  ///```
  final LoadMoreViewBuilderCallback? loadMoreIndicatorBuilder;

  ///Called while swiping on the plot area.
  ///
  ///Whenever the swiping happens on the plot area (the series rendering area), `onPlotAreaSwipe` callback
  /// will be called. It provides options to get the direction of swiping.
  ///
  ///If the chart is swiped from left to right direction, the direction is `ChartSwipeDirection.start` and
  /// if the swipe happens from right to left direction, the direction is `ChartSwipeDirection.end`.
  ///
  ///Using this callback, the user able to achieve pagination functionality (on swiping over chart area,
  /// next set of data points can be loaded to the chart).
  ///
  ///Also refer [ChartSwipeDirection].
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           onPlotAreaSwipe:
  ///             (ChartSwipeDirection direction) =>
  ///                 performSwipe(direction),
  ///           series: <ChartSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                    dataSource: chartData,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///Widget performSwipe(ChartSwipeDirection direction) {
  ///     if (direction == ChartSwipeDirection.end) {
  ///         chartData.add(ChartSampleData(
  ///             x: chartData[chartData.length - 1].x + 1,
  ///             y: 10));
  ///         seriesController.updateDataSource(addedDataIndex: chartData.length - 1);
  ///     }
  /// }
  ///```
  final ChartPlotAreaSwipeCallback? onPlotAreaSwipe;

  @override
  State<StatefulWidget> createState() => SfCartesianChartState();
}

/// Represents the state class of [SfCartesianChart] widget
///
class SfCartesianChartState extends State<SfCartesianChart>
    with TickerProviderStateMixin {
  late CartesianStateProperties _stateProperties;

  /// To initialize default values
  void _initializeDefaultValues() {
    _stateProperties = CartesianStateProperties(
        renderingDetails: RenderingDetails(), chartState: this);
    _stateProperties.chartAxis = ChartAxisPanel(_stateProperties);
    _stateProperties.chartSeries = ChartSeriesPanel(_stateProperties);
    _stateProperties.renderingDetails.chartLegend =
        ChartLegend(_stateProperties);
    _stateProperties.seriesRenderers = <CartesianSeriesRenderer>[];
    _stateProperties.controllerList = <AnimationController, VoidCallback>{};
    _stateProperties.repaintNotifiers = <String, ValueNotifier<int>>{
      'zoom': ValueNotifier<int>(0),
      'trendline': ValueNotifier<int>(0),
      'trackball': ValueNotifier<int>(0),
      'crosshair': ValueNotifier<int>(0),
      'indicator': ValueNotifier<int>(0),
    };
    _stateProperties.renderingDetails.legendWidgetContext =
        <MeasureWidgetContext>[];
    _stateProperties.renderingDetails.didSizeChange = false;
    _stateProperties.renderingDetails.templates = <ChartTemplateInfo>[];
    _stateProperties.oldAxisRenderers = <ChartAxisRenderer>[];
    _stateProperties.zoomedAxisRendererStates = <ChartAxisRenderer>[];
    _stateProperties.zoomAxes = <ZoomAxisRange>[];
    _stateProperties.renderingDetails.chartContainerRect =
        const Rect.fromLTRB(0, 0, 0, 0);
    _stateProperties.zoomProgress = false;
    _stateProperties.renderingDetails.legendToggleStates =
        <LegendRenderContext>[];
    _stateProperties.selectedSegments = <ChartSegment>[];
    _stateProperties.unselectedSegments = <ChartSegment>[];
    _stateProperties.renderingDetails.legendToggleTemplateStates =
        <MeasureWidgetContext>[];
    _stateProperties.renderDatalabelRegions = <Rect>[];
    _stateProperties.renderingDetails.dataLabelTemplateRegions = <Rect>[];
    _stateProperties.annotationRegions = <Rect>[];
    _stateProperties.renderingDetails.animateCompleted = false;
    _stateProperties.renderingDetails.widgetNeedUpdate = false;
    _stateProperties.oldSeriesRenderers = <CartesianSeriesRenderer>[];
    _stateProperties.oldSeriesKeys = <ValueKey<String>?>[];
    _stateProperties.renderingDetails.isLegendToggled = false;
    _stateProperties.oldSeriesVisible = <bool?>[];
    _stateProperties.touchStartPositions = <PointerEvent>[];
    _stateProperties.touchMovePositions = <PointerEvent>[];
    _stateProperties.enableDoubleTap = false;
    _stateProperties.legendToggling = false;
    _stateProperties.painterKeys = <PainterKey>[];
    _stateProperties.isNeedUpdate = true;
    _stateProperties.isRedrawByZoomPan = false;
    _stateProperties.isLoadMoreIndicator = false;
    _stateProperties.technicalIndicatorRenderer =
        <TechnicalIndicatorsRenderer>[];
    _stateProperties.zoomPanBehaviorRenderer =
        ZoomPanBehaviorRenderer(_stateProperties);
    _stateProperties.trackballBehaviorRenderer =
        TrackballBehaviorRenderer(_stateProperties);
    _stateProperties.crosshairBehaviorRenderer =
        CrosshairBehaviorRenderer(_stateProperties);
    _stateProperties.renderingDetails.tooltipBehaviorRenderer =
        TooltipBehaviorRenderer(_stateProperties);
    _stateProperties.renderingDetails.legendRenderer =
        LegendRenderer(widget.legend);
    _stateProperties.trackballMarkerSettingsRenderer =
        TrackballMarkerSettingsRenderer(
            widget.trackballBehavior.markerSettings);
    final TargetPlatform platform = defaultTargetPlatform;
    _stateProperties.enableMouseHover = kIsWeb ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux;
  }

  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each State object it creates.
  ///
  /// Override this method to perform initialization that depends on the location at
  /// which this object was inserted into the tree or on the widget used to configure this object.
  ///
  /// * In [initState], subscribe to the object.
  ///
  /// Here it overrides to initialize the object that depends on rendering the [SfCartesianChart].

  @override
  void initState() {
    _initializeDefaultValues();
    // Create the series renderer while initial rendering //
    _createAndUpdateSeriesRenderer();
    super.initState();
  }

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an [InheritedWidget] that later changed,
  /// the framework would call this method to notify this object about the change.
  ///
  /// This method is also called immediately after [initState]. It is safe to call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
  ///
  /// Here it called for initializing the chart theme of [SfCartesianChart].

  @override
  void didChangeDependencies() {
    _stateProperties.renderingDetails.chartTheme = SfChartTheme.of(context);
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and request that this location in the tree update to display a new widget with the same [runtimeType] and [Widget.key],
  /// the framework will update the widget property of this [State] object to refer to the new widget and then call this method with the previous widget as an argument.
  ///
  /// Override this method to respond when the widget changes.
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// * In [didUpdateWidget] unsubscribe from the old object and subscribe to the new one if the updated widget configuration requires replacing the object.
  ///
  /// Here it called whenever the series collection gets updated in [SfCartesianChart].

  @override
  void didUpdateWidget(SfCartesianChart oldWidget) {
    _stateProperties.isRedrawByZoomPan = false;
    _stateProperties.isLoadMoreIndicator = false;
    _stateProperties.zoomProgress = false;
    final List<CartesianSeriesRenderer> oldWidgetSeriesRenderers =
        //ignore: prefer_spread_collections
        <CartesianSeriesRenderer>[]..addAll(_stateProperties.seriesRenderers);
    final List<CartesianSeriesRenderer> oldWidgetOldSeriesRenderers =
        <CartesianSeriesRenderer>[]
          //ignore: prefer_spread_collections
          ..addAll(_stateProperties.oldSeriesRenderers);

    //Update and maintain the series state, when we update the series in the series collection //

    _createAndUpdateSeriesRenderer(
        oldWidget, oldWidgetSeriesRenderers, oldWidgetOldSeriesRenderers);
    needsRepaintChart(
        _stateProperties,
        _stateProperties.chartAxis.axisRenderersCollection,
        oldWidgetSeriesRenderers);
    _stateProperties.renderingDetails.isLegendToggled = false;
    // ignore: unnecessary_null_comparison
    if (_stateProperties.renderingDetails.legendWidgetContext != null &&
        _stateProperties.renderingDetails.legendWidgetContext.isNotEmpty) {
      _stateProperties.renderingDetails.legendWidgetContext.clear();
    }
    final SeriesRendererDetails? seriesRendererDetails =
        _stateProperties.seriesRenderers.isNotEmpty
            ? SeriesHelper.getSeriesRendererDetails(
                _stateProperties.seriesRenderers[0])
            : null;
    if (seriesRendererDetails?.selectionBehaviorRenderer != null) {
      final SelectionDetails? selectionDetails =
          SelectionHelper.getRenderingDetails(
              seriesRendererDetails!.selectionBehaviorRenderer!);
      if (_stateProperties.seriesRenderers.isNotEmpty &&
          selectionDetails?.selectionRenderer != null) {
        selectionDetails?.selectionRenderer?.isInteraction = false;
      }
    }
    if (_stateProperties.isNeedUpdate) {
      _stateProperties.renderingDetails.widgetNeedUpdate = true;
      _stateProperties.oldSeriesRenderers = oldWidgetSeriesRenderers;
      _getOldSeriesKeys(_stateProperties.oldSeriesRenderers);
      _stateProperties.oldAxisRenderers = <ChartAxisRenderer>[]
        //ignore: prefer_spread_collections
        ..addAll(_stateProperties.chartAxis.axisRenderersCollection);
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method in a number of different situations. For example:
  ///
  /// * After calling [initState].
  /// * After calling [didUpdateWidget].
  /// * After receiving a call to [setState].
  /// * After a dependency of this [State] object changes.
  ///
  /// Here it is called whenever the user interaction is performed and it removes the old widget and updates a chart with a new widget in [SfCartesianChart].

  @override
  Widget build(BuildContext context) {
    _stateProperties.renderingDetails.oldDeviceOrientation =
        _stateProperties.renderingDetails.oldDeviceOrientation == null
            ? MediaQuery.of(context).orientation
            : _stateProperties.renderingDetails.deviceOrientation;
    _stateProperties.renderingDetails.deviceOrientation =
        MediaQuery.of(context).orientation;
    _stateProperties.renderingDetails.initialRender =
        _stateProperties.renderingDetails.initialRender == null;
    _stateProperties.requireInvertedAxis = false;
    _stateProperties.triggerLoaded = false;
    _stateProperties.isSeriesLoaded = _stateProperties.isSeriesLoaded ?? true;
    _findVisibleSeries(context);
    _stateProperties.isSeriesLoaded = false;

    return RepaintBoundary(
        child: ChartContainer(
            child: Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ??
              _stateProperties.renderingDetails.chartTheme.backgroundColor,
          border:
              Border.all(color: widget.borderColor, width: widget.borderWidth)),
      child: Container(
          margin: EdgeInsets.fromLTRB(widget.margin.left, widget.margin.top,
              widget.margin.right, widget.margin.bottom),
          child: Column(
            children: <Widget>[_renderTitle(), _renderChartElements(context)],
          )),
    )));
  }

  /// Called when this object is removed from the tree permanently.
  ///
  /// The framework calls this method when this [State] object will never build again. After the framework calls [dispose],
  /// the [State] object is considered unmounted and the [mounted] property is false. It is an error to call [setState] at this
  /// point. This stage of the life cycle is terminal: there is no way to remount a [State] object that has been disposed.
  ///
  /// Sub classes should override this method to release any resources retained by this object.
  ///
  /// * In [dispose], unsubscribe from the object.
  ///
  /// Here it end the animation controller of the series in [SfCartesianChart].

  @override
  void dispose() {
    _stateProperties.controllerList.forEach(disposeAnimationController);
    super.dispose();
  }

  /// Method to convert the [SfCartesianChart] as an image.
  ///
  /// As this method is in the widget’s state class,
  /// you have to use a global key to access the state to call this method.
  /// Returns the `dart:ui.image`
  ///
  /// ```dart
  /// final GlobalKey<SfCartesianChartState> _key = GlobalKey();
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Column(
  ///      children: [SfCartesianChart(
  ///        key: _key
  ///          series: <ChartSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                    dataSource: chartData,
  ///                ),
  ///              ],
  ///        ),
  ///              RaisedButton(
  ///                child: Text(
  ///                  'To Image',
  ///                ),
  ///               onPressed: _renderImage,
  ///                shape: RoundedRectangleBorder(
  ///                    borderRadius: BorderRadius.circular(20)),
  ///              )
  ///      ],
  ///    ),
  ///  );
  /// }

  /// Future<void> _renderImage() async {
  ///  dart_ui.Image data = await _key.currentState.toImage(pixelRatio: 3.0);
  ///  final bytes = await data.toByteData(format: dart_ui.ImageByteFormat.png);
  ///  if (data != null) {
  ///    await Navigator.of(context).push(
  ///      MaterialPageRoute(
  ///        builder: (BuildContext context) {
  ///          return Scaffold(
  ///            appBar: AppBar(),
  ///            body: Center(
  ///              child: Container(
  ///                color: Colors.white,
  ///                child: Image.memory(bytes.buffer.asUint8List()),
  ///            ),
  ///            ),
  ///         );
  ///        },
  ///      ),
  ///    );
  ///  }
  ///}
  ///```

  Future<dart_ui.Image> toImage({double pixelRatio = 1.0}) async {
    final RenderRepaintBoundary boundary = context.findRenderObject()
        as RenderRepaintBoundary; //get the render object from context

    final dart_ui.Image image =
        await boundary.toImage(pixelRatio: pixelRatio); // Convert
    // the repaint boundary as image

    return image;
  }

  ///Storing old series key values
  void _getOldSeriesKeys(List<CartesianSeriesRenderer> oldSeriesRenderers) {
    _stateProperties.oldSeriesKeys = <ValueKey<String>?>[];
    for (int i = 0; i < oldSeriesRenderers.length; i++) {
      _stateProperties.oldSeriesKeys.add(
          SeriesHelper.getSeriesRendererDetails(oldSeriesRenderers[i])
              .series
              .key);
    }
  }

  /// In this method, create and update the series renderer for each series //
  void _createAndUpdateSeriesRenderer(
      [SfCartesianChart? oldWidget,
      List<CartesianSeriesRenderer>? oldWidgetSeriesRenderers,
      List<CartesianSeriesRenderer>? oldWidgetOldSeriesRenderers]) {
    // ignore: unnecessary_null_comparison
    if (widget.series != null && widget.series.isNotEmpty) {
      if (oldWidget != null) {
        _stateProperties.oldSeriesRenderers = <CartesianSeriesRenderer>[];
        _stateProperties.oldSeriesRenderers.addAll(oldWidgetSeriesRenderers!);
      }
      _stateProperties.seriesRenderers = <CartesianSeriesRenderer>[];
      final int seriesLength = widget.series.length;
      dynamic series;
      int? index, oldSeriesIndex;
      for (int i = 0; i < seriesLength; i++) {
        series = widget.series[i];
        index = null;
        oldSeriesIndex = null;
        if (oldWidget != null) {
          if (oldWidgetOldSeriesRenderers!.isNotEmpty) {
            // Check the current series is already exist in old widget //
            index = i < oldWidgetOldSeriesRenderers.length &&
                    isSameSeries(
                        SeriesHelper.getSeriesRendererDetails(
                                oldWidgetOldSeriesRenderers[i])
                            .series,
                        series)
                ? i
                : _getExistingSeriesIndex(series, oldWidgetOldSeriesRenderers);
          }
          if (oldWidgetSeriesRenderers!.isNotEmpty) {
            oldSeriesIndex = i < oldWidgetSeriesRenderers.length &&
                    isSameSeries(
                        SeriesHelper.getSeriesRendererDetails(
                                oldWidgetSeriesRenderers[i])
                            .series,
                        series)
                ? i
                : _getExistingSeriesIndex(series, oldWidgetSeriesRenderers);
          }
        }
        // Create and update the series list here
        CartesianSeriesRenderer seriesRenderer;

        if (index != null &&
            index < oldWidgetOldSeriesRenderers!.length &&
            // ignore: unnecessary_null_comparison
            oldWidgetOldSeriesRenderers[index] != null) {
          seriesRenderer = oldWidgetOldSeriesRenderers[index];
        } else {
          seriesRenderer = series.createRenderer(series);
          SeriesHelper.setSeriesRendererDetails(
              seriesRenderer, SeriesRendererDetails(seriesRenderer));
          final SeriesRendererDetails seriesRendererDetails =
              SeriesHelper.getSeriesRendererDetails(seriesRenderer);
          seriesRendererDetails.seriesIndex = i;
          seriesRendererDetails.seriesType = getSeriesType(seriesRenderer);
          seriesRendererDetails.stateProperties = _stateProperties;
          seriesRendererDetails.repaintNotifier = ValueNotifier<int>(0);
          if (seriesRenderer is XyDataSeriesRenderer) {
            seriesRendererDetails.animationController =
                AnimationController(vsync: this)
                  ..addListener(seriesRendererDetails.repaintSeriesElement);
            _stateProperties
                    .controllerList[seriesRendererDetails.animationController] =
                seriesRendererDetails.repaintSeriesElement;
            seriesRendererDetails.animationController.addStatusListener(
                seriesRendererDetails.animationStatusListener);
          }
          seriesRendererDetails.controller = (oldWidgetSeriesRenderers !=
                      null &&
                  oldSeriesIndex != null &&
                  oldWidgetSeriesRenderers.length > oldSeriesIndex)
              ? (SeriesHelper.getSeriesRendererDetails(
                          oldWidgetSeriesRenderers[oldSeriesIndex])
                      .controller ??
                  seriesRendererDetails.controller ??
                  ChartSeriesController(seriesRenderer as XyDataSeriesRenderer))
              : (seriesRendererDetails.controller ??
                  ChartSeriesController(
                      seriesRenderer as XyDataSeriesRenderer));
        }
        final SeriesRendererDetails seriesRendererDetails =
            SeriesHelper.getSeriesRendererDetails(seriesRenderer);
        if (series.onRendererCreated != null) {
          series.onRendererCreated(seriesRendererDetails.controller);
        }
        seriesRendererDetails.series = series;
        seriesRendererDetails.isSelectionEnable =
            series.selectionBehavior.enable == true;
        seriesRendererDetails.visible = null;
        seriesRendererDetails.chart = widget;
        seriesRendererDetails.hasDataLabelTemplate = false;

        if (oldWidgetSeriesRenderers != null &&
            oldSeriesIndex != null &&
            oldWidgetSeriesRenderers.length > oldSeriesIndex) {
          final SeriesRendererDetails oldSeriesRendererDetails =
              SeriesHelper.getSeriesRendererDetails(
                  oldWidgetSeriesRenderers[oldSeriesIndex]);
          seriesRendererDetails.oldSeries = oldSeriesRendererDetails.series;
          if (seriesRenderer is FastLineSeriesRenderer &&
              oldWidgetSeriesRenderers[oldSeriesIndex]
                  is FastLineSeriesRenderer) {
            final FastLineSeriesRenderer fastlineSeriesRenderer =
                oldWidgetSeriesRenderers[oldSeriesIndex]
                    as FastLineSeriesRenderer;
            seriesRendererDetails
                .oldDataPoints = <CartesianChartPoint<dynamic>>[]
              //ignore: prefer_spread_collections
              ..addAll(
                  SeriesHelper.getSeriesRendererDetails(fastlineSeriesRenderer)
                      .overallDataPoints);
          } else {
            seriesRendererDetails.oldDataPoints =
                <CartesianChartPoint<dynamic>>[]
                  //ignore: prefer_spread_collections
                  ..addAll(oldSeriesRendererDetails.dataPoints);
          }
          seriesRendererDetails.oldSelectedIndexes =
              oldSeriesRendererDetails.oldSelectedIndexes;
          seriesRendererDetails.repaintNotifier =
              oldSeriesRendererDetails.repaintNotifier;
          seriesRendererDetails.animationController =
              oldSeriesRendererDetails.animationController;
        } else {
          seriesRendererDetails.oldSeries = null;
          seriesRendererDetails.oldDataPoints =
              <CartesianChartPoint<dynamic>>[];
        }

        _stateProperties.seriesRenderers.add(seriesRenderer);
        _stateProperties.chartSeries.visibleSeriesRenderers.add(seriesRenderer);
      }
    } else {
      _stateProperties.seriesRenderers.clear();
      _stateProperties.chartSeries.visibleSeriesRenderers.clear();
    }
  }

  /// Check current series index is exist in another index
  int? _getExistingSeriesIndex(CartesianSeries<dynamic, dynamic> currentSeries,
      List<CartesianSeriesRenderer> oldSeriesRenderers) {
    if (currentSeries.key != null) {
      for (int index = 0; index < oldSeriesRenderers.length; index++) {
        final CartesianSeries<dynamic, dynamic> series =
            SeriesHelper.getSeriesRendererDetails(oldSeriesRenderers[index])
                .series;
        if (isSameSeries(series, currentSeries)) {
          return index;
        }
      }
    }
    return null;
  }

  /// Refresh method for axis
  void _refresh() {
    if (_stateProperties.renderingDetails.legendWidgetContext.isNotEmpty) {
      for (int i = 0;
          i < _stateProperties.renderingDetails.legendWidgetContext.length;
          i++) {
        final MeasureWidgetContext templateContext =
            _stateProperties.renderingDetails.legendWidgetContext[i];
        final RenderBox renderBox =
            templateContext.context!.findRenderObject() as RenderBox;
        templateContext.size = renderBox.size;
      }
      _stateProperties.legendRefresh = true;
      setState(() {
        /// The chart will be rebuilding again, Once legend template sizes will be calculated.
      });
    }
  }

  Widget _renderTitle() {
    Widget titleWidget;
    // ignore: unnecessary_null_comparison
    if (_stateProperties.chart.title.text != null &&
        _stateProperties.chart.title.text.isNotEmpty) {
      final Paint titleBackground = Paint()
        ..color = _stateProperties.chart.title.borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _stateProperties.chart.title.borderWidth;
      final TextStyle titleStyle = getTextStyle(
          textStyle: _stateProperties.chart.title.textStyle,
          background: titleBackground,
          fontColor: _stateProperties.chart.title.textStyle.color ??
              _stateProperties.renderingDetails.chartTheme.titleTextColor);
      final TextStyle textStyle = TextStyle(
          color: titleStyle.color,
          fontSize: titleStyle.fontSize,
          fontFamily: titleStyle.fontFamily,
          fontStyle: titleStyle.fontStyle,
          fontWeight: titleStyle.fontWeight);
      titleWidget = Container(
        child: Container(
          child: Text(_stateProperties.chart.title.text,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
              style: textStyle),
          decoration: BoxDecoration(
              color: _stateProperties.chart.title.backgroundColor ??
                  _stateProperties
                      .renderingDetails.chartTheme.titleBackgroundColor,
              border: Border.all(
                  color: _stateProperties.chart.title.borderWidth == 0
                      ? Colors.transparent
                      : _stateProperties.chart.title
                          .borderColor, // ?? _chartTheme.titleTextColor,
                  width: _stateProperties.chart.title.borderWidth)),
        ),
        alignment:
            (_stateProperties.chart.title.alignment == ChartAlignment.near)
                ? Alignment.topLeft
                : (_stateProperties.chart.title.alignment == ChartAlignment.far)
                    ? Alignment.topRight
                    : (_stateProperties.chart.title.alignment ==
                            ChartAlignment.center)
                        ? Alignment.topCenter
                        : Alignment.topCenter,
      );
    } else {
      titleWidget = Container();
    }
    return titleWidget;
  }

  /// To arrange the chart area and legend area based on the legend position
  Widget _renderChartElements(BuildContext context) {
    if (widget.plotAreaBackgroundImage != null || widget.legend.image != null) {
      calculateImage(_stateProperties);
    }
    _stateProperties.renderingDetails.deviceOrientation =
        MediaQuery.of(context).orientation;
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        Widget? element;
        _stateProperties.renderingDetails.prevSize =
            _stateProperties.renderingDetails.prevSize ?? constraints.biggest;
        _stateProperties.renderingDetails.didSizeChange =
            _stateProperties.renderingDetails.prevSize != constraints.biggest;
        _stateProperties.renderingDetails.prevSize = constraints.biggest;
        _stateProperties.isTooltipOrientationChanged = false;
        final CartesianChartPoint<dynamic> _crosshairPoint =
            _getCrosshairChartPoint(_stateProperties);
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _validateStateMaintenance(_stateProperties, _crosshairPoint);
        });
        final List<Widget> legendTemplates =
            _bindCartesianLegendTemplateWidgets();
        if (legendTemplates.isNotEmpty &&
            _stateProperties.renderingDetails.legendWidgetContext.isEmpty) {
          element = Container(child: Stack(children: legendTemplates));
          SchedulerBinding.instance?.addPostFrameCallback((_) => _refresh());
        } else {
          _initialize(constraints);
          _stateProperties.renderingDetails.chartLegend.calculateLegendBounds(
              _stateProperties.renderingDetails.chartLegend.chartSize);
          _stateProperties.containerArea = ContainerArea(_stateProperties);
          element = getElements(
              _stateProperties, _stateProperties.containerArea, constraints);
        }
        return element!;
      }),
    );
  }

  /// To return the template widget
  List<Widget> _bindCartesianLegendTemplateWidgets() {
    Widget? legendWidget;
    final List<Widget> templates = <Widget>[];
    if (widget.legend.isVisible! && widget.legend.legendItemBuilder != null) {
      for (int i = 0; i < _stateProperties.seriesRenderers.length; i++) {
        final CartesianSeriesRenderer seriesRenderer =
            _stateProperties.seriesRenderers[i];
        final SeriesRendererDetails seriesRendererDetails =
            SeriesHelper.getSeriesRendererDetails(seriesRenderer);
        if (seriesRendererDetails.series.isVisibleInLegend == true) {
          legendWidget = widget.legend.legendItemBuilder!(
              seriesRendererDetails.seriesName!,
              seriesRendererDetails.series,
              null,
              i);
          templates.add(MeasureWidgetSize(
              stateProperties: _stateProperties,
              seriesIndex: i,
              pointIndex: null,
              type: 'Legend',
              currentKey: GlobalKey(),
              currentWidget: legendWidget,
              opacityValue: 0.0));
        }
      }
    }
    return templates;
  }

  /// To initialize chart legend
  void _initialize(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double height = constraints.maxHeight;
    final bool isMobilePlatform =
        defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS;
    _stateProperties.renderingDetails.legendRenderer.legendPosition =
        (widget.legend.position == LegendPosition.auto)
            ? (height > width
                ? isMobilePlatform
                    ? LegendPosition.top
                    : LegendPosition.bottom
                : LegendPosition.right)
            : widget.legend.position;
    final LegendPosition position =
        _stateProperties.renderingDetails.legendRenderer.legendPosition;
    final double widthPadding =
        position == LegendPosition.left || position == LegendPosition.right
            ? 5
            : 0;
    final double heightPadding =
        position == LegendPosition.top || position == LegendPosition.bottom
            ? 5
            : 0;
    _stateProperties.renderingDetails.chartLegend.chartSize =
        Size(width - widthPadding, height - heightPadding);
  }

  /// To find the visible series
  void _findVisibleSeries(BuildContext context) {
    final List<CartesianSeriesRenderer> _seriesRenderers =
        _stateProperties.seriesRenderers;
    bool legendCheck = false;
    _stateProperties.chartSeries.visibleSeriesRenderers =
        <CartesianSeriesRenderer>[];
    final List<CartesianSeriesRenderer> visibleSeriesRenderers =
        _stateProperties.chartSeries.visibleSeriesRenderers;
    for (int i = 0; i < _seriesRenderers.length; i++) {
      final SeriesRendererDetails seriesRendererDetails =
          SeriesHelper.getSeriesRendererDetails(_seriesRenderers[i]);
      seriesRendererDetails.seriesName =
          seriesRendererDetails.series.name ?? 'Series $i';
      final CartesianSeries<dynamic, dynamic> cartesianSeries =
          seriesRendererDetails.series;
      seriesRendererDetails.markerSettingsRenderer =
          MarkerSettingsRenderer(seriesRendererDetails.series.markerSettings);
      Trendline trendline;
      TrendlineRenderer trendlineRenderer;
      if (cartesianSeries.trendlines != null) {
        seriesRendererDetails.trendlineRenderer = <TrendlineRenderer>[];
        final List<int> trendlineTypes = <int>[0, 0, 0, 0, 0, 0];
        for (final Trendline trendline in cartesianSeries.trendlines!) {
          trendlineRenderer = TrendlineRenderer(trendline);
          seriesRendererDetails.trendlineRenderer.add(trendlineRenderer);
          trendlineRenderer.name ??=
              (trendline.type == TrendlineType.movingAverage
                      ? 'Moving average'
                      : trendline.type.toString().substring(14)) +
                  (' ' + (trendlineTypes[trendline.type.index]++).toString());
        }
        for (final TrendlineRenderer trendlineRenderer
            in seriesRendererDetails.trendlineRenderer) {
          trendline = trendlineRenderer.trendline;
          trendlineRenderer.name = trendlineRenderer.name![0].toUpperCase() +
              trendlineRenderer.name!.substring(1);
          if (trendlineTypes[trendline.type.index] == 1 &&
              trendlineRenderer.name![trendlineRenderer.name!.length - 1] ==
                  '0') {
            trendlineRenderer.name = trendlineRenderer.name!
                .substring(0, trendlineRenderer.name!.length - 2);
          }
        }
      }
      if (_stateProperties.renderingDetails.initialRender! ||
          (_stateProperties.renderingDetails.widgetNeedUpdate &&
              !_stateProperties.legendToggling &&
              (_stateProperties.renderingDetails.oldDeviceOrientation ==
                  MediaQuery.of(context).orientation))) {
        if (seriesRendererDetails.oldSeries != null &&
            (seriesRendererDetails.oldSeries!.isVisible ==
                seriesRendererDetails.series.isVisible)) {
          legendCheck = true;
        } else {
          if (_stateProperties.renderingDetails.legendToggleStates.isNotEmpty) {
            _stateProperties.renderingDetails.legendToggleStates.clear();
          }

          seriesRendererDetails.visible =
              _stateProperties.renderingDetails.initialRender!
                  ? seriesRendererDetails.series.isVisible
                  : seriesRendererDetails.visible ??
                      seriesRendererDetails.series.isVisible;
        }
      } else {
        legendCheck = true;
      }

      final SeriesRendererDetails seriesDetails =
          SeriesHelper.getSeriesRendererDetails(_seriesRenderers[0]);
      final bool isFirstBarSeries =
          seriesDetails.series.toString().contains('Bar') &&
              !seriesDetails.series.toString().contains('ErrorBar');
      final bool isMultipleBarSeries =
          seriesRendererDetails.series.toString().contains('Bar') &&
              !seriesRendererDetails.series.toString().contains('ErrorBar');
      if (i == 0 ||
          (!isFirstBarSeries && !isMultipleBarSeries) ||
          (isFirstBarSeries && isMultipleBarSeries)) {
        visibleSeriesRenderers.add(_seriesRenderers[i]);
        if (!_stateProperties.renderingDetails.initialRender! &&
            _stateProperties.oldSeriesVisible.isNotEmpty &&
            i < visibleSeriesRenderers.length) {
          if (i < visibleSeriesRenderers.length &&
              i < _stateProperties.oldSeriesVisible.length) {
            _stateProperties.oldSeriesVisible[i] =
                SeriesHelper.getSeriesRendererDetails(visibleSeriesRenderers[i])
                    .visible;
          }
        }
        if (legendCheck) {
          final int index = visibleSeriesRenderers.length - 1;
          final SeriesRendererDetails visibleSeriesDetails =
              SeriesHelper.getSeriesRendererDetails(
                  visibleSeriesRenderers[index]);
          final String? legendItemText =
              visibleSeriesDetails.series.legendItemText;
          final String? legendText =
              _stateProperties.chart.legend.legendItemBuilder != null
                  ? visibleSeriesDetails.seriesName
                  : visibleSeriesDetails.series.isVisibleInLegend == true &&
                          _stateProperties.renderingDetails.chartLegend
                                  .legendCollections !=
                              null &&
                          _stateProperties.renderingDetails.chartLegend
                              .legendCollections!.isNotEmpty
                      ? _getLegendItemCollection(index)!.text
                      : null;

          final String? seriesName = visibleSeriesDetails.series.name;
          final SeriesRendererDetails seriesDetails =
              SeriesHelper.getSeriesRendererDetails(_stateProperties.chartSeries
                  .visibleSeriesRenderers[visibleSeriesRenderers.length - 1]);
          seriesDetails.visible = _checkWithLegendToggleState(
              visibleSeriesRenderers.length - 1,
              SeriesHelper.getSeriesRendererDetails(
                      visibleSeriesRenderers[visibleSeriesRenderers.length - 1])
                  .series,
              legendText ?? legendItemText ?? seriesName ?? 'Series $index');
        }
        final CartesianSeriesRenderer? cSeriesRenderer = _stateProperties
                    .chartSeries
                    .visibleSeriesRenderers[visibleSeriesRenderers.length - 1]
                is CartesianSeriesRenderer
            ? _stateProperties.chartSeries
                .visibleSeriesRenderers[visibleSeriesRenderers.length - 1]
            : null;
        final SeriesRendererDetails cSeriesDetails =
            SeriesHelper.getSeriesRendererDetails(cSeriesRenderer!);
        if (cSeriesDetails.series != null &&
            cSeriesDetails.series.trendlines != null) {
          Trendline? trendline;
          TrendlineRenderer trendlineRenderer;
          for (int j = 0; j < cSeriesDetails.series.trendlines!.length; j++) {
            trendline = cSeriesDetails.series.trendlines![j];
            trendlineRenderer = cSeriesDetails.trendlineRenderer[j];
            trendlineRenderer.visible = _checkWithTrendlineLegendToggleState(
                    visibleSeriesRenderers.length - 1,
                    cSeriesDetails.series,
                    j,
                    trendline,
                    trendlineRenderer.name!) &&
                cSeriesDetails.visible! == true;
          }
          _stateProperties.isTrendlineToggled = false;
        }
      }
      legendCheck = false;
    }
    _stateProperties.chartSeries.visibleSeriesRenderers =
        visibleSeriesRenderers;

    /// setting indicators visibility
    if (_stateProperties.chart.indicators.isNotEmpty) {
      TechnicalIndicatorsRenderer technicalIndicatorRenderer;
      _stateProperties.technicalIndicatorRenderer.clear();
      for (int i = 0; i < _stateProperties.chart.indicators.length; i++) {
        technicalIndicatorRenderer = TechnicalIndicatorsRenderer(
            _stateProperties.chart.indicators[i], _stateProperties);
        _stateProperties.technicalIndicatorRenderer
            .add(technicalIndicatorRenderer);
        technicalIndicatorRenderer.visible =
            _stateProperties.renderingDetails.initialRender!
                ? _stateProperties.chart.indicators[i].isVisible
                : _checkIndicatorLegendToggleState(
                    visibleSeriesRenderers.length + i,
                    technicalIndicatorRenderer.visible ??
                        _stateProperties.chart.indicators[i].isVisible);
      }
    }
    _stateProperties.seriesRenderers = _seriesRenderers;
  }

  /// This will return crosshair chart points
  CartesianChartPoint<dynamic> _getCrosshairChartPoint(
      CartesianStateProperties stateProperties) {
    CartesianChartPoint<dynamic> crosshairChartPoint =
        CartesianChartPoint<dynamic>(null, null);
    final CrosshairBehaviorRenderer crosshairBehaviorRenderer =
        stateProperties.crosshairBehaviorRenderer;
    final CrosshairRenderingDetails crosshairRenderingDetails =
        CrosshairHelper.getRenderingDetails(crosshairBehaviorRenderer);
    if (stateProperties.renderingDetails.oldDeviceOrientation !=
            stateProperties.renderingDetails.deviceOrientation ||
        stateProperties.renderingDetails.didSizeChange) {
      if (crosshairRenderingDetails.position != null &&
          stateProperties.chart.crosshairBehavior.enable) {
        crosshairChartPoint = calculatePixelToPoint(
            crosshairRenderingDetails.position!,
            stateProperties.seriesRenderers.first);
      }
    }
    return crosshairChartPoint;
  }

  /// Here for orientation change/browser resize, the logic in this method will get executed
  void _validateStateMaintenance(CartesianStateProperties stateProperties,
      CartesianChartPoint<dynamic> point) {
    final TrackballBehaviorRenderer trackballBehaviorRenderer =
        stateProperties.trackballBehaviorRenderer;
    final TrackballRenderingDetails trackballRenderingDetails =
        TrackballHelper.getRenderingDetails(trackballBehaviorRenderer);
    final TooltipBehaviorRenderer tooltipBehaviorRenderer =
        stateProperties.renderingDetails.tooltipBehaviorRenderer;
    final TooltipRenderingDetails tooltipRenderingDetails =
        TooltipHelper.getRenderingDetails(tooltipBehaviorRenderer);
    final CrosshairBehaviorRenderer crosshairBehaviorRenderer =
        stateProperties.crosshairBehaviorRenderer;
    final CrosshairRenderingDetails crosshairRenderingDetails =
        CrosshairHelper.getRenderingDetails(crosshairBehaviorRenderer);
    late Offset crosshairOffset;
    if (stateProperties.renderingDetails.oldDeviceOrientation !=
            stateProperties.renderingDetails.deviceOrientation ||
        stateProperties.renderingDetails.didSizeChange) {
      if (trackballRenderingDetails.chartPointInfo.isNotEmpty &&
          stateProperties.chart.trackballBehavior.enable) {
        stateProperties.isTrackballOrientationChanged = true;
        trackballRenderingDetails.internalShowByIndex(
            trackballRenderingDetails.chartPointInfo[0].dataPointIndex!);
      }
      if (crosshairRenderingDetails.position != null &&
          stateProperties.chart.crosshairBehavior.enable) {
        stateProperties.isCrosshairOrientationChanged = true;
        crosshairOffset =
            calculatePointToPixel(point, stateProperties.seriesRenderers.first);
        crosshairRenderingDetails.internalShow(
            crosshairOffset.dx, crosshairOffset.dy, 'pixel');
      }
      if (tooltipRenderingDetails.showLocation != null &&
          stateProperties.chart.tooltipBehavior.enable &&
          !stateProperties.isTooltipHidden &&
          !stateProperties.requireAxisTooltip &&
          tooltipRenderingDetails.currentSeriesDetails.seriesIndex != null &&
          tooltipRenderingDetails.pointIndex != null) {
        stateProperties.isTooltipOrientationChanged = true;
        tooltipRenderingDetails.internalShowByIndex(
            tooltipRenderingDetails.currentSeriesDetails.seriesIndex,
            tooltipRenderingDetails.pointIndex!);
      }
    }
  }

  /// This method returns the legend render context of a particular series
  /// since there is no necessity that the series index will match with the legend index
  /// especially when the previous series is made invisible in legend
  LegendRenderContext? _getLegendItemCollection(int index) {
    for (final LegendRenderContext legendContext
        in _stateProperties.renderingDetails.chartLegend.legendCollections!) {
      if (legendContext.seriesIndex == index) {
        return legendContext;
      }
    }
    return null;
  }

  /// To check the legend toggle state
  bool _checkIndicatorLegendToggleState(int seriesIndex, bool seriesVisible) {
    bool? seriesRender;
    if (widget.legend.legendItemBuilder != null) {
      final List<MeasureWidgetContext> legendToggles =
          _stateProperties.renderingDetails.legendToggleTemplateStates;
      if (legendToggles.isNotEmpty) {
        for (int j = 0; j < legendToggles.length; j++) {
          final MeasureWidgetContext item = legendToggles[j];
          if (seriesIndex == item.seriesIndex) {
            seriesRender = false;
            break;
          }
        }
      }
    } else {
      if (_stateProperties.renderingDetails.legendToggleStates.isNotEmpty) {
        for (int j = 0;
            j < _stateProperties.renderingDetails.legendToggleStates.length;
            j++) {
          final LegendRenderContext legendRenderContext =
              _stateProperties.renderingDetails.legendToggleStates[j];
          if (seriesIndex == legendRenderContext.seriesIndex) {
            seriesRender = false;
            break;
          }
        }
      }
    }
    return seriesRender ?? true;
  }

  /// Check whether trendline enable with legend toggled state
  bool _checkWithTrendlineLegendToggleState(
      int seriesIndex,
      CartesianSeries<dynamic, dynamic> series,
      int trendlineIndex,
      Trendline trendline,
      String text) {
    bool? seriesRender;
    if (_stateProperties.renderingDetails.legendToggleStates.isNotEmpty) {
      for (int j = 0;
          j < _stateProperties.renderingDetails.legendToggleStates.length;
          j++) {
        final LegendRenderContext legendRenderContext =
            _stateProperties.renderingDetails.legendToggleStates[j];
        if ((legendRenderContext.text == text &&
                legendRenderContext.seriesIndex == seriesIndex &&
                legendRenderContext.trendlineIndex == trendlineIndex) ||
            _stateProperties.isTrendlineToggled) {
          seriesRender = false;
          break;
        }
      }
    }
    return seriesRender ?? true;
  }

  /// To toggle series visibility based on legend toggle states
  bool _checkWithLegendToggleState(
      int seriesIndex, ChartSeries<dynamic, dynamic> series, String text) {
    bool? seriesRender;
    if (_stateProperties.chart.legend.legendItemBuilder != null) {
      final List<MeasureWidgetContext> legendToggles =
          _stateProperties.renderingDetails.legendToggleTemplateStates;
      if (legendToggles.isNotEmpty) {
        for (int j = 0; j < legendToggles.length; j++) {
          final MeasureWidgetContext item = legendToggles[j];
          if (seriesIndex == item.seriesIndex) {
            seriesRender = false;
            break;
          }
        }
      }
    } else {
      if (_stateProperties.renderingDetails.legendToggleStates.isNotEmpty) {
        for (int j = 0;
            j < _stateProperties.renderingDetails.legendToggleStates.length;
            j++) {
          final LegendRenderContext legendRenderContext =
              _stateProperties.renderingDetails.legendToggleStates[j];
          if (seriesIndex == legendRenderContext.seriesIndex &&
              legendRenderContext.text == text) {
            if (series is CartesianSeries) {
              final CartesianSeries<dynamic, dynamic> cSeries = series;
              if (cSeries.trendlines != null) {
                _stateProperties.isTrendlineToggled = true;
              }
            }
            seriesRender = false;
            break;
          }
        }
      }
    }
    return seriesRender ?? true;
  }
}

/// Represents the container area
// ignore: must_be_immutable
class ContainerArea extends StatelessWidget {
  /// Creates an instance for container area
  // ignore: prefer_const_constructors_in_immutables
  ContainerArea(this._stateProperties);
  final CartesianStateProperties _stateProperties;

  /// Gets the chart from state properties
  SfCartesianChart get chart => _stateProperties.chart;
  RenderingDetails get _renderingDetails => _stateProperties.renderingDetails;

  /// Specifies the render box
  late RenderBox renderBox;
  Offset? _touchPosition;
  Offset? _tapDownDetails;
  Offset? _mousePointerDetails;
  late CartesianSeries<dynamic, dynamic> _series;
  late XyDataSeriesRenderer _seriesRenderer;
  Offset? _zoomStartPosition;
  bool get _enableMouseHover => _stateProperties.enableMouseHover;

  /// Get trackball rendering Details
  TrackballRenderingDetails get trackballRenderingDetails =>
      TrackballHelper.getRenderingDetails(
          _stateProperties.trackballBehaviorRenderer);

  @override
  Widget build(BuildContext context) {
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);

    //this boolean prohibits both x and y scrolls for the parent widget
    final bool isXYPanMode = (chart.crosshairBehavior.enable &&
            chart.crosshairBehavior.activationMode ==
                ActivationMode.singleTap) ||
        ((chart.zoomPanBehavior.enablePinching ||
                chart.zoomPanBehavior.enablePanning) &&
            chart.zoomPanBehavior.zoomMode == ZoomMode.xy);

    final bool requireInvertedAxis = _stateProperties.seriesRenderers.isNotEmpty
        ? (chart.isTransposed ^
            getSeriesType(_stateProperties.seriesRenderers[0])
                .toLowerCase()
                .contains('bar'))
        : chart.isTransposed;

    //this boolean prohibits x scrolls for the parent widget
    final bool isXPan = (chart.trackballBehavior.enable &&
            !requireInvertedAxis &&
            chart.trackballBehavior.activationMode ==
                ActivationMode.singleTap) ||
        chart.onPlotAreaSwipe != null ||
        (!requireInvertedAxis && chart.loadMoreIndicatorBuilder != null) ||
        (chart.zoomPanBehavior.enablePanning &&
            chart.zoomPanBehavior.zoomMode == ZoomMode.x);

    //this boolean prohibits y scrolls for the parent widget
    final bool isYPan = (chart.trackballBehavior.enable &&
            requireInvertedAxis &&
            chart.trackballBehavior.activationMode ==
                ActivationMode.singleTap) ||
        (requireInvertedAxis && chart.loadMoreIndicatorBuilder != null) ||
        (chart.zoomPanBehavior.enablePanning &&
            chart.zoomPanBehavior.zoomMode == ZoomMode.y);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          decoration: const BoxDecoration(color: Colors.transparent),

          /// To get the mouse region of the chart
          child: MouseRegion(
              // Using the _enableMouseHover property, prevented mouse hover function in mobile platforms. The mouse hover event should not be triggered for mobile platforms and logged an issue regarding this to the Flutter team.
              // Issue:  https://github.com/flutter/flutter/issues/68690
              onHover: (PointerEvent event) =>
                  _enableMouseHover ? _performMouseHover(event) : null,
              onExit: (PointerEvent event) => _performMouseExit(event),
              child: Listener(
                  onPointerDown: (PointerDownEvent event) {
                    _stateProperties.pointerDeviceKind = event.kind;
                    _performPointerDown(event);
                    ChartTouchInteractionArgs touchArgs;
                    if (chart.onChartTouchInteractionDown != null) {
                      touchArgs = ChartTouchInteractionArgs();
                      touchArgs.position =
                          renderBox.globalToLocal(event.position);
                      chart.onChartTouchInteractionDown!(touchArgs);
                    }
                  },
                  onPointerMove: (PointerMoveEvent event) {
                    _performPointerMove(event);
                    ChartTouchInteractionArgs touchArgs;
                    if (chart.onChartTouchInteractionMove != null) {
                      touchArgs = ChartTouchInteractionArgs();
                      touchArgs.position =
                          renderBox.globalToLocal(event.position);
                      chart.onChartTouchInteractionMove!(touchArgs);
                    }
                  },
                  onPointerUp: (PointerUpEvent event) {
                    _stateProperties.isTouchUp = true;
                    _performPointerUp(event);
                    _stateProperties.isTouchUp = false;
                    ChartTouchInteractionArgs touchArgs;
                    if (chart.onChartTouchInteractionUp != null) {
                      touchArgs = ChartTouchInteractionArgs();
                      touchArgs.position =
                          renderBox.globalToLocal(event.position);
                      chart.onChartTouchInteractionUp!(touchArgs);
                    }
                  },
                  onPointerSignal: (PointerSignalEvent event) {
                    if (event is PointerScrollEvent) {
                      _performPointerSignal(event);
                    }
                  },
                  child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        final Offset position =
                            renderBox.globalToLocal(details.globalPosition);
                        _touchPosition = position;
                      },
                      onTap: () {
                        if (_stateProperties
                                    .chartSeries.visibleSeriesRenderers !=
                                null &&
                            _stateProperties.chartSeries.visibleSeriesRenderers
                                .isNotEmpty &&
                            _touchPosition != null &&
                            chart.selectionGesture ==
                                ActivationMode.singleTap &&
                            zoomingBehaviorDetails.isPinching != true) {
                          final Offset position = _touchPosition!;
                          final CartesianSeriesRenderer
                              selectionseriesRenderer = _findSeries(position)!;
                          final SeriesRendererDetails selectionSeriesDetails =
                              SeriesHelper.getSeriesRendererDetails(
                                  selectionseriesRenderer);
                          final SelectionBehaviorRenderer?
                              selectionBehaviorRenderer =
                              selectionSeriesDetails.selectionBehaviorRenderer;
                          final SelectionDetails? selectionDetails =
                              SelectionHelper.getRenderingDetails(
                                  selectionBehaviorRenderer!);
                          if (selectionSeriesDetails.isSelectionEnable ==
                                  true &&
                              selectionDetails?.selectionRenderer != null &&
                              selectionSeriesDetails.isOuterRegion == false) {
                            selectionDetails
                                    ?.selectionRenderer?.seriesRendererDetails =
                                selectionSeriesDetails;
                            selectionBehaviorRenderer.onTouchDown(
                                position.dx, position.dy);
                          }
                        }
                      },
                      onTapUp: (TapUpDetails details) {
                        final Offset position =
                            renderBox.globalToLocal(details.globalPosition);
                        final List<CartesianSeriesRenderer>
                            visibleSeriesRenderer =
                            _stateProperties.chartSeries.visibleSeriesRenderers;
                        if (chart.onPointTapped != null) {
                          calculatePointSeriesIndex(
                              chart, _stateProperties, position);
                        }
                        final CartesianSeriesRenderer? cartesianSeriesRenderer =
                            _findSeries(position);
                        if (cartesianSeriesRenderer != null &&
                            SeriesHelper.getSeriesRendererDetails(
                                        cartesianSeriesRenderer)
                                    .series
                                    .onPointTap !=
                                null) {
                          calculatePointSeriesIndex(chart, _stateProperties,
                              position, null, ActivationMode.singleTap);
                        }
                        if (chart.onAxisLabelTapped != null) {
                          _triggerAxisLabelEvent(position);
                        }
                        if (chart.onDataLabelTapped != null) {
                          triggerDataLabelEvent(
                              chart, visibleSeriesRenderer, position);
                        }
                      },
                      onDoubleTap: () {
                        _performDoubleTap();
                      },
                      onLongPressMoveUpdate:
                          (LongPressMoveUpdateDetails details) {
                        _performLongPressMoveUpdate(details);
                      },
                      onLongPress: () {
                        _performLongPress();
                      },
                      onLongPressEnd: (LongPressEndDetails details) {
                        _performLongPressEnd();
                      },
                      onPanDown: (DragDownDetails details) {
                        _performPanDown(details);
                      },
                      onVerticalDragUpdate: isXYPanMode || isYPan
                          ? (DragUpdateDetails details) {
                              _performPanUpdate(details);
                            }
                          : null,
                      onVerticalDragEnd: isXYPanMode || isYPan
                          ? (DragEndDetails details) {
                              _performPanEnd(details);
                            }
                          : null,
                      onHorizontalDragUpdate: isXYPanMode || isXPan
                          ? (DragUpdateDetails details) {
                              _performPanUpdate(details);
                            }
                          : null,
                      onHorizontalDragEnd: isXYPanMode || isXPan
                          ? (DragEndDetails details) {
                              _performPanEnd(details);
                            }
                          : null,
                      child: Container(
                          child: _initializeChart(constraints, context),
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          decoration: const BoxDecoration(
                              color: Colors.transparent))))));
    });
  }

  /// To initialize chart
  Widget _initializeChart(BoxConstraints constraints, BuildContext context) {
    // chart._stateProperties.tooltipBehaviorRenderer = TooltipBehaviorRenderer(chart.tooltipBehavior);

    _calculateContainerSize(constraints);
    _calculateBounds();
    return Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: _renderWidgets(constraints, context));
  }

  /// To get the size of a container
  void _calculateContainerSize(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double height = constraints.maxHeight;
    _stateProperties.renderingDetails.chartContainerRect =
        Rect.fromLTWH(0, 0, width, height);
  }

  /// Calculate container bounds
  void _calculateBounds() {
    _stateProperties.chartSeries.processData();
    _stateProperties.chartAxis.measureAxesBounds();
    _stateProperties.rangeChangeBySlider = false;
    _stateProperties.rangeChangedByChart = false;
  }

  /// To calculate the trendline region
  void _calculateTrendlineRegion(CartesianStateProperties _stateProperties,
      XyDataSeriesRenderer seriesRenderer) {
    final SeriesRendererDetails seriesRendererDetails =
        SeriesHelper.getSeriesRendererDetails(seriesRenderer);
    if (seriesRendererDetails.series.trendlines != null) {
      TrendlineRenderer trendlineRenderer;
      for (int i = 0;
          i < seriesRendererDetails.series.trendlines!.length;
          i++) {
        trendlineRenderer = seriesRendererDetails.trendlineRenderer[i];
        if (trendlineRenderer.isNeedRender) {
          trendlineRenderer.calculateTrendlinePoints(
              seriesRendererDetails, _stateProperties);
        }
      }
    }
  }

  /// To render chart widgets
  Widget _renderWidgets(BoxConstraints constraints, BuildContext context) {
    _stateProperties.renderingDetails.chartWidgets = <Widget>[];
    _stateProperties.renderDatalabelRegions = <Rect>[];
    _bindAxisWidgets('outside');
    _bindPlotBandWidgets(true);
    _bindSeriesWidgets();
    _bindPlotBandWidgets(false);
    _bindDataLabelWidgets();
    _bindTrendlineWidget();
    _bindAxisWidgets('inside');
    _renderTemplates();
    _bindInteractionWidgets(constraints, context);
    _bindLoadMoreIndicatorWidget();
    renderBox = context.findRenderObject()! as RenderBox;
    _stateProperties.containerArea = this;
    _stateProperties.legendRefresh = false;
    return Container(
        child: Stack(
            textDirection: TextDirection.ltr,
            children: _stateProperties.renderingDetails.chartWidgets!));
  }

  void _bindLoadMoreIndicatorWidget() {
    _stateProperties.renderingDetails.chartWidgets!.add(StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      Widget renderWidget;
      _stateProperties.loadMoreViewStateSetter = stateSetter;
      renderWidget = _stateProperties.isLoadMoreIndicator
          ? Center(
              child: _stateProperties.chart.loadMoreIndicatorBuilder!(
                  context, _stateProperties.swipeDirection))
          : renderWidget = Container();
      return renderWidget;
    }));
  }

  void _bindPlotBandWidgets(bool shouldRenderAboveSeries) {
    _stateProperties.renderingDetails.chartWidgets!.add(RepaintBoundary(
        child: CustomPaint(
            painter: getPlotBandPainter(
                stateProperties: _stateProperties,
                shouldRenderAboveSeries: shouldRenderAboveSeries))));
  }

  void _bindTrendlineWidget() {
    bool isTrendline = false;
    final Map<String, Animation<double>> trendlineAnimations =
        <String, Animation<double>>{};
    for (int i = 0;
        i < _stateProperties.chartSeries.visibleSeriesRenderers.length;
        i++) {
      _seriesRenderer = _stateProperties.chartSeries.visibleSeriesRenderers[i]
          as XyDataSeriesRenderer;
      final SeriesRendererDetails seriesRendererDetails =
          SeriesHelper.getSeriesRendererDetails(_seriesRenderer);
      _series = seriesRendererDetails.series;
      // ignore: unnecessary_null_comparison
      if (_seriesRenderer != null &&
          seriesRendererDetails.visible! == true &&
          _series.trendlines != null) {
        isTrendline = true;
        for (int j = 0;
            j < seriesRendererDetails.trendlineRenderer.length;
            j++) {
          final TrendlineRenderer trendlineRenderer =
              seriesRendererDetails.trendlineRenderer[j];
          final Trendline trendline = _series.trendlines![j];
          if (trendline.animationDuration > 0 &&
              (_renderingDetails.oldDeviceOrientation == null ||
                  _stateProperties.renderingDetails.oldDeviceOrientation ==
                      _stateProperties.renderingDetails.deviceOrientation) &&
              seriesRendererDetails.needsAnimation == true &&
              seriesRendererDetails.oldSeries == null) {
            final int totalAnimationDuration =
                trendline.animationDuration.toInt() +
                    trendline.animationDelay!.toInt();
            trendlineRenderer.animationController.duration =
                Duration(milliseconds: totalAnimationDuration);
            const double maxSeriesInterval = 0.8;
            double minSeriesInterval = 0.1;
            minSeriesInterval = trendline.animationDelay!.toInt() /
                    totalAnimationDuration *
                    (maxSeriesInterval - minSeriesInterval) +
                minSeriesInterval;
            trendlineAnimations['$i-$j'] =
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: trendlineRenderer.animationController,
              curve: Interval(minSeriesInterval, maxSeriesInterval,
                  curve: Curves.decelerate),
            ));
            trendlineRenderer.animationController.forward(from: 0.0);
          }
        }
      }
    }
    if (isTrendline) {
      _stateProperties.renderingDetails.chartWidgets!.add(RepaintBoundary(
        child: CustomPaint(
            painter: TrendlinePainter(
                stateProperties: _stateProperties,
                trendlineAnimations: trendlineAnimations,
                notifier: _stateProperties.repaintNotifiers['trendline']!)),
      ));
    }
  }

  /// To bind the widget for data label
  void _bindDataLabelWidgets() {
    _stateProperties.renderDataLabel = DataLabelRenderer(
        stateProperties: _stateProperties,
        show: _stateProperties.renderingDetails.animateCompleted);
    _stateProperties.renderingDetails.chartWidgets!
        .add(_stateProperties.renderDataLabel!);
  }

  /// To render a template
  void _renderTemplates() {
    _stateProperties.annotationRegions = <Rect>[];
    _stateProperties.renderingDetails.templates = <ChartTemplateInfo>[];
    _renderDataLabelTemplates();
    if (chart.annotations != null && chart.annotations!.isNotEmpty) {
      for (int i = 0; i < chart.annotations!.length; i++) {
        final CartesianChartAnnotation annotation = chart.annotations![i];
        final ChartLocation location =
            getAnnotationLocation(annotation, _stateProperties);
        final ChartTemplateInfo chartTemplateInfo = ChartTemplateInfo(
            key: GlobalKey(),
            animationDuration: 200,
            widget: annotation.widget!,
            templateType: 'Annotation',
            needMeasure: true,
            pointIndex: i,
            verticalAlignment: annotation.verticalAlignment,
            horizontalAlignment: annotation.horizontalAlignment,
            clipRect: annotation.region == AnnotationRegion.chart
                ? _stateProperties.renderingDetails.chartContainerRect
                : _stateProperties.chartAxis.axisClipRect,
            location: Offset(location.x.toDouble(), location.y.toDouble()));
        _stateProperties.renderingDetails.templates.add(chartTemplateInfo);
      }
    }

    if (_renderingDetails.templates.isNotEmpty) {
      final int templateLength =
          _stateProperties.renderingDetails.templates.length;
      for (int i = 0;
          i < _stateProperties.renderingDetails.templates.length;
          i++) {
        final ChartTemplateInfo templateInfo =
            _stateProperties.renderingDetails.templates[i];
        _stateProperties.renderingDetails.chartWidgets!.add(RenderTemplate(
            template: templateInfo,
            templateIndex: i,
            templateLength: templateLength,
            stateProperties: _stateProperties));
      }
    }
  }

  /// To render data label template
  void _renderDataLabelTemplates() {
    Widget? labelWidget;
    CartesianChartPoint<dynamic> point;
    _stateProperties.renderingDetails.dataLabelTemplateRegions = <Rect>[];
    for (int i = 0;
        i < _stateProperties.chartSeries.visibleSeriesRenderers.length;
        i++) {
      final CartesianSeriesRenderer seriesRenderer =
          _stateProperties.chartSeries.visibleSeriesRenderers[i];
      final SeriesRendererDetails seriesRendererDetails =
          SeriesHelper.getSeriesRendererDetails(seriesRenderer);
      final XyDataSeries<dynamic, dynamic> series =
          seriesRendererDetails.series as XyDataSeries<dynamic, dynamic>;
      num padding;
      if (series.dataLabelSettings.isVisible &&
          seriesRendererDetails.visible! == true) {
        for (int j = 0; j < seriesRendererDetails.dataPoints.length; j++) {
          point = seriesRendererDetails.dataPoints[j];
          if (point.isVisible && !point.isGap) {
            labelWidget = (series.dataLabelSettings.builder != null)
                ? series.dataLabelSettings.builder!(
                    series.dataSource[point.overallDataPointIndex!],
                    point,
                    series,
                    point.overallDataPointIndex!,
                    i)
                : null;
            if (labelWidget != null) {
              final String seriesType = seriesRendererDetails.seriesType;
              final List<num> dataLabelTemplateYValues =
                  (seriesType.contains('range') ||
                          (seriesType.contains('hilo') &&
                              !seriesType.contains('hiloopenclose')))
                      ? <num>[point.low as num, point.high as num]
                      : (seriesType.contains('candle') ||
                              seriesType.contains('hiloopenclose'))
                          ? <num>[
                              point.low as num,
                              point.high as num,
                              point.open as num,
                              point.close as num
                            ]
                          : seriesType.contains('box')
                              ? <num>[point.minimum!]
                              : <num>[point.y as num];

              for (int k = 0; k < dataLabelTemplateYValues.length; k++) {
                padding = (k == 0 &&
                        dataLabelTemplateYValues.length > 1 &&
                        !_stateProperties.requireInvertedAxis)
                    ? 20
                    : 0;
                final ChartLocation location = calculatePoint(
                    point.xValue,
                    dataLabelTemplateYValues[k],
                    seriesRendererDetails.xAxisDetails!,
                    seriesRendererDetails.yAxisDetails!,
                    _stateProperties.requireInvertedAxis,
                    series,
                    _stateProperties.chartAxis.axisClipRect);

                final ChartTemplateInfo templateInfo = ChartTemplateInfo(
                    key: GlobalKey(),
                    templateType: 'DataLabel',
                    pointIndex: j,
                    seriesIndex: i,
                    needMeasure: true,
                    clipRect: _stateProperties.chartAxis.axisClipRect,
                    animationDuration:
                        (series.animationDuration + 1000.0).floor(),
                    widget: labelWidget,
                    location: Offset(location.x, location.y + padding));
                _stateProperties.renderingDetails.templates.add(templateInfo);
              }
            }
          }
        }
      }
    }
  }

  /// To bind a series of widgets for all series
  void _bindSeriesWidgets() {
    _stateProperties.painterKeys = <PainterKey>[];
    _stateProperties.animationCompleteCount = 0;
    _stateProperties.renderingDetails.animateCompleted = false;
    for (int i = 0;
        i < _stateProperties.chartSeries.visibleSeriesRenderers.length;
        i++) {
      _seriesRenderer = _stateProperties.chartSeries.visibleSeriesRenderers[i]
          as XyDataSeriesRenderer;
      final SeriesRendererDetails seriesRendererDetails =
          SeriesHelper.getSeriesRendererDetails(_seriesRenderer);
      seriesRendererDetails.animationCompleted = false;
      _series = seriesRendererDetails.series;
      final String _seriesType = seriesRendererDetails.seriesType;
      if (seriesRendererDetails.isIndicator == true) {
        seriesRendererDetails.repaintNotifier = ValueNotifier<int>(0);
        if (_seriesRenderer is XyDataSeriesRenderer) {
          seriesRendererDetails.animationController =
              AnimationController(vsync: _stateProperties.chartState)
                ..addListener(seriesRendererDetails.repaintSeriesElement);
          _stateProperties
                  .controllerList[seriesRendererDetails.animationController] =
              seriesRendererDetails.repaintSeriesElement;
          seriesRendererDetails.animationController
              .addStatusListener(seriesRendererDetails.animationStatusListener);
        }
      }
      // ignore: unnecessary_null_comparison
      if (_seriesRenderer != null && seriesRendererDetails.visible! == true) {
        _calculateTrendlineRegion(_stateProperties, _seriesRenderer);
        seriesRendererDetails.selectionBehavior = _series.selectionBehavior;
        final dynamic selectionBehavior =
            seriesRendererDetails.selectionBehavior;
        seriesRendererDetails.selectionBehaviorRenderer =
            SelectionBehaviorRenderer(
                selectionBehavior, chart, _stateProperties);
        final SelectionBehaviorRenderer? selectionBehaviorRenderer =
            seriesRendererDetails.selectionBehaviorRenderer;
        SelectionHelper.setSelectionBehaviorRenderer(
            _series.selectionBehavior, selectionBehaviorRenderer!);
        if (selectionBehaviorRenderer != null) {
          final SelectionDetails selectionDetails =
              SelectionHelper.getRenderingDetails(selectionBehaviorRenderer);
          selectionDetails.selectionRenderer ??= SelectionRenderer();
          selectionDetails.selectionRenderer!.chart = chart;
          selectionDetails.selectionRenderer!.stateProperties =
              _stateProperties;
          selectionDetails.selectionRenderer!.seriesRendererDetails =
              seriesRendererDetails;
          _series = seriesRendererDetails.series;
          if (selectionBehavior.selectionController != null) {
            selectionDetails.selectRange();
          }
          selectionDetails.selectionRenderer!.selectedSegments =
              _stateProperties.selectedSegments;
          selectionDetails.selectionRenderer!.unselectedSegments =
              _stateProperties.unselectedSegments;
          //To determine whether initialSelectedDataIndexes collection is updated dynamically
          bool isSelecetedIndexesUpdated = false;
          if (_series.initialSelectedDataIndexes != null &&
              _series.initialSelectedDataIndexes!.isNotEmpty &&
              seriesRendererDetails.oldSelectedIndexes != null &&
              seriesRendererDetails.oldSelectedIndexes!.isNotEmpty == true &&
              seriesRendererDetails.oldSelectedIndexes!.length ==
                  _series.initialSelectedDataIndexes!.length) {
            for (final int index in _series.initialSelectedDataIndexes!) {
              isSelecetedIndexesUpdated =
                  seriesRendererDetails.oldSelectedIndexes!.contains(index) ==
                      false;
              if (isSelecetedIndexesUpdated) {
                break;
              }
            }
          } else {
            isSelecetedIndexesUpdated =
                _series.initialSelectedDataIndexes!.isNotEmpty;
          }
          int totalSelectedSegment = 0;
          int? selectedSeriesIndex;
          if (selectionBehavior.enable == true &&
              _stateProperties.selectedSegments.isNotEmpty &&
              _stateProperties.unselectedSegments.isNotEmpty) {
            for (int j = 0; j < _stateProperties.selectedSegments.length; j++) {
              final SegmentProperties segmentProperties =
                  SegmentHelper.getSegmentProperties(
                      _stateProperties.selectedSegments[j]);
              if (segmentProperties.seriesIndex == i) {
                totalSelectedSegment += 1;
                selectedSeriesIndex = segmentProperties.seriesIndex;
              }
            }
            for (int k = 0;
                k < _stateProperties.unselectedSegments.length;
                k++) {
              if (SegmentHelper.getSegmentProperties(
                          _stateProperties.unselectedSegments[k])
                      .seriesIndex ==
                  i) {
                totalSelectedSegment += 1;
              }
            }
          }
          if (_stateProperties.isRangeSelectionSlider == false &&
              selectionBehavior.enable == true &&
              (isSelecetedIndexesUpdated ||
                  (!_renderingDetails.initialRender! &&
                      (totalSelectedSegment != 0 &&
                          (totalSelectedSegment <
                              SeriesHelper.getSeriesRendererDetails(
                                      _stateProperties.seriesRenderers[i])
                                  .dataPoints
                                  .length))))) {
            int segmentLength = seriesRendererDetails.dataPoints.length;

            if (isLineTypeSeries(seriesRendererDetails.seriesType) ||
                seriesRendererDetails.seriesType.contains('boxandwhisker') ==
                    true) {
              segmentLength = seriesRendererDetails.dataPoints.length - 1;
            }

            for (int j = 0; j < segmentLength; j++) {
              final ChartSegment segment = ColumnSegment();
              SegmentHelper.setSegmentProperties(
                  segment, SegmentProperties(_stateProperties, segment));
              final SegmentProperties segmentProperties =
                  SegmentHelper.getSegmentProperties(segment);
              segment.currentSegmentIndex = j;
              segmentProperties.seriesIndex = i;
              segmentProperties.currentPoint =
                  seriesRendererDetails.dataPoints[j];
              ((_series.initialSelectedDataIndexes!
                              .contains(segment.currentSegmentIndex) &&
                          isSelecetedIndexesUpdated) ||
                      chart.selectionType == SelectionType.series &&
                          selectedSeriesIndex == i)
                  ? SelectionHelper.getRenderingDetails(
                          selectionBehaviorRenderer)
                      .selectionRenderer!
                      .selectedSegments
                      .add(segment)
                  : SelectionHelper.getRenderingDetails(
                          selectionBehaviorRenderer)
                      .selectionRenderer!
                      .unselectedSegments!
                      .add(segment);
            }
            seriesRendererDetails.oldSelectedIndexes = <int>[]
              //ignore: prefer_spread_collections
              ..addAll(_series.initialSelectedDataIndexes!);
          }
        }
        // ignore: unnecessary_null_comparison
        if (seriesRendererDetails.animationController != null &&
            _series.animationDuration > 0 &&
            !_renderingDetails.didSizeChange &&
            (_renderingDetails.oldDeviceOrientation == null ||
                _stateProperties.legendRefresh ||
                _stateProperties.renderingDetails.oldDeviceOrientation ==
                    _stateProperties.renderingDetails.deviceOrientation) &&
            (_renderingDetails.initialRender! ||
                _stateProperties.legendRefresh ||
                ((_seriesType == 'column' || _seriesType == 'bar') &&
                    _stateProperties.legendToggling) ||
                (!_stateProperties.legendToggling &&
                    seriesRendererDetails.needsAnimation == true &&
                    _stateProperties.renderingDetails.widgetNeedUpdate))) {
          if ((_seriesType == 'column' || _seriesType == 'bar') &&
              _stateProperties.legendToggling) {
            seriesRendererDetails.needAnimateSeriesElements = true;
          }
          _stateProperties.forwardAnimation(seriesRendererDetails);
        } else {
          seriesRendererDetails.animationController.duration =
              const Duration(milliseconds: 0);
          seriesRendererDetails.seriesAnimation =
              Tween<double>(begin: 1, end: 1.0).animate(CurvedAnimation(
            parent: seriesRendererDetails.animationController,
            curve: const Interval(0.1, 0.8, curve: Curves.decelerate),
          ));
          seriesRendererDetails.seriesElementAnimation =
              Tween<double>(begin: 1, end: 1.0).animate(CurvedAnimation(
            parent: seriesRendererDetails.animationController,
            curve: const Interval(1.0, 1.0, curve: Curves.decelerate),
          ));
          _stateProperties.animationCompleteCount++;
          seriesRendererDetails.animationCompleted = true;
          setAnimationStatus(_stateProperties);
        }
      }
      _stateProperties.renderingDetails.chartWidgets!.add(Container(
          child: RepaintBoundary(
              child: CustomPaint(
        painter: _getSeriesPainter(
            i, seriesRendererDetails.animationController, _seriesRenderer),
      ))));
    }
    _stateProperties.renderingDetails.chartWidgets!.add(Container(
        color: Colors.red,
        child: RepaintBoundary(
            child: CustomPaint(
                painter: ZoomRectPainter(
                    isRepaint: true,
                    stateProperties: _stateProperties,
                    notifier: _stateProperties.repaintNotifiers['zoom'])))));
    _stateProperties.legendToggling = false;
  }

  /// Bind the axis widgets
  void _bindAxisWidgets(String renderType) {
    // ignore: unnecessary_null_comparison
    if (_stateProperties.chartAxis.axisRenderersCollection != null &&
        _stateProperties.chartAxis.axisRenderersCollection.isNotEmpty &&
        _stateProperties.chartAxis.axisRenderersCollection.length > 1) {
      final CartesianAxisWidget axisWidget = CartesianAxisWidget(
          stateProperties: _stateProperties, renderType: renderType);
      renderType == 'outside'
          ? _stateProperties.renderOutsideAxis = axisWidget
          : _stateProperties.renderInsideAxis = axisWidget;
      _stateProperties.renderingDetails.chartWidgets!.add(axisWidget);
    }
  }

  /// To find a series on selection event
  CartesianSeriesRenderer? _findSeries(Offset position) {
    CartesianSeriesRenderer? seriesRenderer;
    SelectionBehaviorRenderer? selectionBehaviorRenderer;
    outerLoop:
    for (int i = _stateProperties.chartSeries.visibleSeriesRenderers.length - 1;
        i >= 0;
        i--) {
      seriesRenderer = _stateProperties.chartSeries.visibleSeriesRenderers[i];
      final SeriesRendererDetails seriesRendererDetails =
          SeriesHelper.getSeriesRendererDetails(seriesRenderer);
      final String _seriesType = seriesRendererDetails.seriesType;
      if (_seriesType == 'column' ||
          _seriesType == 'bar' ||
          _seriesType == 'scatter' ||
          _seriesType == 'bubble' ||
          _seriesType == 'fastline' ||
          _seriesType.contains('area') ||
          _seriesType.contains('stackedcolumn') ||
          _seriesType.contains('stackedbar') ||
          _seriesType.contains('range') ||
          _seriesType == 'histogram' ||
          _seriesType == 'waterfall' ||
          _seriesType == 'errorbar') {
        for (int j = 0; j < seriesRendererDetails.dataPoints.length; j++) {
          if (seriesRendererDetails.dataPoints[j].region != null &&
              seriesRendererDetails.dataPoints[j].region!.contains(position) ==
                  true) {
            seriesRendererDetails.isOuterRegion = false;
            break outerLoop;
          } else {
            seriesRendererDetails.isOuterRegion = true;
          }
        }
      } else {
        selectionBehaviorRenderer =
            seriesRendererDetails.selectionBehaviorRenderer;
        bool isSelect = false;
        seriesRenderer = _stateProperties.chartSeries.visibleSeriesRenderers[i];
        for (int k =
                _stateProperties.chartSeries.visibleSeriesRenderers.length - 1;
            k >= 0;
            k--) {
          isSelect = seriesRendererDetails.isSelectionEnable == true &&
              seriesRendererDetails.visible != null &&
              seriesRendererDetails.visible! == true &&
              seriesRendererDetails.visibleDataPoints != null &&
              seriesRendererDetails.visibleDataPoints!.isNotEmpty &&
              (SelectionHelper.getRenderingDetails(selectionBehaviorRenderer!)
                      .selectionRenderer!
                      .isSeriesContainsPoint(
                          SeriesHelper.getSeriesRendererDetails(_stateProperties
                              .chartSeries.visibleSeriesRenderers[i]),
                          position) ==
                  true);
          if (isSelect) {
            return _stateProperties.chartSeries.visibleSeriesRenderers[i];
          } else if (seriesRendererDetails.visible != null &&
              seriesRendererDetails.visible! == true &&
              seriesRendererDetails.visibleDataPoints != null &&
              seriesRendererDetails.visibleDataPoints!.isNotEmpty &&
              SelectionHelper.getRenderingDetails(selectionBehaviorRenderer!)
                      .selectionRenderer!
                      .isSeriesContainsPoint(
                          SeriesHelper.getSeriesRendererDetails(_stateProperties
                              .chartSeries.visibleSeriesRenderers[i]),
                          position) ==
                  true) {
            return _stateProperties.chartSeries.visibleSeriesRenderers[i];
          }
        }
      }
    }
    return seriesRenderer;
  }

  /// To perform the pointer down event
  void _performPointerDown(PointerDownEvent event) {
    _stateProperties.canSetRangeController = true;
    TooltipHelper.getRenderingDetails(
            _stateProperties.renderingDetails.tooltipBehaviorRenderer)
        .isHovering = false;
    _tapDownDetails = event.position;
    if (chart.zoomPanBehavior.enablePinching == true) {
      ZoomPanArgs? zoomStartArgs;
      if (_stateProperties.touchStartPositions.length < 2) {
        _stateProperties.touchStartPositions.add(event);
      }
      if (_stateProperties.touchStartPositions.length == 2) {
        for (int axisIndex = 0;
            axisIndex <
                _stateProperties.chartAxis.axisRenderersCollection.length;
            axisIndex++) {
          final ChartAxisRendererDetails axisDetails =
              AxisHelper.getAxisRendererDetails(_stateProperties
                  .chartAxis.axisRenderersCollection[axisIndex]);

          if (chart.onZoomStart != null) {
            zoomStartArgs =
                bindZoomEvent(chart, axisDetails, chart.onZoomStart!);
            axisDetails.zoomFactor = zoomStartArgs.currentZoomFactor;
            axisDetails.zoomPosition = zoomStartArgs.currentZoomPosition;
          }
          _stateProperties.zoomPanBehaviorRenderer.onPinchStart(
              axisDetails.axis,
              _stateProperties.touchStartPositions[0].position.dx,
              _stateProperties.touchStartPositions[0].position.dy,
              _stateProperties.touchStartPositions[1].position.dx,
              _stateProperties.touchStartPositions[1].position.dy,
              axisDetails.zoomFactor);
        }
      }
    }
    final Offset position = renderBox.globalToLocal(event.position);
    _touchPosition = position;

    final CartesianSeriesRenderer? cartesianSeriesRenderer =
        _findSeries(position);
    // ignore: unnecessary_null_comparison
    if (chart.trackballBehavior != null &&
        chart.trackballBehavior.enable &&
        chart.trackballBehavior.activationMode == ActivationMode.singleTap &&
        cartesianSeriesRenderer != null &&
        SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer).series
            is! ErrorBarSeries) {
      if (chart.trackballBehavior.builder != null) {
        trackballRenderingDetails.isMoving = true;
        trackballRenderingDetails.showTemplateTrackball(position);
      } else {
        _stateProperties.trackballBehaviorRenderer
            .onTouchDown(position.dx, position.dy);
      }
    }
    // ignore: unnecessary_null_comparison
    if (chart.crosshairBehavior != null &&
        chart.crosshairBehavior.enable &&
        chart.crosshairBehavior.activationMode == ActivationMode.singleTap &&
        cartesianSeriesRenderer != null &&
        SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer).series
            is! ErrorBarSeries) {
      _stateProperties.crosshairBehaviorRenderer
          .onTouchDown(position.dx, position.dy);
    }
  }

  /// To perform the pointer move event
  void _performPointerMove(PointerMoveEvent event) {
    TooltipHelper.getRenderingDetails(
            _stateProperties.renderingDetails.tooltipBehaviorRenderer)
        .isHovering = false;
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (chart.zoomPanBehavior.enablePinching == true &&
        _stateProperties.touchStartPositions.length == 2) {
      zoomingBehaviorDetails.isPinching = true;
      final int pointerID = event.pointer;
      bool addPointer = true;
      for (int i = 0; i < _stateProperties.touchMovePositions.length; i++) {
        if (_stateProperties.touchMovePositions[i].pointer == pointerID) {
          addPointer = false;
        }
      }
      if (_stateProperties.touchMovePositions.length < 2 && addPointer) {
        _stateProperties.touchMovePositions.add(event);
      }

      if (_stateProperties.touchMovePositions.length == 2 &&
          _stateProperties.touchStartPositions.length == 2) {
        if (_stateProperties.touchMovePositions[0].pointer == event.pointer) {
          _stateProperties.touchMovePositions[0] = event;
        }
        if (_stateProperties.touchMovePositions[1].pointer == event.pointer) {
          _stateProperties.touchMovePositions[1] = event;
        }
        zoomingBehaviorDetails.performPinchZooming(
            _stateProperties.touchStartPositions,
            _stateProperties.touchMovePositions);
      }
    }
  }

  /// To perform the pointer up event
  void _performPointerUp(PointerUpEvent event) {
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (_stateProperties.touchStartPositions.length == 2 &&
        _stateProperties.touchMovePositions.length == 2 &&
        zoomingBehaviorDetails.isPinching == true) {
      _calculatePinchZoomingArgs();
    }

    _stateProperties.touchStartPositions = <PointerEvent>[];
    _stateProperties.touchMovePositions = <PointerEvent>[];
    zoomingBehaviorDetails.isPinching = false;
    zoomingBehaviorDetails.delayRedraw = false;
    final TooltipRenderingDetails tooltipRenderingDetails =
        TooltipHelper.getRenderingDetails(
            _stateProperties.renderingDetails.tooltipBehaviorRenderer);
    tooltipRenderingDetails.isHovering = false;
    final Offset position = renderBox.globalToLocal(event.position);
    final CartesianSeriesRenderer? cartesianSeriesRenderer =
        _findSeries(position);
    // ignore: unnecessary_null_comparison
    if ((chart.trackballBehavior != null &&
            chart.trackballBehavior.enable &&
            !chart.trackballBehavior.shouldAlwaysShow &&
            cartesianSeriesRenderer != null &&
            SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer)
                .series is! ErrorBarSeries &&
            chart.trackballBehavior.activationMode !=
                ActivationMode.doubleTap &&
            zoomingBehaviorDetails.isPinching != true) ||
        // ignore: unnecessary_null_comparison
        (chart.zoomPanBehavior != null &&
            ((chart.zoomPanBehavior.enableDoubleTapZooming ||
                    chart.zoomPanBehavior.enablePanning ||
                    chart.zoomPanBehavior.enablePinching ||
                    chart.zoomPanBehavior.enableSelectionZooming) &&
                !chart.trackballBehavior.shouldAlwaysShow))) {
      _stateProperties.trackballBehaviorRenderer
          .onTouchUp(position.dx, position.dy);

      trackballRenderingDetails.isLongPressActivated = false;
    }
    // ignore: unnecessary_null_comparison
    if ((chart.crosshairBehavior != null &&
            chart.crosshairBehavior.enable &&
            !chart.crosshairBehavior.shouldAlwaysShow &&
            chart.crosshairBehavior.activationMode !=
                ActivationMode.doubleTap &&
            cartesianSeriesRenderer != null &&
            SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer)
                .series is! ErrorBarSeries &&
            zoomingBehaviorDetails.isPinching != true) ||
        // ignore: unnecessary_null_comparison
        (chart.zoomPanBehavior != null &&
            ((chart.zoomPanBehavior.enableDoubleTapZooming ||
                    chart.zoomPanBehavior.enablePanning ||
                    chart.zoomPanBehavior.enablePinching ||
                    chart.zoomPanBehavior.enableSelectionZooming) &&
                !chart.crosshairBehavior.shouldAlwaysShow))) {
      _stateProperties.crosshairBehaviorRenderer
          .onTouchUp(position.dx, position.dy);
      CrosshairHelper.getRenderingDetails(
              _stateProperties.crosshairBehaviorRenderer)
          .isLongPressActivated = false;
    }
    if (chart.tooltipBehavior.enable &&
            chart.tooltipBehavior.activationMode == ActivationMode.singleTap ||
        shouldShowAxisTooltip(_stateProperties)) {
      tooltipRenderingDetails.isInteraction = true;
      chart.tooltipBehavior.builder != null
          ? tooltipRenderingDetails.showTemplateTooltip(position)
          : _stateProperties.renderingDetails.tooltipBehaviorRenderer
              .onTouchUp(position.dx, position.dy);
    }
  }

  /// To perform the pointer signal event
  void _performPointerSignal(PointerScrollEvent event) {
    _mousePointerDetails = event.position;
    if (_mousePointerDetails != null) {
      final Offset position = renderBox.globalToLocal(event.position);
      if (chart.zoomPanBehavior.enableMouseWheelZooming &&
          _stateProperties.chartAxis.axisClipRect.contains(position)) {
        ZoomPanBehaviorHelper.getRenderingDetails(
                _stateProperties.zoomPanBehaviorRenderer)
            .performMouseWheelZooming(event, position.dx, position.dy);
      }
    }
  }

  /// To calculate the arguments of pinch zooming event
  void _calculatePinchZoomingArgs() {
    ZoomPanArgs? zoomEndArgs;
    bool resetFlag = false;
    int axisIndex;
    for (axisIndex = 0;
        axisIndex < _stateProperties.chartAxis.axisRenderersCollection.length;
        axisIndex++) {
      final ChartAxisRendererDetails axisDetails =
          AxisHelper.getAxisRendererDetails(
              _stateProperties.chartAxis.axisRenderersCollection[axisIndex]);
      if (chart.onZoomEnd != null) {
        zoomEndArgs = bindZoomEvent(chart, axisDetails, chart.onZoomEnd!);
        axisDetails.zoomFactor = zoomEndArgs.currentZoomFactor;
        axisDetails.zoomPosition = zoomEndArgs.currentZoomPosition;
      }
      if (axisDetails.zoomFactor.toInt() == 1 &&
          axisDetails.zoomPosition.toInt() == 0 &&
          chart.onZoomReset != null) {
        resetFlag = true;
      }
      _stateProperties.zoomAxes = <ZoomAxisRange>[];
      _stateProperties.zoomPanBehaviorRenderer.onPinchEnd(
          axisDetails.axis,
          _stateProperties.touchMovePositions[0].position.dx,
          _stateProperties.touchMovePositions[0].position.dy,
          _stateProperties.touchMovePositions[1].position.dx,
          _stateProperties.touchMovePositions[1].position.dy,
          axisDetails.zoomFactor);
    }
    if (resetFlag) {
      for (int index = 0;
          index < _stateProperties.chartAxis.axisRenderersCollection.length;
          index++) {
        final ChartAxisRendererDetails axisDetails =
            AxisHelper.getAxisRendererDetails(
                _stateProperties.chartAxis.axisRenderersCollection[index]);
        bindZoomEvent(chart, axisDetails, chart.onZoomReset!);
      }
    }
  }

  /// To perform long press move update
  void _performLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final Offset? position = renderBox.globalToLocal(details.globalPosition);
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (zoomingBehaviorDetails.isPinching != true) {
      if (chart.zoomPanBehavior.enableSelectionZooming &&
          position != null &&
          _zoomStartPosition != null) {
        zoomingBehaviorDetails.canPerformSelection = true;
        _stateProperties.zoomPanBehaviorRenderer.onDrawSelectionZoomRect(
            position.dx,
            position.dy,
            _zoomStartPosition!.dx,
            _zoomStartPosition!.dy);
      }
    }
    // ignore: unnecessary_null_comparison
    if (chart.trackballBehavior != null &&
        chart.trackballBehavior.enable &&
        // ignore: unnecessary_null_comparison
        _renderingDetails != null &&
        chart.trackballBehavior.activationMode != ActivationMode.doubleTap &&
        position != null &&
        _findSeries(position) != null &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(position)!).series
            is! ErrorBarSeries) {
      if (chart.trackballBehavior.activationMode == ActivationMode.singleTap) {
        chart.trackballBehavior.builder != null
            ? trackballRenderingDetails.showTemplateTrackball(position)
            : _stateProperties.trackballBehaviorRenderer
                .onTouchMove(position.dx, position.dy);
      }
      if (chart.trackballBehavior.activationMode == ActivationMode.longPress &&
          trackballRenderingDetails.isLongPressActivated == true) {
        chart.trackballBehavior.builder != null
            ? trackballRenderingDetails.showTemplateTrackball(position)
            : _stateProperties.trackballBehaviorRenderer
                .onTouchMove(position.dx, position.dy);
      }
    }
    // ignore: unnecessary_null_comparison
    if (chart.crosshairBehavior != null &&
        chart.crosshairBehavior.enable &&
        chart.crosshairBehavior.activationMode != ActivationMode.doubleTap &&
        position != null &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(position)!).series
            is! ErrorBarSeries) {
      if (chart.crosshairBehavior.activationMode == ActivationMode.singleTap) {
        _stateProperties.crosshairBehaviorRenderer
            .onTouchMove(position.dx, position.dy);
        // ignore: unnecessary_null_comparison
      } else if ((chart.crosshairBehavior != null &&
              chart.crosshairBehavior.activationMode ==
                  ActivationMode.longPress &&
              CrosshairHelper.getRenderingDetails(
                          _stateProperties.crosshairBehaviorRenderer)
                      .isLongPressActivated ==
                  true) &&
          !chart.zoomPanBehavior.enableSelectionZooming) {
        _stateProperties.crosshairBehaviorRenderer
            .onTouchMove(position.dx, position.dy);
      }
    }
  }

  /// To perform long press end
  void _performLongPressEnd() {
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (zoomingBehaviorDetails.isPinching != true) {
      zoomingBehaviorDetails.canPerformSelection = false;
      if (chart.zoomPanBehavior.enableSelectionZooming &&
          zoomingBehaviorDetails.zoomingRect.width != 0) {
        zoomingBehaviorDetails
            .doSelectionZooming(zoomingBehaviorDetails.zoomingRect);
        if (zoomingBehaviorDetails.canPerformSelection != true) {
          zoomingBehaviorDetails.zoomingRect = const Rect.fromLTRB(0, 0, 0, 0);
        }
      }
    }
  }

  /// To perform pan down
  void _performPanDown(DragDownDetails details) {
    _stateProperties.startOffset =
        renderBox.globalToLocal(details.globalPosition);
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (zoomingBehaviorDetails.isPinching != true) {
      _zoomStartPosition = renderBox.globalToLocal(details.globalPosition);
      if (chart.zoomPanBehavior.enablePanning == true) {
        zoomingBehaviorDetails.isPanning = true;
        zoomingBehaviorDetails.previousMovedPosition = null;
      }
    }
  }

  /// To perform long press on chart
  void _performLongPress() {
    Offset? position;
    if (_tapDownDetails != null) {
      position = renderBox.globalToLocal(_tapDownDetails!);
      final CartesianSeriesRenderer? cartesianSeriesRenderer =
          _findSeries(position);
      if (cartesianSeriesRenderer != null &&
          SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer)
                  .series
                  .onPointLongPress !=
              null) {
        calculatePointSeriesIndex(
            chart, _stateProperties, position, null, ActivationMode.longPress);
      }
      if (chart.tooltipBehavior.enable &&
              chart.tooltipBehavior.activationMode ==
                  ActivationMode.longPress ||
          shouldShowAxisTooltip(_stateProperties)) {
        final TooltipRenderingDetails tooltipRenderingDetails =
            TooltipHelper.getRenderingDetails(
                _stateProperties.renderingDetails.tooltipBehaviorRenderer);
        tooltipRenderingDetails.isInteraction = true;
        chart.tooltipBehavior.builder != null
            ? tooltipRenderingDetails.showTemplateTooltip(position)
            : _stateProperties.renderingDetails.tooltipBehaviorRenderer
                .onLongPress(position.dx, position.dy);
      }
    }
    // ignore: unnecessary_null_comparison
    if (_stateProperties.chartSeries.visibleSeriesRenderers != null &&
        position != null &&
        chart.selectionGesture == ActivationMode.longPress) {
      final CartesianSeriesRenderer selectionSeriesRenderer =
          _findSeries(position)!;
      final SeriesRendererDetails seriesRendererDetails =
          SeriesHelper.getSeriesRendererDetails(selectionSeriesRenderer);
      final SelectionBehaviorRenderer selectionBehaviorRenderer =
          seriesRendererDetails.selectionBehaviorRenderer!;
      SelectionHelper.getRenderingDetails(selectionBehaviorRenderer)
          .selectionRenderer!
          .seriesRendererDetails = seriesRendererDetails;
      selectionBehaviorRenderer.onLongPress(position.dx, position.dy);
    }
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    // ignore: unnecessary_null_comparison
    if ((chart.trackballBehavior != null &&
            chart.trackballBehavior.enable == true &&
            chart.trackballBehavior.activationMode ==
                ActivationMode.longPress) &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(position!)!).series
            is! ErrorBarSeries &&
        position != null &&
        zoomingBehaviorDetails.isPinching != true) {
      trackballRenderingDetails.isLongPressActivated = true;
      chart.trackballBehavior.builder != null
          ? trackballRenderingDetails.showTemplateTrackball(position)
          : _stateProperties.trackballBehaviorRenderer
              .onTouchDown(position.dx, position.dy);
    }
    // ignore: unnecessary_null_comparison
    if ((chart.crosshairBehavior != null &&
            chart.crosshairBehavior.enable == true &&
            chart.crosshairBehavior.activationMode ==
                ActivationMode.longPress) &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(position!)!).series
            is! ErrorBarSeries &&
        !chart.zoomPanBehavior.enableSelectionZooming &&
        zoomingBehaviorDetails.isPinching != true &&
        position != null) {
      CrosshairHelper.getRenderingDetails(
              _stateProperties.crosshairBehaviorRenderer)
          .isLongPressActivated = true;
      _stateProperties.crosshairBehaviorRenderer
          .onTouchDown(position.dx, position.dy);
    }
  }

  /// Method for double tap
  void _performDoubleTap() {
    if (_tapDownDetails != null) {
      final Offset position = renderBox.globalToLocal(_tapDownDetails!);
      final CartesianSeriesRenderer? cartesianSeriesRenderer =
          _findSeries(position);
      if (cartesianSeriesRenderer != null &&
          SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer)
                  .series
                  .onPointDoubleTap !=
              null) {
        calculatePointSeriesIndex(
            chart, _stateProperties, position, null, ActivationMode.doubleTap);
      }
      // ignore: unnecessary_null_comparison
      if (chart.trackballBehavior != null &&
          chart.trackballBehavior.enable &&
          cartesianSeriesRenderer != null &&
          SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer).series
              is! ErrorBarSeries &&
          chart.trackballBehavior.activationMode == ActivationMode.doubleTap) {
        chart.trackballBehavior.builder != null
            ? trackballRenderingDetails.showTemplateTrackball(position)
            : _stateProperties.trackballBehaviorRenderer
                .onDoubleTap(position.dx, position.dy);
        _stateProperties.enableDoubleTap = true;
        _stateProperties.isTouchUp = true;
        _stateProperties.trackballBehaviorRenderer
            .onTouchUp(position.dx, position.dy);
        _stateProperties.isTouchUp = false;
        _stateProperties.enableDoubleTap = false;
      }
      // ignore: unnecessary_null_comparison
      if (chart.crosshairBehavior != null &&
          chart.crosshairBehavior.enable &&
          cartesianSeriesRenderer != null &&
          SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer).series
              is! ErrorBarSeries &&
          chart.crosshairBehavior.activationMode == ActivationMode.doubleTap) {
        _stateProperties.crosshairBehaviorRenderer
            .onDoubleTap(position.dx, position.dy);
        _stateProperties.enableDoubleTap = true;
        _stateProperties.isTouchUp = true;
        _stateProperties.crosshairBehaviorRenderer
            .onTouchUp(position.dx, position.dy);
        _stateProperties.isTouchUp = false;
        _stateProperties.enableDoubleTap = false;
      }

      if (chart.tooltipBehavior.enable &&
              chart.tooltipBehavior.activationMode ==
                  ActivationMode.doubleTap ||
          shouldShowAxisTooltip(_stateProperties)) {
        final TooltipRenderingDetails tooltipRenderingDetails =
            TooltipHelper.getRenderingDetails(
                _stateProperties.renderingDetails.tooltipBehaviorRenderer);
        tooltipRenderingDetails.isInteraction = true;
        chart.tooltipBehavior.builder != null
            ? tooltipRenderingDetails.showTemplateTooltip(position)
            : _stateProperties.renderingDetails.tooltipBehaviorRenderer
                .onDoubleTap(position.dx, position.dy);
      }
      // ignore: unnecessary_null_comparison
      if (_stateProperties.chartSeries.visibleSeriesRenderers != null &&
          chart.selectionGesture == ActivationMode.doubleTap) {
        final CartesianSeriesRenderer selectionSeriesRenderer =
            _findSeries(position)!;
        final SeriesRendererDetails seriesRendererDetails =
            SeriesHelper.getSeriesRendererDetails(selectionSeriesRenderer);
        final SelectionBehaviorRenderer selectionBehaviorRenderer =
            seriesRendererDetails.selectionBehaviorRenderer!;
        SelectionHelper.getRenderingDetails(selectionBehaviorRenderer)
            .selectionRenderer!
            .seriesRendererDetails = seriesRendererDetails;
        selectionBehaviorRenderer.onDoubleTap(position.dx, position.dy);
      }
    }

    if (chart.zoomPanBehavior.enableDoubleTapZooming == true) {
      final Offset? doubleTapPosition = _touchPosition;
      final Offset? position = doubleTapPosition;
      if (position != null) {
        _stateProperties.zoomPanBehaviorRenderer.onDoubleTap(
            position.dx,
            position.dy,
            ZoomPanBehaviorHelper.getRenderingDetails(
                    _stateProperties.zoomPanBehaviorRenderer)
                .zoomFactor);
      }
    }
  }

  /// Update the details for pan
  void _performPanUpdate(DragUpdateDetails details) {
    Offset? position;
    _stateProperties.currentPosition =
        renderBox.globalToLocal(details.globalPosition);
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (zoomingBehaviorDetails.isPinching != true) {
      position = renderBox.globalToLocal(details.globalPosition);
      if (zoomingBehaviorDetails.isPanning == true &&
          chart.zoomPanBehavior.enablePanning &&
          zoomingBehaviorDetails.previousMovedPosition != null &&
          !_stateProperties.isLoadMoreIndicator) {
        _stateProperties.zoomPanBehaviorRenderer
            .onPan(position.dx, position.dy);
      }
      zoomingBehaviorDetails.previousMovedPosition = position;
    }
    final bool panInProgress = chart.zoomPanBehavior.enablePanning &&
        zoomingBehaviorDetails.previousMovedPosition != null;
    // ignore: unnecessary_null_comparison
    if (chart.trackballBehavior != null &&
        chart.trackballBehavior.enable &&
        position != null &&
        _findSeries(position) != null &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(position)!).series
            is! ErrorBarSeries &&
        !panInProgress &&
        chart.trackballBehavior.activationMode != ActivationMode.doubleTap) {
      if (chart.trackballBehavior.activationMode == ActivationMode.singleTap) {
        if (chart.trackballBehavior.builder != null) {
          trackballRenderingDetails.isMoving = true;
          trackballRenderingDetails.showTemplateTrackball(position);
        } else {
          _stateProperties.trackballBehaviorRenderer
              .onTouchMove(position.dx, position.dy);
        }
        // ignore: unnecessary_null_comparison
      } else if (chart.trackballBehavior != null &&
          chart.trackballBehavior.activationMode == ActivationMode.longPress &&
          position != null &&
          _findSeries(position) != null &&
          SeriesHelper.getSeriesRendererDetails(_findSeries(position)!).series
              is! ErrorBarSeries &&
          trackballRenderingDetails.isLongPressActivated == true) {
        chart.trackballBehavior.builder != null
            ? trackballRenderingDetails.showTemplateTrackball(position)
            : _stateProperties.trackballBehaviorRenderer
                .onTouchMove(position.dx, position.dy);
      }
    }
    // ignore: unnecessary_null_comparison
    if (chart.crosshairBehavior != null &&
        chart.crosshairBehavior.enable &&
        chart.crosshairBehavior.activationMode != ActivationMode.doubleTap &&
        position != null &&
        _findSeries(position) != null &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(position)!).series
            is! ErrorBarSeries &&
        !panInProgress) {
      if (chart.crosshairBehavior.activationMode == ActivationMode.singleTap) {
        _stateProperties.crosshairBehaviorRenderer
            .onTouchMove(position.dx, position.dy);
        // ignore: unnecessary_null_comparison
      } else if (chart.crosshairBehavior != null &&
          chart.crosshairBehavior.activationMode == ActivationMode.longPress &&
          CrosshairHelper.getRenderingDetails(
                      _stateProperties.crosshairBehaviorRenderer)
                  .isLongPressActivated ==
              true) {
        _stateProperties.crosshairBehaviorRenderer
            .onTouchMove(position.dx, position.dy);
      }
    }
  }

  /// Method for the pan end event
  void _performPanEnd(DragEndDetails details) {
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    if (zoomingBehaviorDetails.isPinching != true) {
      zoomingBehaviorDetails.isPanning = false;
      zoomingBehaviorDetails.previousMovedPosition = null;
    }
    if (chart.trackballBehavior.enable &&
        !chart.trackballBehavior.shouldAlwaysShow &&
        chart.trackballBehavior.activationMode != ActivationMode.doubleTap &&
        _touchPosition != null &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(_touchPosition!)!)
            .series is! ErrorBarSeries) {
      _stateProperties.isTouchUp = true;
      _stateProperties.trackballBehaviorRenderer
          .onTouchUp(_touchPosition!.dx, _touchPosition!.dy);
      _stateProperties.isTouchUp = false;
      trackballRenderingDetails.isLongPressActivated = false;
    }
    if (chart.crosshairBehavior.enable &&
        !chart.crosshairBehavior.shouldAlwaysShow &&
        _touchPosition != null &&
        SeriesHelper.getSeriesRendererDetails(_findSeries(_touchPosition!)!)
            .series is! ErrorBarSeries &&
        chart.crosshairBehavior.activationMode != ActivationMode.doubleTap) {
      _stateProperties.isTouchUp = true;
      _stateProperties.crosshairBehaviorRenderer
          .onTouchUp(_touchPosition!.dx, _touchPosition!.dy);
      _stateProperties.isTouchUp = false;
      CrosshairHelper.getRenderingDetails(
              _stateProperties.crosshairBehaviorRenderer)
          .isLongPressActivated = false;
    }

    /// Pagination/Swiping feature
    if (chart.onPlotAreaSwipe != null &&
        _stateProperties.zoomedState != true &&
        _stateProperties.startOffset != null &&
        _stateProperties.currentPosition != null &&
        _stateProperties.chartAxis.axisClipRect
            .contains(_stateProperties.startOffset!) &&
        _stateProperties.chartAxis.axisClipRect
            .contains(_stateProperties.currentPosition!)) {
      //swipe configuration options
      const double swipeMaxDistanceThreshold = 50.0;
      final double swipeMinDisplacement = (_stateProperties.requireInvertedAxis
              ? _stateProperties.chartAxis.axisClipRect.height
              : _stateProperties.chartAxis.axisClipRect.width) *
          0.1;
      final double swipeMinVelocity =
          _stateProperties.pointerDeviceKind == PointerDeviceKind.mouse
              ? 0.0
              : 240;
      ChartSwipeDirection swipeDirection;

      final double dx = (_stateProperties.currentPosition!.dx -
              _stateProperties.startOffset!.dx)
          .abs();
      final double dy = (_stateProperties.currentPosition!.dy -
              _stateProperties.startOffset!.dy)
          .abs();
      final double velocity = details.primaryVelocity!;
      if (_stateProperties.requireInvertedAxis &&
          dx <= swipeMaxDistanceThreshold &&
          dy >= swipeMinDisplacement &&
          velocity.abs() >= swipeMinVelocity) {
        ///vertical
        swipeDirection =
            _stateProperties.pointerDeviceKind == PointerDeviceKind.mouse
                ? (_stateProperties.currentPosition!.dy >
                        _stateProperties.startOffset!.dy
                    ? ChartSwipeDirection.end
                    : ChartSwipeDirection.start)
                : (velocity < 0
                    ? ChartSwipeDirection.start
                    : ChartSwipeDirection.end);
        chart.onPlotAreaSwipe!(swipeDirection);
      } else if (!_stateProperties.requireInvertedAxis &&
          dx >= swipeMinDisplacement &&
          dy <= swipeMaxDistanceThreshold &&
          velocity.abs() >= swipeMinVelocity) {
        ///horizontal
        swipeDirection =
            _stateProperties.pointerDeviceKind == PointerDeviceKind.mouse
                ? (_stateProperties.currentPosition!.dx >
                        _stateProperties.startOffset!.dx
                    ? ChartSwipeDirection.start
                    : ChartSwipeDirection.end)
                : (velocity > 0
                    ? ChartSwipeDirection.start
                    : ChartSwipeDirection.end);
        chart.onPlotAreaSwipe!(swipeDirection);
      }
    }

    ///Load More feature
    if (chart.loadMoreIndicatorBuilder != null &&
        _stateProperties.startOffset != null &&
        _stateProperties.currentPosition != null) {
      final bool verticallyDragging = (_stateProperties.currentPosition!.dy -
                  _stateProperties.startOffset!.dy)
              .abs() >
          (_stateProperties.currentPosition!.dx -
                  _stateProperties.startOffset!.dx)
              .abs();
      if ((!verticallyDragging && !_stateProperties.requireInvertedAxis) ||
          (verticallyDragging && _stateProperties.requireInvertedAxis)) {
        bool loadMore = false;
        final ChartAxisRendererDetails primaryXAxisDetails =
            _stateProperties.chartAxis.primaryXAxisDetails;
        // Here, direction is set accordingly based on the axis transposed value
        // and primary x-axis inversed value.
        final ChartSwipeDirection direction =
            _stateProperties.requireInvertedAxis
                ? (_stateProperties.currentPosition!.dy >
                        _stateProperties.startOffset!.dy
                    ? primaryXAxisDetails.axis.isInversed
                        ? ChartSwipeDirection.start
                        : ChartSwipeDirection.end
                    : primaryXAxisDetails.axis.isInversed
                        ? ChartSwipeDirection.end
                        : ChartSwipeDirection.start)
                : (_stateProperties.currentPosition!.dx >
                        _stateProperties.startOffset!.dx
                    ? primaryXAxisDetails.axis.isInversed
                        ? ChartSwipeDirection.end
                        : ChartSwipeDirection.start
                    : primaryXAxisDetails.axis.isInversed
                        ? ChartSwipeDirection.start
                        : ChartSwipeDirection.end);
        for (int axisIndex = 0;
            axisIndex <
                _stateProperties.chartAxis.axisRenderersCollection.length;
            axisIndex++) {
          final ChartAxisRendererDetails axisDetails =
              AxisHelper.getAxisRendererDetails(_stateProperties
                  .chartAxis.axisRenderersCollection[axisIndex]);
          if (((!verticallyDragging &&
                      axisDetails.orientation == AxisOrientation.horizontal) ||
                  (verticallyDragging &&
                      axisDetails.orientation == AxisOrientation.vertical)) &&
              axisDetails.actualRange != null &&
              ((axisDetails.actualRange!.minimum.round() ==
                          axisDetails.visibleRange!.minimum.round() &&
                      direction == ChartSwipeDirection.start) ||
                  (axisDetails.actualRange!.maximum.round() ==
                          axisDetails.visibleRange!.maximum.round() &&
                      direction == ChartSwipeDirection.end))) {
            loadMore = true;
            break;
          }
        }

        if (loadMore && !_stateProperties.isLoadMoreIndicator) {
          _stateProperties.isLoadMoreIndicator = true;
          _stateProperties.loadMoreViewStateSetter(() {
            _stateProperties.swipeDirection = direction;
          });
        } else {
          _stateProperties.isLoadMoreIndicator = false;
        }
      }
    }
    _stateProperties.startOffset = null;
    _stateProperties.currentPosition = null;
  }

  /// To perform mouse hover event
  void _performMouseHover(PointerEvent event) {
    final TooltipRenderingDetails tooltipRenderingDetails =
        TooltipHelper.getRenderingDetails(
            _stateProperties.renderingDetails.tooltipBehaviorRenderer);
    tooltipRenderingDetails.isHovering = true;
    tooltipRenderingDetails.isInteraction = true;
    final Offset position = renderBox.globalToLocal(event.position);
    final CartesianSeriesRenderer? cartesianSeriesRenderer =
        _findSeries(position);
    if ((chart.tooltipBehavior.enable &&
            chart.tooltipBehavior.activationMode == ActivationMode.singleTap) ||
        shouldShowAxisTooltip(_stateProperties)) {
      chart.tooltipBehavior.builder != null
          ? tooltipRenderingDetails.showTemplateTooltip(position)
          : _stateProperties.renderingDetails.tooltipBehaviorRenderer
              .onEnter(position.dx, position.dy);
    }
    if (chart.trackballBehavior.enable &&
        cartesianSeriesRenderer != null &&
        SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer).series
            is! ErrorBarSeries &&
        chart.trackballBehavior.activationMode == ActivationMode.singleTap) {
      chart.trackballBehavior.builder != null
          ? trackballRenderingDetails.showTemplateTrackball(position)
          : _stateProperties.trackballBehaviorRenderer
              .onEnter(position.dx, position.dy);
    }
    if (chart.crosshairBehavior.enable &&
        cartesianSeriesRenderer != null &&
        SeriesHelper.getSeriesRendererDetails(cartesianSeriesRenderer).series
            is! ErrorBarSeries &&
        chart.crosshairBehavior.activationMode == ActivationMode.singleTap) {
      _stateProperties.crosshairBehaviorRenderer
          .onEnter(position.dx, position.dy);
    }
  }

  /// To perform the mouse exit event
  void _performMouseExit(PointerEvent event) {
    TooltipHelper.getRenderingDetails(
            _stateProperties.renderingDetails.tooltipBehaviorRenderer)
        .isHovering = false;
    final Offset position = renderBox.globalToLocal(event.position);
    if (chart.tooltipBehavior.enable ||
        shouldShowAxisTooltip(_stateProperties)) {
      _stateProperties.renderingDetails.tooltipBehaviorRenderer
          .onExit(position.dx, position.dy);
    }
    if (chart.crosshairBehavior.enable) {
      _stateProperties.crosshairBehaviorRenderer
          .onExit(position.dx, position.dy);
    }
    if (chart.trackballBehavior.enable) {
      _stateProperties.trackballBehaviorRenderer
          .onExit(position.dx, position.dy);
    }
  }

  /// To bind the interaction widgets
  void _bindInteractionWidgets(
      BoxConstraints constraints, BuildContext context) {
    TrackballPainter trackballPainter;
    CrosshairPainter crosshairPainter;

    final List<Widget> userInteractionWidgets = <Widget>[];
    final ZoomRectPainter zoomRectPainter =
        ZoomRectPainter(stateProperties: _stateProperties);
    final ZoomingBehaviorDetails zoomingBehaviorDetails =
        ZoomPanBehaviorHelper.getRenderingDetails(
            _stateProperties.zoomPanBehaviorRenderer);
    zoomingBehaviorDetails.painter = zoomRectPainter;
    CrosshairHelper.setStateProperties(
        chart.crosshairBehavior, _stateProperties);
    TooltipHelper.setStateProperties(chart.tooltipBehavior, _stateProperties);
    TrackballHelper.setStateProperties(
        chart.trackballBehavior, _stateProperties);
    ZoomPanBehaviorHelper.setStateProperties(
        chart.zoomPanBehavior, _stateProperties);
    // ignore: unnecessary_null_comparison
    if (chart.trackballBehavior != null && chart.trackballBehavior.enable) {
      if (chart.trackballBehavior.builder != null) {
        trackballRenderingDetails.trackballTemplate = TrackballTemplate(
            key: GlobalKey<State<TrackballTemplate>>(),
            trackballBehavior: chart.trackballBehavior,
            stateProperties: _stateProperties);
        userInteractionWidgets
            .add(trackballRenderingDetails.trackballTemplate!);
      } else {
        trackballPainter = TrackballPainter(
            stateProperties: _stateProperties,
            valueNotifier: _stateProperties.repaintNotifiers['trackball']!);
        trackballRenderingDetails.trackballPainter = trackballPainter;
        userInteractionWidgets.add(Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: CustomPaint(painter: trackballPainter)));
      }
    }
    // ignore: unnecessary_null_comparison
    if (chart.crosshairBehavior != null && chart.crosshairBehavior.enable) {
      crosshairPainter = CrosshairPainter(
          stateProperties: _stateProperties,
          valueNotifier: _stateProperties.repaintNotifiers['crosshair']!);
      CrosshairHelper.getRenderingDetails(
              _stateProperties.crosshairBehaviorRenderer)
          .crosshairPainter = crosshairPainter;
      userInteractionWidgets.add(Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: CustomPaint(painter: crosshairPainter)));
    }
    final TooltipBehavior tooltip = chart.tooltipBehavior;
    final TooltipRenderingDetails tooltipRenderingDetails =
        TooltipHelper.getRenderingDetails(
            _renderingDetails.tooltipBehaviorRenderer);
    if (chart.tooltipBehavior.enable ||
        shouldShowAxisTooltip(_stateProperties)) {
      tooltipRenderingDetails.prevTooltipValue =
          tooltipRenderingDetails.currentTooltipValue = null;
      tooltipRenderingDetails.chartTooltip = SfTooltip(
          color: tooltip.color ?? _renderingDetails.chartTheme.tooltipColor,
          key: GlobalKey(),
          textStyle: tooltip.textStyle,
          animationDuration: tooltip.animationDuration,
          animationCurve: const Interval(0.1, 0.8, curve: Curves.easeOutBack),
          enable: tooltip.enable,
          opacity: tooltip.opacity,
          borderColor: tooltip.borderColor,
          borderWidth: tooltip.builder == null ? tooltip.borderWidth : 0,
          duration: tooltip.duration.toInt(),
          shouldAlwaysShow: tooltip.shouldAlwaysShow,
          elevation: tooltip.elevation,
          canShowMarker: tooltip.canShowMarker,
          textAlignment: tooltip.textAlignment,
          decimalPlaces: tooltip.decimalPlaces,
          labelColor: tooltip.textStyle.color ??
              _renderingDetails.chartTheme.tooltipLabelColor,
          header: tooltip.header,
          format: tooltip.format,
          shadowColor: tooltip.shadowColor,
          onTooltipRender: chart.onTooltipRender != null
              ? tooltipRenderingDetails.tooltipRenderingEvent
              : null);
      _renderingDetails.chartWidgets!
          .add(tooltipRenderingDetails.chartTooltip!);
    }
    final Widget uiWidget = IgnorePointer(
        ignoring: chart.annotations != null,
        child: Stack(children: userInteractionWidgets));
    _stateProperties.renderingDetails.chartWidgets!.add(uiWidget);
  }

  /// Triggering onAxisLabelTapped event
  void _triggerAxisLabelEvent(Offset position) {
    for (int i = 0;
        i < _stateProperties.chartAxis.axisRenderersCollection.length;
        i++) {
      final ChartAxisRendererDetails axisDetails =
          AxisHelper.getAxisRendererDetails(
              _stateProperties.chartAxis.axisRenderersCollection[i]);
      final List<AxisLabel> labels = axisDetails.visibleLabels;
      for (int k = 0; k < labels.length; k++) {
        if (axisDetails.axis.isVisible &&
            AxisHelper.getLabelRegion(labels[k]) != null &&
            AxisHelper.getLabelRegion(labels[k])!.contains(position)) {
          AxisLabelTapArgs labelArgs;
          labelArgs = AxisLabelTapArgs(axisDetails.axis, axisDetails.name!);
          labelArgs.text = labels[k].text;
          labelArgs.value = labels[k].value;
          chart.onAxisLabelTapped!(labelArgs);
        }
      }
    }
  }

  /// Gets method of the series painter
  CustomPainter _getSeriesPainter(int value, AnimationController controller,
      CartesianSeriesRenderer seriesRenderer) {
    CustomPainter? customPainter;
    final PainterKey painterKey = PainterKey(
        index: value, name: 'series $value', isRenderCompleted: false);
    _stateProperties.painterKeys.add(painterKey);
    final SeriesRendererDetails seriesRendererDetails =
        SeriesHelper.getSeriesRendererDetails(seriesRenderer);
    switch (seriesRendererDetails.seriesType) {
      case 'line':
        customPainter = LineChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as LineSeriesRenderer,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'spline':
        customPainter = SplineChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as SplineSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'column':
        customPainter = ColumnChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as ColumnSeriesRenderer,
            isRepaint: !(_stateProperties.zoomedState != null) ||
                _stateProperties.zoomedAxisRendererStates.isNotEmpty,
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;

      case 'scatter':
        customPainter = ScatterChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as ScatterSeriesRenderer,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stepline':
        customPainter = StepLineChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StepLineSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'area':
        customPainter = AreaChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as AreaSeriesRenderer,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'bubble':
        customPainter = BubbleChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as BubbleSeriesRenderer,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'bar':
        customPainter = BarChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as BarSeriesRenderer,
            isRepaint: ((_stateProperties.zoomedState != null) == false) ||
                _stateProperties.zoomedAxisRendererStates.isNotEmpty,
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'fastline':
        customPainter = FastLineChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as FastLineSeriesRenderer,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            painterKey: painterKey,
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'rangecolumn':
        customPainter = RangeColumnChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as RangeColumnSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'rangearea':
        customPainter = RangeAreaChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as RangeAreaSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'steparea':
        customPainter = StepAreaChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StepAreaSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'splinearea':
        customPainter = SplineAreaChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as SplineAreaSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'splinerangearea':
        customPainter = SplineRangeAreaChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as SplineRangeAreaSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedarea':
        customPainter = StackedAreaChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedAreaSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedbar':
        customPainter = StackedBarChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedBarSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedcolumn':
        customPainter = StackedColummnChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedColumnSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedline':
        customPainter = StackedLineChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedLineSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedarea100':
        customPainter = StackedArea100ChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedArea100SeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedbar100':
        customPainter = StackedBar100ChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedBar100SeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedcolumn100':
        customPainter = StackedColumn100ChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedColumn100SeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'stackedline100':
        customPainter = StackedLine100ChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as StackedLine100SeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'hilo':
        customPainter = HiloPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as HiloSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;

      case 'hiloopenclose':
        customPainter = HiloOpenClosePainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as HiloOpenCloseSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'candle':
        customPainter = CandlePainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as CandleSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'histogram':
        customPainter = HistogramChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as HistogramSeriesRenderer,
            chartSeries: _stateProperties.chartSeries,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'boxandwhisker':
        customPainter = BoxAndWhiskerPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as BoxAndWhiskerSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'waterfall':
        customPainter = WaterfallChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as WaterfallSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
      case 'errorbar':
        customPainter = ErrorBarChartPainter(
            stateProperties: _stateProperties,
            seriesRenderer: seriesRenderer as ErrorBarSeriesRenderer,
            painterKey: painterKey,
            isRepaint: _stateProperties.zoomedState != null
                ? _stateProperties.zoomedAxisRendererStates.isNotEmpty
                : (_stateProperties.legendToggling ||
                    seriesRendererDetails.needsRepaint == true),
            animationController: controller,
            notifier: seriesRendererDetails.repaintNotifier);
        break;
    }
    return customPainter!;
  }
}
