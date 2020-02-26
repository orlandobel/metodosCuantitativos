/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:metodo_grafico/classes/Funcion.dart';


class Grafica extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Grafica(this.seriesList, {this.animate, List<Funcion> funciones});

  factory Grafica.withSampleData() {
    return new Grafica(_createSampleData(), animate: false);
  }

  @override
  State<StatefulWidget> createState() => new _GraficaState();

  static List<charts.Series<PuntoSolucion, num>> _createSampleData() {
    final restriccion1 = [
      new PuntoSolucion(0, 18),
      new PuntoSolucion(4, 5, solucion: 35),
      new PuntoSolucion(5, 3, solucion: 34),
      new PuntoSolucion(6, 0, solucion: 30),
    ];

    final restriccion2 = [
      new PuntoSolucion(0, 8),
      new PuntoSolucion(2, 6, solucion: 28),
      new PuntoSolucion(5, 3, solucion: 34),
      new PuntoSolucion(8, 0),
    ];

    final restriccion3 = [
      new PuntoSolucion(0, 7, solucion: 21),
      new PuntoSolucion(2, 6, solucion: 28),
      new PuntoSolucion(4, 5, solucion: 35),
      new PuntoSolucion(14, 0),
    ];

    return [
      new charts.Series<PuntoSolucion, num>(
        id: 'Restriccion 1',
        domainFn: (PuntoSolucion sales, _) => sales.x,
        measureFn: (PuntoSolucion sales, _) => sales.y,
        data: restriccion1,
      ),
      new charts.Series<PuntoSolucion, num>(
        id: 'Restriccion 2',
        domainFn: (PuntoSolucion sales, _) => sales.x,
        measureFn: (PuntoSolucion sales, _) => sales.y,
        data: restriccion2,
      ),
      new charts.Series<PuntoSolucion, num>(
          id: 'Restriccion 3',
          domainFn: (PuntoSolucion punto, _) => punto.x,
          measureFn: (PuntoSolucion punto, _) => punto.y,
          domainLowerBoundFn: (PuntoSolucion punto, _) => punto.solucion,
          data: restriccion3)
    ];
  }
}

class _GraficaState extends State<Grafica> {
  num _sol;
  Map<num, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    num x;
    final measures = <num, num>{};

    if (selectedDatum.isNotEmpty) {
      x = selectedDatum.first.datum.x;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.datum.x] = datumPair.datum.y;
      });
    }

    setState(() {
      _sol = selectedDatum.first.datum.solucion;
      _measures = measures;
    });
  } 

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _height = _screenHeight*0.85;

    final children = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: new SizedBox(
          height: _height,
          child: new charts.LineChart(
            widget.seriesList,
            animate: widget.animate,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _onSelectionChanged,
              )
            ],
            defaultRenderer: charts.LineRendererConfig(
              includeArea: true,
              includePoints: true,
              radiusPx: 5,
            ),
            animationDuration: Duration.zero,
          ),
        ),
      ),
    ];

    if (_sol != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(
            "Solución: " + _sol.toString(),
            style: TextStyle(fontSize: 22),
          )));
    }

    _measures?.forEach((num series, num value) {
      children.add(new Text(
        '(${series},${value})',
        style: TextStyle(fontSize: 22),
      ));
    });

    return Scaffold(
      body: Column(children: children),
    );
  }
}

class PuntoSolucion {
  final num x;
  final num y;
  final num solucion;

  PuntoSolucion(this.x, this.y, {this.solucion});
}