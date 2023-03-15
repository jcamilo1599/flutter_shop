# Tienda

Aplicación de tienda desarrollada en Flutter. Actualmente no consume servicios y los datos/productos son estáticos. El filtro/buscador siempre retornará los mismos 2 productos debido a que los datos son estáticos y que lo ideal sería realizar el filtro en el backend.

# Especificaciones

- Desarrollado con Flutter 3.7.7 y Dart 2.19.4.
- Se implemento Flutter Lints, con configuraciones personalizadas que se pueden revisar en el
  archivo ``analysis_options.yaml``.
- Como patrón de diseño principal se implementó arquitectura limpia. En la capa ``ui`` se implementó
  el patrón "atomic design" (diseño atómico); adicionalmente para un correcto uso de la arquitectura
  limpia se utiliza inyección de dependencias.

# Autenticación

La aplicación no cuenta con un servicio de autenticación con credenciales, simplemente una vez de
presione el icono de usuario en la parte superior izquierda, se abrirá un modal en el cual se
presiona el botón "Iniciar sesión" y se creará una sesión local.

# Dependencias

- http (consumo de api)
- flutter_riverpod (manejador de estados)
- shared_preferences (persistencia de datos)
- json_annotation (mapeo de datos)
- json_serializable (mapeo de datos)
- carousel_slider (carrusel con imagenes de productos)
- top_snackbar_flutter (para mostrar alertas)
- badge (para mostrar números en la parte superior del carrito de compras)
- email_validator (validación de correo electrónico)
