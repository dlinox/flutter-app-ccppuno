import 'package:ccp_puno_flutter/features/pagos/domain/domain.dart';

class PagoMapper {
  static jsonToEntity(Map<String, dynamic> json) => Pago(
        id: json['id'],
        fecha: json['fecha'],
        estado: json['estado'],
        concepto: json['concepto'],
        precio: double.parse(json['precio'].toString()),
        numvoucher: json['numvoucher'],
        importe: double.parse(json['importe'].toString()),
        fechaPago: json['fecha_pago'],
        imagen: json['imagen'],
        cuotasAnio: json['cuotasAnio'],
        cuotas: json['cuotas'] != null ? List<String>.from(json['cuotas']) : [],
      );
}

class PagoResponseMapper {
  static jsonToEntity(Map<String, dynamic> json) => PagoResponse(
        pagos: List<Pago>.from(
            json["data"].map((x) => PagoMapper.jsonToEntity(x))),
        page: json['current_page'],
        total: json['total'],
        lastPage: json['last_page'],
        nextPageUrl: json['next_page_url'],
        prevPageUrl: json['prev_page_url'],
      );
}
