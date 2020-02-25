/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Grafica extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Grafica(this.seriesList, {this.animate});

  factory Grafica.withSampleData() {
    return new Grafica(
      _createSampleData(), 
      animate: false);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.NumericComboChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true,radiusPx: 6),
      behaviors: [
        new charts.SeriesLegend(),
      ],
      customSeriesRenderers: [
        new charts.PointRendererConfig(
          customRendererId: 'customPoint'
        )
      ],
    );
  }

  static List<charts.Series<PuntosSolucion, num>> _createSampleData() {
    final restriccion1 = [
      new PuntosSolucion(0, 18),
      new PuntosSolucion(4, 5),
      new PuntosSolucion(5, 3),
      new PuntosSolucion(6, 0),
    ];

    final restriccion2 = [
      new PuntosSolucion(0, 8),
      new PuntosSolucion(2, 6),
      new PuntosSolucion(5, 3),
      new PuntosSolucion(8, 0),
    ];

    final restriccion3 = [
      new PuntosSolucion(0, 7),
      new PuntosSolucion(2, 6),
      new PuntosSolucion(4, 5),
      new PuntosSolucion(14, 0),
    ];

    return [
      new charts.Series<PuntosSolucion, num>(
        id: 'Restriccion 1',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PuntosSolucion punto, _) => punto.x,
        measureFn: (PuntosSolucion punto, _) => punto.y,
        data: restriccion1,
      ),
      
      new charts.Series<PuntosSolucion, num>(
        id: 'Restriccion 1',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (PuntosSolucion punto, _) => punto.x,
        measureFn: (PuntosSolucion punto, _) => punto.y,
        data: restriccion2
      ),

      new charts.Series<PuntosSolucion, num>(
        id: 'Restriccion 1',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (PuntosSolucion punto, _) => punto.x,
        measureFn: (PuntosSolucion punto, _) => punto.y,
        data: restriccion3,
      ),
    ];
  }
}

class PuntosSolucion {
  num x;
  num y;

  PuntosSolucion(this.x, this.y);
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

/*static List<charts.Series<PuntosSolucion, num>> _createSampleData() {
    final restriccion1 = [
      new PuntosSolucion(0, 18),
      new PuntosSolucion(4, 5),
      new PuntosSolucion(5, 3),
      new PuntosSolucion(6, 0),
    ];

    final restriccion2 = [
      new PuntosSolucion(0, 8),
      new PuntosSolucion(2, 6),
      new PuntosSolucion(5, 3),
      new PuntosSolucion(8, 0),
    ];

    final restriccion3 = [
      new PuntosSolucion(0, 7),
      new PuntosSolucion(2, 6),
      new PuntosSolucion(4, 5),
      new PuntosSolucion(14, 0),
    ];

    return [
      new charts.Series<PuntosSolucion, num>(
        id: 'Restriccion 1',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PuntosSolucion punto, _) => punto.x,
        measureFn: (PuntosSolucion punto, _) => punto.y,
        data: restriccion1,
      ),
      
      new charts.Series<PuntosSolucion, num>(
        id: 'Restriccion 1',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (PuntosSolucion punto, _) => punto.x,
        measureFn: (PuntosSolucion punto, _) => punto.y,
        data: restriccion2)..setAttribute(charts.rendererIdKey, 'customPoint'
      ),

      new charts.Series<PuntosSolucion, num>(
        id: 'Restriccion 1',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (PuntosSolucion punto, _) => punto.x,
        measureFn: (PuntosSolucion punto, _) => punto.y,
        data: restriccion3,
      ),
    ];
  }
  
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final desktopSalesData = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    final tableSalesData = [
      new LinearSales(0, 10),
      new LinearSales(1, 50),
      new LinearSales(2, 200),
      new LinearSales(3, 150),
    ];

    final mobileSalesData = [
      new LinearSales(0, 10),
      new LinearSales(1, 50),
      new LinearSales(2, 200),
      new LinearSales(3, 150),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: tableSalesData
      ),
      new charts.Series<LinearSales, int>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }*/