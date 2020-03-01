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
    // Puntos solución de la restricción 1 de ejemplo
    final restriccion1 = [
      new PuntoSolucion(0, 18),
      new PuntoSolucion(4, 5, solucion: 35),
      new PuntoSolucion(5, 3, solucion: 34),
      new PuntoSolucion(6, 0, solucion: 30),
    ];

    // Puntos solución de la restricción 2 de ejemplo
    final restriccion2 = [
      new PuntoSolucion(0, 8),
      new PuntoSolucion(2, 6, solucion: 28),
      new PuntoSolucion(5, 3, solucion: 34),
      new PuntoSolucion(8, 0),
    ];
    
    // Puntos solución de la restricción 2 de ejemplo
    final restriccion3 = [
      new PuntoSolucion(0, 7, solucion: 21),
      new PuntoSolucion(2, 6, solucion: 28),
      new PuntoSolucion(4, 5, solucion: 35),
      new PuntoSolucion(14, 0),
    ];

    return [
      // Linea o penidente de la restricción 1 generada por sus puntos
      new charts.Series<PuntoSolucion, num>(
        id: 'Restriccion 1',
        domainFn: (PuntoSolucion sales, _) => sales.x, // Establese el eje X
        measureFn: (PuntoSolucion sales, _) => sales.y, // Establece el eje y
        data: restriccion1, // Establece el arreblo restricción 1 como el arreglo de datos para la linea
      ),

      // Linea o penidente de la restricción 2 generada por sus puntos
      new charts.Series<PuntoSolucion, num>(
        id: 'Restriccion 2',
        domainFn: (PuntoSolucion sales, _) => sales.x, // Establece el eje x
        measureFn: (PuntoSolucion sales, _) => sales.y, // Establece el eje y
        data: restriccion2, // Establece el arreblo restricción 2 como el arreglo de datos para la linea
      ),

      // Linea o penidente de la restricción 2 generada por sus puntos
      new charts.Series<PuntoSolucion, num>(
        id: 'Restriccion 3',
        domainFn: (PuntoSolucion punto, _) => punto.x, // Establece el eje x
        measureFn: (PuntoSolucion punto, _) => punto.y, // Establece el eje y
        //domainLowerBoundFn: (PuntoSolucion punto, _) => punto.solucion,
        data: restriccion3 // Establece el arreblo restricción 2 como el arreglo de datos para la linea
      )
    ];
  }
}

class _GraficaState extends State<Grafica> {
  num _sol;
  Map<num, num> _measures;

  // Este método se manda a llamar cada que seleccionamos un punto en la grafica
  _onSelectionChanged(charts.SelectionModel model) {
    // Datos del punto
    final selectedDatum = model.selectedDatum;

    // Guardarmos el valor de la coordeada x del punto
    num x;
    final measures = <num, num>{};

    if (selectedDatum.isNotEmpty) {
      // Obtenemos y almacenamos para la imprecion el valor de la coordenada x del punto
      x = selectedDatum.first.datum.x;

      // Obetnemos la coordenada y del punto
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.datum.x] = datumPair.datum.y;
      });
    }

    // Obtenemos el valor de la solución del punto
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

  // Imprimimos la solución del punto
    if (_sol != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(
            "Solución: " + _sol.toString(),
            style: TextStyle(fontSize: 22),
          )));
    }

    // Imprimimos el par ordenado
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