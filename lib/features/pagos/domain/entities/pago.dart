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
