/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:metodo_grafico/classes/Funcion.dart';

class Grafica extends StatefulWidget {
  List<charts.Series> seriesList = List<charts.Series<PuntoSolucion, num>>();
  final bool animate;

  Grafica(List<Funcion> funciones, {this.animate}) {
    // ontador de restricciones para el id de cada restricción
    int cont = 1;

    // Cremos las series que se graficarán
    for (var f in funciones) {
      // Lista que se usara para la creación de las series
      List<PuntoSolucion> restriccion = List<PuntoSolucion>();
      for (int i = 0; i < f.x.length; i++) {
        // Extracción de las cordenadas y soluciones de cada funión de restrdicción
        num x = f.x[i];
        num y = f.y[i];
        num s = f.solucion[i];

        // Creamos los puntos para las series
        PuntoSolucion p = PuntoSolucion(x, y, solucion: s);

        // Añadimos los puntos a las series
        restriccion.add(p);
      }

      // Añadimos las series a las gráficas
      seriesList.add(
          // Creación de las series
          charts.Series<PuntoSolucion, num>(
        id: 'Restriccion ${cont}',
        domainFn: (PuntoSolucion sales, _) => sales.x, // Establece el eje x
        measureFn: (PuntoSolucion sales, _) => sales.y, // Establece el eje y
        data:
            restriccion, // Establece el arreblo restricción como el arreglo de datos para la serie
      ));

      cont++;
    }
  }

  @override
  State<StatefulWidget> createState() => new _GraficaState();
}

class _GraficaState extends State<Grafica> {
  // variables para la selección de puntos y su respectiva impresion de coordenadas y solución
  num _sol;
  Map<num, num> _measures;
  Widget lineChart = Text("Cargando...");
  var render;

  // Este método se manda a llamar cada que seleccionamos un punto en la grafica
  _onSelectionChanged(charts.SelectionModel model) {
    // Datos del punto
    final selectedDatum = model.selectedDatum;

    final measures = <num, num>{};

    if (selectedDatum.isNotEmpty) {
      // Extraemos el par ordenado seleccionado
      charts.SeriesDatum dtm = selectedDatum[0];

      // Obtenemos los valores del par ordena
      measures[dtm.datum.x] = dtm.datum.y;
    }

    setState(() {
      // Obtenemos el valor de la solución del punto para imprimir
      _sol = selectedDatum.first.datum.solucion;
      // Almacenamos las coordenadas para imprimirlas
      _measures = measures;
      render = charts.LineRendererConfig(
        includeArea: true,
        includePoints: true,
        radiusPx: 5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _height = _screenHeight * 0.85;

    lineChart = charts.LineChart(
      widget.seriesList,
      animate: widget.animate,
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      /*defaultRenderer: charts.LineRendererConfig(
              includeArea: true,
              includePoints: true,
              radiusPx: 5,
            ),*/
    );
    final children = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: new SizedBox(
          height: _height,
          child: lineChart,
        ),
      ),
    ];

    // Imprimimos la solución del punto
    if (_sol != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(
            "Solución: " + _sol.toStringAsFixed(2),
            style: TextStyle(fontSize: 22),
          )));
    }

    // Imprimimos el par ordenado
    _measures?.forEach((num series, num value) {
      children.add(new Text(
        '(${series.toStringAsFixed(2)},${value.toStringAsFixed(2)})',
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
