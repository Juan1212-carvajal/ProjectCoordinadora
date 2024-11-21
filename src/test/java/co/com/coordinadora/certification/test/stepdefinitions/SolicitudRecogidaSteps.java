package co.com.coordinadora.certification.test.stepdefinitions;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.rest.SerenityRest;
import org.junit.Assert;

import java.util.Map;

public class SolicitudRecogidaSteps {

    private String url = "https://apiv2-test.coordinadora.com/recogidas/cm-solicitud-recogidas-ms/solicitud-recogida";
    private String requestBody;
    private String dateCollection;

    @Given("el usuario desea hacer una solicitud de recogida")
    public void el_usuario_desea_hacer_una_solicitud_de_recogida() {
        System.out.println("Usuario listo para hacer una solicitud");
    }

    @When("el usuario ingresa la fecha de recogida {string}")
    public void elUsuarioIngresaLaFechaDeRecogida(String fecha) {
        this.dateCollection = fecha;
    }


    @And("el usuario ingresa los siguientes datos:")
    public void elUsuarioIngresaLosSiguientesDatos(DataTable dataTable) {
        Map<String, String> datos = dataTable.asMap(String.class, String.class);
        this.requestBody = "{\n" +
                "  \"tipoEnvio\": \"" + datos.get("tipoEnvio") + "\",\n" +
                "  \"tipoProducto\": \"" + datos.get("tipoProducto") + "\",\n" +
                "  \"indicativo\": \"" + datos.get("indicativo") + "\",\n" +
                "  \"tipoDocumento\": \"" + datos.get("tipoDocumento") + "\",\n" +
                "  \"email\": \"" + datos.get("email") + "\",\n" +
                "  \"personaEntrega\": \"" + datos.get("personaEntrega") + "\",\n" +
                "  \"indicativoEntrega\": \"" + datos.get("indicativoEntrega") + "\",\n" +
                "  \"medidasAproximadas\": [{\n" +
                "    \"id\": 3,\n" +
                "    \"tipoPaq\": \"Caja mediana\",\n" +
                "    \"nombrePaq\": \"Caja de herramientas\",\n" +
                "    \"cantidad\": 2\n" +
                "  }],\n" +
                "  \"ciudad\": \"" + datos.get("ciudad") + "\",\n" +
                "  \"via\": \"" + datos.get("via") + "\",\n" +
                "  \"numero\": \"" + datos.get("numero") + "\",\n" +
                "  \"detalle\": \"" + datos.get("detalle") + "\",\n" +
                "  \"tipoVia\": " + datos.get("tipoVia") + ",\n" +
                "  \"nombres\": \"" + datos.get("nombres") + "\",\n" +
                "  \"apellidos\": \"" + datos.get("apellidos") + "\",\n" +
                "  \"documento\": \"" + datos.get("documento") + "\",\n" +
                "  \"celular\": \"" + datos.get("celular") + "\",\n" +
                "  \"ciudadDetalle\": {\n" +
                "    \"nombre_terminal_operativa\": \"" + datos.get("ciudadDetalle.nombre_terminal") + "\",\n" +
                "    \"tipo_servicio\": \"A\",\n" +
                "    \"dane_ciudad\": \"11001\",\n" +
                "    \"dane_actual\": \"11001000\",\n" +
                "    \"ciudad_tarifa\": \"11001000\",\n" +
                "    \"sms\": true,\n" +
                "    \"cubre_mqp\": true,\n" +
                "    \"codigo_postal\": \"110111\",\n" +
                "    \"terminal_operativa\": 1,\n" +
                "    \"cubre_me\": true,\n" +
                "    \"area_telefono\": 1,\n" +
                "    \"observaciones2\": \"\",\n" +
                "    \"codigo\": \"11001000\",\n" +
                "    \"tipo_poblacion\": \"U\",\n" +
                "    \"activo\": true,\n" +
                "    \"codigo_terminal\": 1,\n" +
                "    \"codigo_interno\": 101,\n" +
                "    \"mensajeria\": true,\n" +
                "    \"cubre_mm\": true,\n" +
                "    \"departamento\": \"11\",\n" +
                "    \"cubre_cm\": true,\n" +
                "    \"nombre\": \"" + datos.get("ciudadDetalle.nombre") + "\",\n" +
                "    \"abreviado\": \"BOG\",\n" +
                "    \"nombre_terminal\": \"" + datos.get("ciudadDetalle.nombre_terminal") + "\",\n" +
                "    \"observaciones\": \"\"\n" +
                "  },\n" +
                "  \"direccion\": \"" + datos.get("direccion") + "\",\n" +
                "  \"fechaRecogida\": \"" + this.dateCollection + "\",\n" +
                "  \"nombreEntrega\": \"" + datos.get("nombreEntrega") + "\",\n" +
                "  \"apellidosEntrega\": \"" + datos.get("apellidosEntrega") + "\",\n" +
                "  \"celularEntrega\": \"" + datos.get("celularEntrega") + "\",\n" +
                "  \"emailUsuario\": \"" + datos.get("emailUsuario") + "\",\n" +
                "  \"descripcionTipoVia\": \"" + datos.get("descripcionTipoVia") + "\",\n" +
                "  \"aplicativo\": \"" + datos.get("aplicativo") + "\"\n" +
                "}";

        //Envio Request
        SerenityRest.given()
                .contentType("application/json")
                .body(requestBody)
                .post(url);
    }

    @Then("el sistema debe aceptar la solicitud y devolver un codigo {int}")
    public void elSistemaDebeAceptarLaSolicitudYDevolverUnCodigo(int codeExpected) {
        int codigoRespuesta = SerenityRest.lastResponse().getStatusCode();
        Assert.assertEquals("El código de respuesta no es el esperado", codeExpected, codigoRespuesta);
        System.out.println(codigoRespuesta);

    }

    @And("el mensaje de la respuesta debe ser {string}")
    public void elMensajeDeLaRespuestaDebeSer(String expectedMessage) {
        System.out.println(SerenityRest.lastResponse().getBody().asString());
        String actualMessage = SerenityRest.lastResponse().jsonPath().getString("data.id_recogida.message");
        Assert.assertEquals("El mensaje de la respuesta no coincide", expectedMessage, actualMessage);
    }


    @Then("el sistema debe rechazar la solicitud y mostrar diferente mensaje {string}")
    public void elSistemaDebeRechazarLaSolicitudYMostrarDiferenteMensaje(String mensajeEsperado) {

        SerenityRest.lastResponse();
        boolean isError = SerenityRest.lastResponse()
                .jsonPath()
                .getBoolean("isError");
        Assert.assertTrue("La respuesta no indica un error", isError);

        // Validar el mensaje
        String mensajeReal = SerenityRest.lastResponse()
                .jsonPath()
                .getString("data.message");
        Assert.assertEquals("El mensaje de error no coincide", mensajeEsperado, mensajeReal);

    }

    @And("el sistema debe rechazar la solicitud y mostrar un mensaje {string}")
    public void elSistemaDebeRechazarLaSolicitudYMostrarUnMensaje(String mensajeEsperado) {
        String actualMessage = SerenityRest.lastResponse()
                .jsonPath()
                .getString("data.message");
        // Validar que el mensaje de la respuesta coincida con el esperado
        Assert.assertEquals("El mensaje de error no coincide", mensajeEsperado, actualMessage);
    }

}
