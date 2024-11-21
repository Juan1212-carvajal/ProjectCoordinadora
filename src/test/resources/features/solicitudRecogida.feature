Feature: Solicitud de recogida de productos

  Background:
    Given el usuario desea hacer una solicitud de recogida

  @Scenario1:
  Scenario: Solicitud de recogida con datos validos
    When el usuario ingresa la fecha de recogida "2024-11-27"
    And el usuario ingresa los siguientes datos:
      | campo                         | valor                        |
      | tipoEnvio                     | 1                            |
      | tipoProducto                  | 4                            |
      | indicativo                    | 57                           |
      | tipoDocumento                 | 13                           |
      | email                         | juan.carvajal@email.com      |
      | personaEntrega                | 1                            |
      | indicativoEntrega             | 57                           |
      | ciudad                        | Bogota (DC)                  |
      | detalle                       | Calle 27 # 45-50 Oficina 101 |
      | tipoVia                       | 12                           |
      | nombres                       | Juan                         |
      | apellidos                     | Carvajal                     |
      | documento                     | 1012345611                   |
      | celular                       | 3101234562                   |
      | ciudadDetalle.nombre_terminal | Bogota                       |
      | direccion                     | Cra 15 # 45-32               |
      | nombreEntrega                 | Juan                         |
      | apellidosEntrega              | Carvajal                     |
      | celularEntrega                | 3101234562                   |
      | emailUsuario                  | juan.carvajal@email.com      |
      | descripcionTipoVia            | Carrera                      |
      | aplicativo                    | envios                       |
    Then el sistema debe aceptar la solicitud y devolver un codigo 200
    And el mensaje de la respuesta debe ser "Solicitud recogida programada exitosamente"

  @Scenario2:
  Scenario: Solicitud de recogida con fecha invalida (pasada)
    And el usuario ingresa los siguientes datos:
      | campo                         | valor                        |
      | tipoEnvio                     | 1                            |
      | tipoProducto                  | 4                            |
      | indicativo                    | 57                           |
      | tipoDocumento                 | 13                           |
      | email                         | juan.perez@example.com       |
      | personaEntrega                | 1                            |
      | indicativoEntrega             | 57                           |
      | ciudad                        | Bogota (DC)                  |
      | detalle                       | Calle 26 # 45-50 Oficina 101 |
      | tipoVia                       | 12                           |
      | nombres                       | Juan                         |
      | apellidos                     | Perez                        |
      | documento                     | 1012345678                   |
      | celular                       | 3101234567                   |
      | ciudadDetalle.nombre_terminal | Bogota                       |
      | direccion                     | Cra 15 # 45-32               |
      | nombreEntrega                 | Juan                         |
      | apellidosEntrega              | Carvajal                     |
      | celularEntrega                | 3101234561                   |
      | emailUsuario                  | juan.carvajal@email.com      |
      | descripcionTipoVia            | Carrera                      |
      | aplicativo                    | envios                       |
    Then el sistema debe rechazar la solicitud y mostrar diferente mensaje "El campo fecha debe ser diferente de vacio y debe tener un formato valido."

  @Scenario3:
  Scenario: Solicitud duplicada
    When el usuario ingresa la fecha de recogida "2024-11-26"
    And el usuario ingresa los siguientes datos:
      | campo                         | valor                        |
      | tipoEnvio                     | 1                            |
      | tipoProducto                  | 4                            |
      | indicativo                    | 57                           |
      | tipoDocumento                 | 13                           |
      | email                         | juan.carvajal@email.com      |
      | personaEntrega                | 1                            |
      | indicativoEntrega             | 57                           |
      | ciudad                        | Bogota (DC)                  |
      | detalle                       | Calle 26 # 45-50 Oficina 101 |
      | tipoVia                       | 12                           |
      | nombres                       | Juan                         |
      | apellidos                     | Carvajal                     |
      | documento                     | 1012345679                   |
      | celular                       | 3101234562                   |
      | ciudadDetalle.nombre_terminal | Bogota                       |
      | direccion                     | Cra 15 # 45-32               |
      | nombreEntrega                 | Juan                         |
      | apellidosEntrega              | Carvajal                     |
      | celularEntrega                | 3101234561                   |
      | emailUsuario                  | juan.carvajal@email.com      |
      | descripcionTipoVia            | Carrera                      |
      | aplicativo                    | envios                       |
    And el sistema debe rechazar la solicitud y mostrar un mensaje "Error, Ya existe una recogida programada para hoy, id: 26785606"
