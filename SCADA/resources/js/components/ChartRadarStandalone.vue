<script>
import { Radar } from "vue-chartjs";

export default {
    name: "chartradarstandalone",
    extends: Radar,
    props: {
        deviceIdentificator: {
            type: String,
            default: `EM1234`
        },
        sensorIdSecondary: {
            type: String,
            default: `8`
        },
        dateFrom: {
            type: String,
            default: `null`
        },
        dateTo: {
            type: String,
            default: `null`
        },
        endpoint: {
            type: String,
            default: `/endpoints/get:medidasbydispositivo/`
        }
    },
    data: function() {
        return {
            intervalHandler: 0
        };
    },
    watch: {
        computeLink: function(newComputeLink, oldComputeLink) {
            console.log("chartradarstandalone watched changes");
            clearInterval(this.intervalHandler);
            this.asyncInterval();
        }
    },
    computed: {
        computeLink: function() {
            let retLink =
                this.endpoint +
                this.deviceIdentificator +
                `/` +
                this.sensorIdSecondary +
                `/` +
                this.dateFrom +
                `/` +
                this.dateTo;
            return retLink;
        }
    },
    methods: {
        async fetchCustom() {
            //this.chartDataGenerated = null;
            //this.loaded = false;
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

                let directionN = 0;
                let directionNE = 0;
                let directionE = 0;
                let directionES = 0;
                let directionS = 0;
                let directionSW = 0;
                let directionW = 0;
                let directionWN = 0;

                let lect = 0;
                for (var i = 0; i < myJson.length; i++) {
                    lect = myJson[i].lectura;

                    if (1 != 1) {
                    } else if (
                        (337.5 <= lect && lect <= 360) ||
                        (0 <= lect && lect < 22.5)
                    ) {
                        directionN = directionN + 1;
                        //console.log(`directionN: ` + lect);
                    } else if (22.5 <= lect && lect < 67.5) {
                        directionNE = directionNE + 1;
                        //console.log(`directionNE: ` + lect);
                    } else if (67.5 <= lect && lect < 112.5) {
                        directionE = directionE + 1;
                        //console.log(`directionE: ` + lect);
                    } else if (112.5 <= lect && lect < 157.5) {
                        directionES = directionES + 1;
                        //console.log(`directionES: ` + lect);
                    } else if (157.5 <= lect && lect < 202.5) {
                        directionS = directionS + 1;
                        //console.log(`directionS: ` + lect);
                    } else if (202.5 <= lect && lect < 247.5) {
                        directionSW = directionSW + 1;
                        //console.log(`directionSW: ` + lect);
                    } else if (247.5 <= lect && lect < 292.5) {
                        directionW = directionW + 1;
                        //console.log(`directionW: ` + lect);
                    } else if (292.5 <= lect && lect < 337.5) {
                        directionWN = directionWN + 1;
                        //console.log(`directionWN: ` + lect);
                    } else {
                        console.log(`Nope.. impossible ` + lect); // ocurre o.o
                    }
                }

                var dataRet = [
                    directionN,
                    directionNE,
                    directionE,
                    directionES,
                    directionS,
                    directionSW,
                    directionW,
                    directionWN
                ];

                //console.log(`dataRet: ` + dataRet);

                var chartDataGenerated = {
                    labels: ["N", "NE", "E", "SE", "S", "SO", "O", "NO"],
                    datasets: [
                        {
                            label:

								"[" +
                                this.deviceIdentificator +
                                ": " +
                                this.sensorIdSecondary +
								"] " +
								(this.dateFrom != 'null' ? this.dateFrom: '')+
								(this.dateFrom != 'null' || this.dateTo != 'null' ? " | ": '')+
								(this.dateTo != 'null' ? this.dateTo: '')
							,
                            data: dataRet,
                            fill: false,
                            borderColor: "#2554FF",
                            backgroundColor: "#2554FF",
                            borderWidth: 1
                        }
                    ]
                };
                var chartAuxptions = {
                    scale: {
                        angleLines: {
                            display: true
                        },
                        ticks: {
                            suggestedMin: 0 /*,
                            suggestedMax: 100*/
                        }
                    },
                    legend: {
                        display: true
                    },
                    responsive: true,
                    maintainAspectRatio: true
                };

                //this.loaded = true;
                this.renderChart(chartDataGenerated, chartAuxptions);
            } catch (e) {
                console.error("catched! " + e);
            }
        },
        async asyncInterval(ms, triesLeft = 4) {
            await this.fetchCustom();
            triesLeft--;
            return new Promise((resolve, reject) => {
                this.intervalHandler = setInterval(async () => {
                    if (await this.fetchCustom()) {
                        resolve();
                        clearInterval(this.intervalHandler);
                    } else if (triesLeft <= 1) {
                        reject("Tries Radar left: <=1)");
                        clearInterval(this.intervalHandler);
                    }
                    triesLeft--;
                }, 2000);
            }).catch(function(e) {
                console.log(e);
            });
        }
    },
    destroyed() {
        console.log("chartradarstandalone destroyed");
		clearInterval(this.intervalHandler);
		//reject("chartradarstandalone destroyed.");
    },
    async mounted() {
        this.asyncInterval();
        console.log(`Component ${this.$options.name} mounted!.`);
    }
};
</script>
