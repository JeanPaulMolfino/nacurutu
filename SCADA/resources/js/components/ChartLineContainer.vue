<template>
    <div class="linechartcontainer">
        <p>plz dont update this</p>
        <chartline
            v-if="loaded"
            :chartData="chartDataGenerated"
            :chartOptions="chartOptionsGenerated"
        />
    </div>
</template>
<script>
console.log(`Component chartlinecontainer mounted?.`);

export default {
    name: "chartlinecontainer",
    beforeCreate() {
        console.log(
            `Component ${this.$options.name} beforCreate hook has been called.`
        );
    },
    props: {
        deviceIdentificator: {
            type: String,
            default: `EM1234`
        },
        sensorIdSecondary: {
            type: String,
            default: `6`
        },
        dateFrom: {
            type: String,
            default: `2020-12-04`
        },
        dateTo: {
            type: String,
            default: `2021-01-01`
        },
        endpoint: {
            type: String,
			//default: `http://127.0.0.1:8000/endpoints/get:medidasbydispositivo/` '/api/userlist')
			default: `/endpoints/get:medidasbydispositivo/`
        }
    },
    data: () => ({
        loaded: false,
        chartDataGenerated: null,
        chartOptionsGenerated: {
            type: Object,
            default: null
        }
    }),
    methods: {
        async fetchCustom() {
            //this.chartDataGenerated = null;
            this.loaded = false;
            try {
                const response = await fetch(
                    this.endpoint +
                        this.deviceIdentificator +
                        `/` +
                        this.sensorIdSecondary +
                        `/` +
                        this.dateFrom +
                        `/` +
                        this.dateTo
                );
                const myJson = await response.json();

                var dataRet = new Array(myJson.length);
                var labelRet = new Array(myJson.length);
                for (var i = 0; i < myJson.length; i++) {
                    dataRet[i] = myJson[i].lectura;
                    labelRet[i] = myJson[i].tiempo;
                }
                this.chartDataGenerated = {
                    labels: labelRet,
                    datasets: [
                        {
                            label: "Line Chart",
                            data: dataRet,
                            fill: false,
                            borderColor: "#2554FF",
                            backgroundColor: "#2554FF",
                            borderWidth: 1
                        }
                    ]
                };
                this.loaded = true;
            } catch (e) {
                console.error("catched! " + e);
            }
        }
    },
    async mounted() {
        const asyncInterval = async (callback, ms, triesLeft = 5) => {
            return new Promise((resolve, reject) => {
                const interval = setInterval(
                    async () => {
                        if (await this.fetchCustom()) {
                            resolve();
                            clearInterval(interval);
                        } else if (triesLeft <= 1) {
                            reject();
                            clearInterval(interval);
                        }
                        triesLeft--;
                    },

                    1000
                );
            });
        };
		asyncInterval();
        console.log(`Component ${this.$options.name} mounted!.`);
    }
};
</script>
<!-- 
Feth original:
	fetch(`http://127.0.0.1:8000/endpoints/get:medidasbydispositivo/EM1234/6/2020-12-04/2021-01-01`);

Guia:
	https://vue-chartjs.org/guide/#chart-with-api-data

Uso:
	<chartlinecontainer
        :deviceIdentificator=""
        :sensorIdSecondary=""
		:dateFrom=""
		:dateTo=""
	/>
	Endpoint (:endpoint="") no seria necesario, tiene el que usariamos por default.

	El  v-if="loaded" es para no renderizar el chart sin tener this.loaded = true


-->
