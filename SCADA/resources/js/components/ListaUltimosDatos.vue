<template>
  <div>
    <b-list-group class="descripcion float-left">
      <b-list-group-item
        :variant="dispositivo.actividad ? 'success' : 'danger'"
      >
        Actividad del dispositivo:
        {{ dispositivo.actividad ? "Activo" : "Inactivo" }}
      </b-list-group-item>
      <b-list-group-item variant="info">
        Identificador del dispositivo :
        {{ dispositivo.identificador }}
      </b-list-group-item>
      <b-list-group-item variant="info">
        Categoria del dispositivo : {{ dispositivo.categoria }}
      </b-list-group-item>

      <b-list-group-item variant="info">
        Ultima actualización:
        {{ dispositivo.ultima_actualizacion }}
      </b-list-group-item>
      <b-list-group-item variant="info"
        >Sensores:
        <b-list-group-item
          v-for="sensor in sensores"
          :key="sensor.nombre"
          variant="secondary"
        >
          {{ sensor.nombre }}: {{ sensor.lectura }}
          {{ sensor.unidadmedida }}
        </b-list-group-item>
      </b-list-group-item>
    </b-list-group>
  </div>
</template>
<script>
export default {
  name: "listaUltimosDatos",
  props: {
    dispositivo: {},
    sensores: [],
  },
};
</script>