<template>
  <div id="container">
    <div class="contentContainerContainer">
      <div class="contentContainer">
        <div class="nav nav-pills nav-justified">
          <div
            @click="seleccionarFruta('dispositivos')"
            :class="[
              isActive('dispositivos')
                ? 'nav-item nav-link active'
                : 'nav-item nav-link',
            ]"
          >
            <p>Dispositivos</p>
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
            <div class="descripcion">
              <p>
                Actividad del dispositivo:
                {{ dispositivo.actividad ? "TRUE" : "FALSE" }}
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
          </div>
        </div>
        <div>
          <div v-if="'dispositivos' === tabSeleccionada">
            <div class="descripcion">
              <button
                @click="displayForm()"
                :class="[formulario ? 'invisible' : 'btn btn-success']"
              >
                NUEVO DISPOSITIVO
              </button>
              <div
                v-for="(dispositivo, index) in dispositivos"
                :key="index"
                :class="[formulario ? 'invisible' : 'frutasDesechadas']"
              >
                <p>
                  {{ dispositivo.categoria }} -
                  {{ dispositivo.identificador }}
                  <button @click="anadirTab(dispositivo)" class="addBtn">
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
                </p>
              </div>

              <div :class="[formulario ? '' : 'invisible']">
                <b-form @submit="checkForm" @reset="onReset">
                  <b-form-group
                    id="input-group-1"
                    label="Identificador del dispositivo:"
                    label-for="input-1"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="form.identificador"
                      required
                      placeholder="Identificador"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-3"
                    label="Categoria del dispositivo:"
                    label-for="input-2"
                  >
                    <b-form-select
                      id="input-2"
                      v-model="form.categoria"
                      :options="nombreCategorias"
                      required
                    ></b-form-select>
                  </b-form-group>

                  <b-form-group
                    id="input-group-3"
                    label="Marca del dispositivo:"
                    label-for="input-3"
                  >
                    <b-form-input
                      id="input-3"
                      v-model="form.marca"
                      required
                      placeholder="Marca"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-4"
                    label="Modelo del dispositivo:"
                    label-for="input-4"
                  >
                    <b-form-input
                      id="input-4"
                      v-model="form.modelo"
                      required
                      placeholder="Modelo"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-5"
                    label="Ubicacion del dispositivo:"
                    label-for="input-5"
                  >
                    <b-form-input
                      id="input-5"
                      v-model="form.ubicacion"
                      placeholder="Ubicacion (no obligatorio)"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-6"
                    label="Fecha de alta del dispositivo:"
                    label-for="input-6"
                  >
                    <b-calendar
                      id="input-6"
                      v-model="form.fechaAlta"
                      block
                      @context="onContext"
                      locale="en-US"
                      selected-variant="success"
                      today-variant="info"
                      nav-button-variant="primary"
                    ></b-calendar>
                  </b-form-group>

                  <div class="form-group row">
                    <b-button type="submit" variant="primary">Enviar</b-button>
                    <b-button type="reset" variant="warning">Resetear</b-button>
                    <b-button @click="displayForm()" variant="danger"
                      >Cancelar</b-button
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
export default {
  expand: false,
  props: {},
  data() {
    return {
      loaded: false,
      dispositivos: [],
      sensores: { type: Object, default: null },
      endpoint: "/endpoints/get:dispositivos",
      endpointSensores: "dispositivos/get:get_latestmedidasbydispositivo/",
      endpointCategorias: "tiposdispositivos/get:get_tiposdispositivos/",
      endpointCrearDispositivo: "dispositivos/post:insert_dispositivo/",
      titulo: "Testeo de Tabs",
      formulario: false,
      frutas: [],
      formError: {
        identificador: false,
        categoria: false,
        marca: false,
        modelo: false,
        ubicacion: false,
        fechaAlta: false,
      },
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
      dateContext: null,
    };
  },
  methods: {
    seleccionarFruta(fruta) {
      for (var i = 0; i < this.frutas.length; i++) {
        if (
          this.frutas[i].identificador === fruta ||
          fruta === "dispositivos"
        ) {
          this.tabSeleccionada = fruta;
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
    displayForm() {
      this.formulario = !this.formulario;
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
      this.formError.identificador = errorIdentificador;
      if (!errorIdentificador) {
        this.sendDispositivo();
        console.log("Un exito muchachin");
        console.log(
          this.endpointCrearDispositivo +
            this.form.ubicacion +
            "/" +
            this.form.fechaAlta +
            "/" +
            this.form.categoria.id +
            "/" +
            this.form.marca +
            "/" +
            this.form.modelo +
            "/" +
            this.form.identificador
        );
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
    async sendDispositivo() {
      this.loaded = false;
      try {
        const response = await fetch(
          this.endpointCrearDispositivo +
            this.form.ubicacion +
            "/" +
            this.form.fechaAlta +
            "/" +
            this.form.categoria.id +
            "/" +
            this.form.marca +
            "/" +
            this.form.modelo +
            "/" +
            this.form.identificador,
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
    asyncCategorias();
    asyncInterval();
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

.container {
  display: flex;
  width: 100vw;
  margin: 20px 1vw 0 1vw;
  min-height: 500px;
  font-size: 3vw;
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
