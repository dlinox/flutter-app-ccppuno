class Pago {
  final int id;
  final String fecha;
  final bool estado;
  final String concepto;
  final double precio;
  final String numvoucher;
  final double importe;
  final String fechaPago;
  final String imagen;
  final String? cuotasAnio;
  final List<String>? cuotas;

  Pago({
    required this.id,
    required this.fecha,
    required this.estado,
    required this.concepto,
    required this.precio,
    required this.numvoucher,
    required this.importe,
    required this.fechaPago,
    required this.imagen,
    this.cuotasAnio,
    this.cuotas,
  });
}

class PagoResponse {
  final List<Pago> pagos;
  final int page;
  final int total;
  final int lastPage;
  final String? nextPageUrl;
  final String? prevPageUrl;

  PagoResponse({
    required this.page,
    required this.pagos,
    required this.total,
    required this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });
}
