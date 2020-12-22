<template>
  <div>
    <div v-for="(alerta, index) in sensoresEnAlerta" :key="index">
      <b-alert
        v-model="showDismissibleAlert[alerta.identificador]"
        variant="danger"
        dismissible
        style="overflow: hidden; border-radius: 0; margin: 0;"
      >
        El dispositivo {{ alerta.identificador }} registró
        {{ alerta.lectura + " en " + alerta.nombre
        }}{{
          alerta.lectura >= alerta.max
            ? " excediendo el máximo permitido."
            : " siendo menor al mínimo permitido."
        }}
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
        </audio>
      </b-alert>
    </div>
  </div>
</template>
<script>
export default {
  name: "alertas",
  props: {
    sensoresEnAlerta: "",
    showDismissibleAlert: "",
  },
};
</script>
