<template>
    <div class="chartchoosercontainer">
        <chartlinestandalone
            v-if="renderLine"
            :deviceIdentificator="deviceIdentificator"
            :sensorIdSecondary="sensorIdSecondary"
            :dateFrom="dateFrom"
            :dateTo="dateTo"
            :endpoint="endpoint"
        />
        <chartradarstandalone
            v-if="renderRadar"
            :deviceIdentificator="deviceIdentificator"
            :sensorIdSecondary="sensorIdSecondary"
            :dateFrom="dateFrom"
            :dateTo="dateTo"
            :endpoint="endpoint"
        />
    </div>
</template>
<script>
export default {
    name: "chartchooser",
    beforeCreate() {
        console.log(
            `Component ${this.$options.name} beforCreate hook has been called.`
        );
    },
    data: () => ({
        renderLine: false,
        renderBar: false,
        renderRadar: false
    }),
    props: {
        deviceIdentificator: {
            type: String,
            default: `EM1234`
        },
        sensorIdSecondary: {
            type: String,
            default: `8`
        },
        sensorGraphId: {
            type: Number,
            default: 1
        },
        dateFrom: {
            type: String,
            default: `2020-12-01`
        },
        dateTo: {
            type: String,
            default: `2099-01-01`
        },
        endpoint: {
            type: String,
            default: `/endpoints/get:medidasbydispositivo/`
        }
    },
    mounted() {
        if (1 != 1 ) {
            console.log(`:D`);
        } else if (this.sensorGraphId == 1) {
            this.renderLine = true;
            this.renderBar = false;
            this.renderRadar = false;
        } else if (this.sensorGraphId == 2) {
            this.renderLine = false;
            this.renderBar = true;
            this.renderRadar = false;
        } else if (this.sensorGraphId == 5) {
            this.renderLine = false;
            this.renderBar = false;
            this.renderRadar = true;
        } else {
            console.log(`Tipo de gráfica desconocido.`);
        }
        console.log(`Component ${this.$options.name} mounted!.`);
    }
};
/**
	<chartchooser
		:deviceIdentificator="" obligatorio
		:sensorIdSecondary="" obligatorio
		:sensorGraphId="" obligatorio
		:dateFrom="" opcional
		:dateTo="" opcional
		:endpoint="" opcional
	/>
**/
</script>
