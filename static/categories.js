function mostrarDescripcion(nombreCategoria) {
  var descripcion = document.getElementById('descripcion-' + nombreCategoria);
  if (descripcion.style.display === 'none') {
    descripcion.style.display = 'block';
  } else {
    descripcion.style.display = 'none';
  }
}
