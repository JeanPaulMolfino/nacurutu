<template>
  <div id="container">
    <div class="contentContainerContainer">
      <div class="contentContainer">
        <div v-for="(alerta, index) in sensoresEnAlerta" :key="index">
          <b-alert
            v-model="showDismissibleAlert[alerta.identificador]"
            variant="danger"
            dismissible
            style="overflow: hidden"
          >
            {{ alerta.identificador }}
            <iframe
              src="https://s3-eu-west-1.amazonaws.com/omegasquadron.neilbryson.net/silence.mp3"
              allow="autoplay"
              id="audio"
              style="position: absolute; z-index: -999"
            ></iframe>
            <audio
              ref="player"
              controls
              autoplay
              style="position: absolute; z-index: -999"
            >
              <source
                src="http://soundbible.com/mp3/sms-alert-4-daniel_simon.mp3"
              />
              Your browser does not support the audio element.
            </audio>
          </b-alert>
        </div>

        <div class="nav nav-pills nav-justified">
          <div
            @click="seleccionarFruta('dispositivos')"
            :class="[
              isActive('dispositivos')
                ? 'nav-item nav-link active'
                : 'nav-item nav-link',
            ]"
          >
            <p>Home</p>
          </div>
          <div
            v-for="(dispositivo, index) in frutas"
            :key="index"
            @click="seleccionarFruta(dispositivo.identificador)"
            :class="[
              isActive(dispositivo.identificador)
                ? 'nav-item nav-link active'
                : 'nav-item nav-link',
            ]"
          >
            <p>
              {{ dispositivo.categoria }} -
              {{ dispositivo.identificador }}
            </p>
            <button
              @click="eliminarTab(dispositivo)"
              type="button"
              class="deleteBtn"
            >
              <svg
                width="0.8em"
                height="0.8em"
                viewBox="0 0 16 16"
                class="bi bi-x-circle-fill"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293 5.354 4.646z"
                />
              </svg>
            </button>
          </div>
        </div>

        <div v-for="(dispositivo, index) in dispositivos" :key="index">
          <div v-if="dispositivo.identificador === tabSeleccionada">
            <div>
              <div class="descripcion">
                <p>
                  Actividad del dispositivo:
                  {{ dispositivo.actividad ? "Activo" : "Inactivo" }}
                </p>
                <p>
                  {{ dispositivo.categoria }} -
                  {{ dispositivo.identificador }}
                </p>
                <p>
                  Ultima actualización:
                  {{ dispositivo.ultima_actualizacion }}
                </p>
                <p>Sensores:</p>
                <div
                  v-for="(sensor, index) in sensores[dispositivo.identificador]"
                  :key="index"
                >
                  <p>
                    -
                    {{ sensor.nombre }}: {{ sensor.lectura }}
                    {{ sensor.unidadmedida }}
                  </p>
                </div>
              </div>

              <div>
                <b-form @submit="displayGrafica">
                  <b-form-group
                    id="input-group-6"
                    label="Sensor:"
                    label-for="input-6"
                  >
                    <!-- En options van los nombrs de los sensores -->
                    <b-form-select
                      id="input-2"
                      v-model="formGrafica.sensor"
                      :options="sensoresTabSeleccionada"
                      required
                    ></b-form-select>
                  </b-form-group>

                  <b-form-group
                    id="input-group-6"
                    label="Desde:"
                    label-for="input-6"
                  >
                    <b-calendar
                      id="input-6"
                      v-model="formGrafica.from"
                      block
                      @context="onContext"
                      locale="en-US"
                      selected-variant="success"
                      today-variant="info"
                      nav-button-variant="primary"
                    ></b-calendar>
                  </b-form-group>

                  <b-form-group
                    id="input-group-6"
                    label="Hasta:"
                    label-for="input-6"
                  >
                    <b-calendar
                      id="input-6"
                      v-model="formGrafica.to"
                      block
                      @context="onContext"
                      locale="en-US"
                      selected-variant="success"
                      today-variant="info"
                      nav-button-variant="primary"
                    ></b-calendar>
                  </b-form-group>

                  <b-button variant="primary" size="sm" type="submit"
                    >OK</b-button
                  >
                </b-form>

                <chartchooser
                  v-if="displayGraph"
                  :deviceIdentificator="dispositivo.identificador"
                  :sensorIdSecondary="sensorIdSecondaryChart.toString()"
                  :sensorGraphId="sensorGraphIdChart"
                  :dateFrom="formGrafica.from"
                  :dateTo="formGrafica.to"
                />
              </div>
            </div>
          </div>
        </div>
        <div>
          <div v-if="'dispositivos' === tabSeleccionada">
            <div>
              <div :class="[display === 'main' ? 'descripcion' : 'invisible']">
                <div
                  class="row"
                  style="justify-content: center; margin-bottom: 50px"
                >
                  <b-button
                    @click="makeDisplay('formulario')"
                    variant="outline-info"
                    size="lg"
                    :class="[display === 'main' ? '' : 'invisible']"
                    style="margin-right: 30px"
                  >
                    NUEVO DISPOSITIVO
                  </b-button>
                  <b-button
                    @click="makeDisplay('listCategorias')"
                    variant="outline-info"
                    size="lg"
                    :class="[display === 'main' ? '' : 'invisible']"
                    style="margin-left: 30px"
                  >
                    LISTAR CATEGORIAS
                  </b-button>
                </div>

                <div :class="[display === 'main' ? 'row' : 'invisible']">
                  <div
                    v-for="(dispositivo, index) in dispositivos"
                    :key="index"
                    class="col-md-3 col-6 my-1"
                  >
                    <div class="card h-100">
                      <div class="card-body" style="text-align: center">
                        <div class="card-title">
                          {{ dispositivo.identificador }}
                          <button
                            @click="anadirTab(dispositivo)"
                            class="addBtn"
                          >
                            <svg
                              width="1em"
                              height="1em"
                              viewBox="0 0 16 16"
                              class="bi bi-plus-circle-fill"
                              fill="currentColor"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                fill-rule="evenodd"
                                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"
                              />
                            </svg>
                          </button>
                        </div>
                        <div>
                          <span class="badge badge-pill badge-info">{{
                            dispositivo.categoria
                          }}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div
                :class="[
                  display === 'formulario' ? 'descripcion' : 'invisible',
                ]"
              >
                <div
                  :class="[display === 'formulario' ? '' : 'invisible']"
                  style="padding: 0 40px"
                >
                  <b-form @submit="checkForm" @reset="onReset">
                    <b-form-group
                      id="input-group-1"
                      label-cols="3"
                      label="Identificador del dispositivo:"
                      label-size="lg"
                      label-for="input-1"
                      style="margin-bottom: 10px"
                    >
                      <b-form-input
                        id="input-1"
                        v-model="form.identificador"
                        required
                        size="lg"
                        placeholder="Identificador"
                      ></b-form-input>
                    </b-form-group>

                    <b-form-group
                      id="input-group-3"
                      label-cols="3"
                      label-size="lg"
                      label="Categoria del dispositivo:"
                      label-for="input-2"
                      style="margin-bottom: 10px"
                    >
                      <b-form-select
                        id="input-2"
                        v-model="form.categoria"
                        size="lg"
                        :options="nombreCategorias"
                        required
                      ></b-form-select>
                    </b-form-group>

                    <b-form-group
                      id="input-group-3"
                      label-cols="3"
                      label-size="lg"
                      label="Marca del dispositivo:"
                      label-for="input-3"
                      style="margin-bottom: 10px"
                    >
                      <b-form-input
                        id="input-3"
                        v-model="form.marca"
                        required
                        size="lg"
                        placeholder="Marca"
                      ></b-form-input>
                    </b-form-group>

                    <b-form-group
                      id="input-group-4"
                      label-cols="3"
                      label-size="lg"
                      label="Modelo del dispositivo:"
                      label-for="input-4"
                      style="margin-bottom: 10px"
                    >
                      <b-form-input
                        id="input-4"
                        v-model="form.modelo"
                        required
                        size="lg"
                        placeholder="Modelo"
                      ></b-form-input>
                    </b-form-group>

                    <b-form-group
                      id="input-group-5"
                      label-cols="3"
                      label-size="lg"
                      label="Ubicacion del dispositivo:"
                      label-for="input-5"
                      style="margin-bottom: 10px"
                    >
                      <b-form-input
                        id="input-5"
                        size="lg"
                        v-model="form.ubicacion"
                        placeholder="Ubicacion"
                      ></b-form-input>
                    </b-form-group>

                    <b-form-group
                      id="input-group-6"
                      label-size="lg"
                      label-cols="3"
                      label="Fecha de alta del dispositivo:"
                      label-for="input-6"
                      style="margin-bottom: 10px"
                    >
                      <b-calendar
                        id="input-6"
                        v-model="form.fechaAlta"
                        block
                        size="lg"
                        @context="onContext"
                        locale="en-US"
                        selected-variant="success"
                        today-variant="info"
                        nav-button-variant="primary"
                      ></b-calendar>
                    </b-form-group>

                    <div
                      class="form-group row"
                      style="justify-content: center; margin-top: 30px"
                    >
                      <b-button
                        type="submit"
                        variant="outline-success"
                        size="lg"
                        >Enviar</b-button
                      >
                      <b-button
                        type="reset"
                        variant="outline-info"
                        size="lg"
                        style="margin: 0 30px"
                        >Resetear</b-button
                      >
                      <b-button
                        @click="makeDisplay('main')"
                        variant="outline-danger"
                        size="lg"
                        >Cancelar</b-button
                      >
                    </div>
                  </b-form>
                </div>
              </div>

              <div
                :class="[display === 'listCategorias' ? 'row' : 'invisible']"
                style="margin: 30px 5px; justify-content: center"
              >
                <b-col
                  v-for="(categoria, index) in categorias"
                  :key="index"
                  :class="[
                    display === 'listCategorias' ? 'card h-10' : 'invisible',
                  ]"
                  sm="3"
                  style="
                    font-size: 24px;
                    height: min-content;
                    min-height: 200px;
                    margin: 10px;
                  "
                >
                  <div class="card-body" style="text-align: center">
                    <div class="card-title">
                      {{ categoria.categoria }}
                      <span class="badge badge-pill badge-info">{{
                        categoria.proposito
                      }}</span>
                    </div>
                    <div>
                      <b-button
                        v-b-toggle="idCategoriaToggle(categoria.id)"
                        variant="primary"
                      >
                        Desplegar
                        {{ sensoresCategoria[categoria.id].length }}
                        sensores</b-button
                      >
                      <b-collapse
                        :id="idCategoriaToggle(categoria.id)"
                        class="mt-2"
                      >
                        <b-card>
                          <div
                            v-for="(sensor, index) in sensoresCategoria[
                              categoria.id
                            ]"
                            :key="index"
                            :class="[
                              display === 'listCategorias'
                                ? 'frutasDesechadas'
                                : 'invisible',
                            ]"
                          >
                            <b-button
                              @click="
                                makeDisplayEditarSensor(categoria.id, sensor)
                              "
                              variant="info"
                              block
                            >
                              <p class="card-text">
                                {{ sensor.nombre }} -
                                {{ sensor.unidadmedida }}
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  viewBox="0 0 24 24"
                                  fill="black"
                                  width="36px"
                                  height="36px"
                                >
                                  <path d="M0 0h24v24H0V0z" fill="none" />
                                  <path
                                    d="M3 17.46v3.04c0 .28.22.5.5.5h3.04c.13 0 .26-.05.35-.15L17.81 9.94l-3.75-3.75L3.15 17.1c-.1.1-.15.22-.15.36zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"
                                  />
                                </svg>
                              </p>
                            </b-button>
                          </div>
                          <b-button
                            @click="makeDisplayFormularioSensores(categoria.id)"
                            variant="outline-primary"
                            block
                          >
                            NUEVO SENSOR
                          </b-button>
                        </b-card>
                      </b-collapse>
                    </div>
                  </div>
                </b-col>
              </div>

              <div
                class="row"
                style="justify-content: center; margin-top: 30px"
              >
                <b-button
                  @click="makeDisplay('nuevaCategoria')"
                  :class="[display === 'listCategorias' ? '' : 'invisible']"
                  style="margin-right: 20px"
                  variant="outline-primary"
                >
                  NUEVA CATEGORIA
                </b-button>
                <b-button
                  @click="makeDisplay('main')"
                  :class="[display === 'listCategorias' ? '' : 'invisible']"
                  style="margin-left: 20px"
                  variant="outline-danger"
                  >ATRAS</b-button
                >
              </div>

              <div
                :class="[display === 'nuevaCategoria' ? '' : 'invisible']"
                style="padding: 0 40px"
              >
                <b-form @submit="checkFormCategoria" @reset="onResetCategoria">
                  <b-form-group
                    id="input-group-1"
                    label="Nombre de la categoria:"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label-cols="2"
                    label-for="input-1"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="formCategoria.categoria"
                      required
                      size="lg"
                      placeholder="Nombre categoria"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-3"
                    label-cols="2"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label="Proposito de la categoria:"
                    label-for="input-2"
                  >
                    <b-form-input
                      id="input-3"
                      required
                      size="lg"
                      v-model="formCategoria.proposito"
                      placeholder="Proposito"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label-cols="2"
                    style="margin-bottom: 10px"
                    label-size="lg"
                    label="Tiempo de actualziacion:"
                    label-for="input-3"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="formCategoria.updatetime"
                      type="number"
                      required
                      size="lg"
                      placeholder="Tiempo de actualziacion"
                    ></b-form-input>
                  </b-form-group>

                  <div
                    class="row"
                    style="justify-content: center; margin-top: 40px"
                  >
                    <b-button type="submit" variant="outline-primary"
                      >Crear</b-button
                    >
                    <b-button
                      type="reset"
                      variant="outline-secondary"
                      style="margin: 0 40px"
                      >Resetear</b-button
                    >
                    <b-button
                      @click="makeDisplay('listCategorias')"
                      variant="outline-danger"
                      >Cancelar</b-button
                    >
                  </div>
                </b-form>
              </div>

              <div
                :class="[display === 'formularioSensores' ? '' : 'invisible']"
                style="padding: 0 40px"
              >
                <h1 style="margin-bottom: 15px">
                  La categoria es: {{ formSensor.idCategoria }}
                </h1>
                <b-form @submit="checkFormSensor" @reset="onResetSensor">
                  <b-form-group
                    id="input-group-1"
                    label="Nombre el sensor:"
                    label-for="input-1"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label-cols="2"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="formSensor.nombre"
                      required
                      size="lg"
                      placeholder="Nombre sensor"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-3"
                    label="Unidad de medida:"
                    label-for="input-2"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label-cols="2"
                  >
                    <b-form-input
                      id="input-3"
                      required
                      size="lg"
                      v-model="formSensor.unidadmedida"
                      placeholder="Unidad de medida"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label="Minimo:"
                    label-for="input-3"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label-cols="2"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="formSensor.min"
                      type="number"
                      size="lg"
                      placeholder="Minimo"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label="Maximo:"
                    label-for="input-4"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label-cols="2"
                  >
                    <b-form-input
                      id="input-4"
                      v-model="formSensor.max"
                      type="number"
                      size="lg"
                      placeholder="Maximo"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-7"
                    label="Grafica:"
                    label-for="input-7"
                    label-size="lg"
                    style="margin-bottom: 10px"
                    label-cols="2"
                  >
                    <b-form-select
                      id="input-2"
                      size="lg"
                      v-model="formSensor.grafica"
                      :options="tiposDeGraficasNombre"
                      required
                    ></b-form-select>
                  </b-form-group>

                  <div
                    class="row"
                    style="justify-content: center; margin-top: 40px"
                  >
                    <b-button type="submit" variant="outline-primary"
                      >Crear</b-button
                    >
                    <b-button
                      type="reset"
                      variant="outline-secondary"
                      style="margin: 0 40px"
                      >Resetear</b-button
                    >
                    <b-button
                      @click="makeDisplay('listCategorias')"
                      variant="outline-danger"
                      >Cancelar</b-button
                    >
                  </div>
                </b-form>
              </div>

              <div
                :class="[
                  display === 'formularioEditarSensores' ? '' : 'invisible',
                ]"
              >
                <h1>
                  Edite los datos que corresponda y precione el boton ACEPTAR
                </h1>
                <b-form @submit="checkEditarSensor">
                  <b-form-group
                    id="input-group-1"
                    label="Nombre el sensor:"
                    label-for="input-1"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="updateSensor.nombre"
                      required
                      placeholder="Nombre sensor"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-3"
                    label="Unidad de medida:"
                    label-for="input-2"
                  >
                    <b-form-input
                      id="input-3"
                      required
                      v-model="updateSensor.unidadmedida"
                      placeholder="Unidad de medida"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label="Minimo:"
                    label-for="input-3"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="updateSensor.min"
                      type="number"
                      placeholder="Minimo"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label="Maximo:"
                    label-for="input-4"
                  >
                    <b-form-input
                      id="input-4"
                      v-model="updateSensor.max"
                      type="number"
                      placeholder="Maximo"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label="Grafica:"
                    label-for="input-5"
                  >
                    <b-form-input
                      id="input-5"
                      v-model="updateSensor.id_grafica"
                      required
                      placeholder="Grafica"
                    ></b-form-input>
                  </b-form-group>

                  <div class="form-group row">
                    <b-button type="submit" variant="primary">ACEPTAR</b-button>
                    <b-button
                      @click="makeDisplay('listCategorias')"
                      variant="danger"
                      >CANCELAR</b-button
                    >
                  </div>
                </b-form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import chartchooser from "./ChartChooser";

export default {
  expand: false,
  props: {},
  components: {
    chartchooser,
  },
  data() {
    return {
      loaded: false,
      dispositivos: [],
      sensores: { type: Object, default: null },
      sensoresCategoria: {},
      endpoint: "/endpoints/get:dispositivos",
      endpointSensores: "dispositivos/get:get_latestmedidasbydispositivo/",
      endpointCategorias: "tiposdispositivos/get:get_tiposdispositivos/",
      endpointCrearDispositivo: "dispositivos/post:insert_dispositivo/",
      endpointCrearCategoria: "tiposdispositivos/post:insert_tipodispositivo/",
      endpointSensoresPorCategoria: "sensores/get:get_sensoresbytipo/",
      endpointCrearSensor: "sensores/post:insert_sensore/",
      endpointUpdateSensor: "sensores/put:update_sensores/",
      endpointGraficas: "graficas/get:get_graficas/",
      endpointAlertas: "sensores/get:get_sensoresalerta/",
      titulo: "Testeo de Tabs",
      display: "main",
      frutas: [],
      categorias: {},
      nombreCategorias: [],
      tabSeleccionada: "dispositivos",
      frutasDesechadas: [],
      form: {
        categoria: "",
        identificador: "",
        marca: "",
        modelo: "",
        ubicacion: "",
        fechaAlta: "",
      },
      formCategoria: {
        categoria: "",
        proposito: "",
        updatetime: "",
      },
      formSensor: {
        idCategoria: "",
        unidadmedida: "",
        grafica: "",
        nombre: "",
        min: "",
        max: "",
      },
      updateSensor: {
        idCategoria: "",
        id: "",
        id_sensor_secundario: "",
        id_grafica: "",
        max: "",
        min: "",
        nombre: "",
        unidadmedida: "",
      },
      formGrafica: {
        from: "",
        to: "",
        sensor: "",
      },
      displayGraph: false,
      dateContext: null,
      sensorIdSecondaryChart: "",
      sensorGraphIdChart: "",
      sensoresTabSeleccionada: "",
      tiposDeGraficas: [],
      tiposDeGraficasNombre: [],
      showDismissibleAlert: {},
      sensoresEnAlerta: [],
    };
  },
  methods: {
    displayGrafica(e) {
      e.preventDefault();
      this.sensores[this.tabSeleccionada].map((sensor, index) => {
        if (sensor.nombre == this.formGrafica.sensor) {
          this.sensorIdSecondaryChart = sensor.secundario;
          this.sensorGraphIdChart = sensor.grafica;
        }
      });

      this.displayGraph = true;
    },
    idCategoriaToggle(id) {
      this.fetchSensoresPorCategoria(id);
      return "a" + id;
    },
    seleccionarFruta(fruta) {
      for (var i = 0; i < this.frutas.length; i++) {
        if (
          this.frutas[i].identificador === fruta ||
          fruta === "dispositivos"
        ) {
          this.tabSeleccionada = fruta;
          if (fruta != "dispositivos") {
            this.sensoresTabSeleccionada = this.sensores[
              this.tabSeleccionada
            ].map((nombreSensor, index) => {
              return nombreSensor.nombre;
            });
          }
        }
      }
    },
    isActive(fruta) {
      var resultado = fruta === this.tabSeleccionada;
      return resultado;
    },
    eliminarTab(fruta) {
      for (var i = 0; i < this.frutas.length; i++) {
        if (this.frutas[i] === fruta) {
          this.frutas.splice(i, 1);
        }
      }
      if (this.frutas.length === 0) {
        this.tabSeleccionada = "dispositivos";
      }
      console.log(this.tabSeleccionada);
    },
    anadirTab(dispositivo) {
      if (this.frutas.includes(dispositivo)) {
        this.tabSeleccionada = dispositivo.identificador;
      } else {
        this.frutas.push(dispositivo);
      }
      if (this.sensores[dispositivo.identificador] == null) {
        this.fetchSensores(dispositivo.identificador);
      }
    },
    makeDisplay(newDisplay) {
      this.display = newDisplay;
    },
    makeDisplayFormularioSensores(idCategoria) {
      this.formSensor.idCategoria = idCategoria;
      this.display = "formularioSensores";
    },
    makeDisplayEditarSensor(idCategoria, sensor) {
      this.updateSensor.id = sensor.id;
      this.updateSensor.id_sensor_secundario = sensor.id_sensor_secundario;
      this.updateSensor.idCategoria = idCategoria;
      this.updateSensor.id_grafica = sensor.id_grafica;
      this.updateSensor.max = sensor.max;
      this.updateSensor.min = sensor.min;
      this.updateSensor.nombre = sensor.nombre;
      this.updateSensor.unidadmedida = sensor.unidadmedida;
      this.display = "formularioEditarSensores";
    },
    onReset(evt) {
      this.form.categoria = "";
      this.form.identificador = "";
      this.form.categoria = "";
      this.form.marca = "";
      this.form.modelo = "";
      this.form.ubicacion = "";
      this.form.fechaAlta = "";
      this.formulario = false;
      this.$nextTick(() => {
        this.formulario = true;
      });
    },
    onResetCategoria(evt) {
      this.formCategoria.categoria = "";
      this.formCategoria.updatetime = "";
      this.formCategoria.proposito = "";
    },
    onResetSensor(evt) {
      this.formSensor.nombre = "";
      this.formSensor.max = "";
      this.formSensor.min = "";
      this.formSensor.grafica = "";
      this.formSensor.unidadmedida = "";
    },
    checkForm: function (e) {
      e.preventDefault();
      let errorIdentificador = false;
      this.dispositivos.map((dispositivo) => {
        if (dispositivo.identificador == this.form.identificador) {
          errorIdentificador = true;
        }
      });
      this.categorias.map((categoria) => {
        if (categoria.categoria == this.form.categoria) {
          this.form.categoria = categoria;
        }
      });
      if (!errorIdentificador) {
        this.sendDispositivo();
        console.log("Un exito muchachin");
        this.makeDisplay("main");
      } else {
        console.log("Malardo del mal ingresa bien las cosas");
      }
    },
    checkFormCategoria: function (e) {
      e.preventDefault();
      let errorCat = false;
      this.categorias.map((categoria) => {
        if (categoria.categoria == this.formCategoria.categoria) {
          errorCat = true;
        }
      });
      if (!errorCat) {
        this.sendCategoria();
        this.makeDisplay("listCategorias");
        this.onResetCategoria();
        console.log("Un exito muchachin");
      } else {
        console.log("Malardo del mal ingresa bien las cosas");
      }
    },
    checkFormSensor: function (e) {
      e.preventDefault();
      let errorNombre = false;
      this.sensoresCategoria[this.formSensor.idCategoria].map((sensor) => {
        if (sensor.nombre === this.formSensor.nombre) {
          errorNombre = true;
        }
      });
      if (!errorNombre) {
        this.formSensor.grafica = this.tiposDeGraficas.map((grafica) => {
          if (grafica.nombre === this.formSensor.grafica) {
            this.formSensor.grafica = grafica.id;
          }
        });
        this.sendSensor();
        this.makeDisplay("listCategorias");
        this.onResetSensor();
        console.log("Un exito muchachin");
      } else {
        console.log("Malardo del mal ingresa bien las cosas");
      }
    },
    checkEditarSensor: function (e) {
      e.preventDefault();
      let errorNombre = false;
      this.sensoresCategoria[this.updateSensor.idCategoria].map((sensor) => {
        if (sensor.nombre === this.updateSensor.nombre) {
          errorNombre = true;
        }
      });
      if (!errorNombre) {
        this.updapearSensor();
        this.makeDisplay("listCategorias");
        console.log("Un exito muchachin");
      } else {
        console.log("Malardo del mal ingresa bien las cosas");
      }
    },
    onContext(ctx) {
      this.dateContext = ctx;
    },
    async fetchCustom() {
      this.loaded = false;
      try {
        const response = await fetch(this.endpoint);
        const myJson = await response.json();
        this.dispositivos = myJson;
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    async fetchCategorias() {
      this.loaded = false;
      try {
        var auxCategorias = [];
        const response = await fetch(this.endpointCategorias);
        const myJson = await response.json();
        this.categorias = myJson;
        this.categorias.forEach((categoria) => {
          auxCategorias.push(categoria.categoria);
        });
        this.nombreCategorias = auxCategorias;
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    async fetchSensoresPorCategoria(idCategoria) {
      this.loaded = false;
      try {
        const response = await fetch(
          this.endpointSensoresPorCategoria + idCategoria
        );
        const myJson = await response.json();
        this.sensoresCategoria[idCategoria] = myJson;
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    async fetchSensores(dispositivo) {
      this.loaded = false;
      try {
        const response = await fetch(this.endpointSensores + dispositivo);
        const myJson = await response.json();
        this.sensores[dispositivo] = myJson;
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    async fetchGraficas() {
      var aux = [];
      this.loaded = false;
      try {
        const response = await fetch(this.endpointGraficas);
        const myJson = await response.json();
        this.tiposDeGraficas = myJson;
        this.tiposDeGraficas.forEach((grafica) => {
          aux.push(grafica.nombre);
        });
        this.tiposDeGraficasNombre = aux;
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    async sendDispositivo() {
      this.loaded = false;
      try {
        const response = await fetch(
          this.endpointCrearDispositivo +
            this.remplazar(this.form.ubicacion) +
            "/" +
            this.form.fechaAlta +
            "/" +
            this.form.categoria.id +
            "/" +
            this.remplazar(this.form.marca) +
            "/" +
            this.remplazar(this.form.modelo) +
            "/" +
            this.remplazar(this.form.identificador),
          {
            method: "POST",
            mode: "no-cors", // no-cors, *cors, same-origin
            cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
            credentials: "same-origin", // include, *same-origin, omit
            redirect: "follow", // manual, *follow, error
            referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
          }
        );
        console.log("Dispositivo creado... supuestamente");
        this.fetchCustom();
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    async sendCategoria() {
      this.loaded = false;
      try {
        const response = await fetch(
          this.endpointCrearCategoria +
            this.formCategoria.updatetime +
            "/" +
            this.remplazar(this.formCategoria.categoria) +
            "/" +
            this.remplazar(this.formCategoria.proposito),
          {
            method: "POST",
            mode: "no-cors", // no-cors, *cors, same-origin
            cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
            credentials: "same-origin", // include, *same-origin, omit
            redirect: "follow", // manual, *follow, error
            referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
          }
        );
        console.log("Categoria creada... supuestamente");
        this.fetchCategorias();
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
    getIdSecundario() {
      return this.sensoresCategoria[this.formSensor.idCategoria].length + 1;
    },
    getSensorMin() {
      return this.formSensor.min != "" ? this.formSensor.min : "null";
    },
    getSensorMax() {
      return this.formSensor.max != "" ? this.formSensor.max : "null";
    },
    getSensorUpdateMin() {
      return this.formSensor.min != "" ? this.formSensor.min : "null";
    },
    getSensorUpdateMax() {
      return this.formSensor.max != "" ? this.formSensor.max : "null";
    },
    async sendSensor() {
      this.loaded = false;
      try {
        const response = await fetch(
          this.endpointCrearSensor +
            this.formSensor.idCategoria +
            "/" +
            this.getIdSecundario() +
            "/" +
            this.remplazar(this.formSensor.unidadmedida) +
            "/" +
            this.formSensor.grafica +
            "/" +
            this.remplazar(this.formSensor.nombre) +
            "/" +
            this.getSensorMin() +
            "/" +
            this.getSensorMax(),
          {
            method: "POST",
            mode: "no-cors", // no-cors, *cors, same-origin
            cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
            credentials: "same-origin", // include, *same-origin, omit
            redirect: "follow", // manual, *follow, error
            referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
          }
        );
        console.log("Sensor creado... supuestamente");
        this.fetchSensoresPorCategoria(this.formSensor.idCategoria);
        this.fetchCategorias();
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },

    async updapearSensor() {
      this.loaded = false;
      try {
        const response = await fetch(
          this.endpointUpdateSensor +
            this.updateSensor.id +
            "/" +
            this.updateSensor.idCategoria +
            "/" +
            this.updateSensor.id_sensor_secundario +
            "/" +
            this.remplazar(this.updateSensor.unidadmedida) +
            "/" +
            this.updateSensor.id_grafica +
            "/" +
            this.remplazar(this.updateSensor.nombre) +
            "/" +
            this.getSensorUpdateMin() +
            "/" +
            this.getSensorUpdateMax(),
          {
            method: "PUT",
            mode: "cors", // no-cors, *cors, same-origin
            cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
            credentials: "same-origin", // include, *same-origin, omit
            redirect: "follow", // manual, *follow, error
            referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
          }
        );
        console.log("Sensor updapeado... supuestamente");
        this.fetchSensoresPorCategoria(this.updateSensor.idCategoria);
        this.fetchCategorias();
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },

    remplazar(palabra) {
      return palabra.replace(" ", "%20");
    },

    async loopAlerta() {
      var aux = {};
      try {
        const response = await fetch(this.endpointAlertas);
        const myJson = await response.json();
        this.sensoresEnAlerta = myJson;
        this.sensoresEnAlerta.forEach((alerta) => {
          aux[alerta.identificador] = true;
        });
        this.showDismissibleAlert = aux;
        this.loaded = true;
      } catch (e) {
        console.error("catched! " + e);
      }
    },
  },

  mounted() {
    const asyncInterval = async (callback, ms, triesLeft = 2) => {
      return new Promise((resolve, reject) => {
        const interval = setInterval(async () => {
          if (await this.fetchCustom()) {
            resolve();
            clearInterval(interval);
          } else if (triesLeft <= 1) {
            reject();
            clearInterval(interval);
          }
          triesLeft--;
        }, 1000);
      });
    };
    const asyncCategorias = async (callback, ms, triesLeft = 2) => {
      return new Promise((resolve, reject) => {
        const interval = setInterval(async () => {
          if (await this.fetchCategorias()) {
            resolve();
            clearInterval(interval);
          } else if (triesLeft <= 1) {
            reject();
            clearInterval(interval);
          }
          triesLeft--;
        }, 1000);
      });
    };
    const asyncGraficas = async (callback, ms, triesLeft = 2) => {
      return new Promise((resolve, reject) => {
        const interval = setInterval(async () => {
          if (await this.fetchGraficas()) {
            resolve();
            clearInterval(interval);
          } else if (triesLeft <= 1) {
            reject();
            clearInterval(interval);
          }
          triesLeft--;
        }, 1000);
      });
    };
    asyncCategorias();
    asyncInterval();
    asyncGraficas();
    setInterval(() => this.loopAlerta(), 60000);
    console.log("Fetched");
  },
};
</script>

<style scoped>
* {
  margin: 0;
  overflow-x: hidden;
}

.nav-justified > .nav-link,
.nav-justified .nav-item {
  background-color: #5a6268;
  color: white;
  display: flex;
  justify-content: space-around;
  position: relative;
}

.nav-pills .nav-link.active,
.nav-pills .show > .nav-link {
  background-color: #23272b;
}

.btn-circle.btn-xl {
  width: 70px;
  height: 70px;
  padding: 10px 16px;
  border-radius: 35px;
  font-size: 24px;
  line-height: 1.33;
}

.btn-circle {
  width: 20px;
  height: 20px;
  padding: 2px 0px;
  border-radius: 15px;
  text-align: center;
  font-size: 11px;
}

.tab {
  background-color: #6a9dc4;
  position: relative;
  top: 0;
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
  transition: all 0.3s ease;
  font-size: 1em;
  font-weight: 500;
  cursor: pointer;
  justify-content: center;
  color: cornsilk;
  border: none;
}

.tabContainer {
  display: flex;
  flex-direction: row;
  height: 3em;
}

.activeTab {
  background-color: #0d8af0;
  color: #1b3447;
  position: relative;
  top: 0;
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
  transition: all 0.3s ease;
  font-size: 1.2em;
  font-weight: 700;
  cursor: pointer;
  justify-content: center;
  text-transform: uppercase;
  border: none;
}

.descripcion {
  padding: 2em 3em;
  font-size: 0.9em;
}

.tab:hover {
  color: black;
}

.frutaImg {
  height: 20vw;
  float: left;
  margin: 1em 1em 0.5em 0;
}

.frutasDesechadas {
  flex-direction: column;
  padding: 0.5vw 2vw;
}

.desechadasContainer {
  border-style: solid;
  border-radius: 36px 0 0 36px;
  border-color: black;
  border-width: 3px;
  width: 15vw;
  font-size: 2vw;
  background-color: #98aab7;
  display: flex;
  flex-direction: column;
  align-self: flex-start;
  height: 100vh;
  min-height: 500px;
}

.contentContainerContainer {
  width: 100vw;
  height: 100vh;
  /** background-color: #5d7f9e; **/
}

.contentContainer {
  font-size: 2vw;
}

.title {
  text-align: center;
}

.addBtn {
  padding: 4px 7px;
  background-color: transparent;
  color: #4cb22a;
  cursor: pointer;
  border: transparent;
  position: absolute;
  top: 0;
  right: 0;
}

.deleteBtn {
  background-color: transparent;
  color: #d13636;
  cursor: pointer;
  border: transparent;
  position: absolute;
  right: 0;
  top: -10px;
}

.invisible {
  display: none !important ;
}
</style>
