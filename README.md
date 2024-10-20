# RickAndMortyApp

Zara Tech Tests / Nazareth Villalba

La aplicación sigue el patrón arquitectónico VIPER para la gestión de la logica de la aplicacion y la interacción con el servicio de API.

## Estructura de la Aplicación

El proyecto consta de tres pantallas principales:

1. HomeViewController: Pantalla principal con un campo de búsqueda para personajes.
2. ListViewController: Listado de personajes, implementado con una **UICollectionView**.
3. DetailViewController: Vista detallada del personaje seleccionado, implementada con **Auto Layout**.
4. CharacterCellView: Vista de la celda para el listado de los personajes seleccionados, implementada **SwiftUI**.

## Arquitectura

El patrón **VIPER** divide la aplicación en cinco capas:
- **View**: Responsable de la UI y el input del usuario (UIViewController).
- **Interactor**: Contiene la lógica de negocio independiente de la UI.
- **Presenter**: Provee los datos de la UI al View y responde a las acciones del usuario desde el View.
- **Entity**: Modelos de datos.
- **Router**: Gestiona la navegación entre pantallas.

## Funcionalidades

- Búsqueda de personajes por nombre.
- Paginación de resultados.
- Vista de detalle del personaje seleccionado.
- Gestión de errores personalizada con **RxSwift**.

## Tecnologías Utilizadas

- **RxSwift** / **RxCocoa**: Programación reactiva para la interacción entre capas y para manejar respuestas asíncronas.
- **Alamofire**: Manejo de peticiones HTTP.
- **SDWebImage**: Carga y almacenamiento en caché de imágenes.
- **SwiftUI**: Detalles de la interfaz de usuario para la pantalla de detalle.
- **VIPER**: Patrón arquitectónico para la separación de responsabilidades.
  
## Pruebas

Se han implementado pruebas unitarias para las capas del Interactor y Presenter, utilizando RxTest para la simulación de eventos de RxSwift.

Las pruebas cubren:
- Manejo de la capa de interactor y presenter con la API.
- Pruebas de integración con mocks para verificar el correcto funcionamiento de los flujos VIPER.
