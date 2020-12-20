<script>
import { Line } from "vue-chartjs";

export default {
    name: "chartlinestandalone",
    extends: Line,
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
            default: `2000-12-31`
        },
        dateTo: {
            type: String,
            default: `2069-12-31`
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
            console.log("chartlinestandalone watched changes");
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
            try {
                const response = await fetch(this.computeLink);
                const myJson = await response.json();

                var dataRet = new Array(myJson.length);
                var labelRet = new Array(myJson.length);
                for (var i = 0; i < myJson.length; i++) {
                    dataRet[i] = myJson[i].lectura;
                    labelRet[i] = myJson[i].tiempo;
                }
                var chartDataGenerated = {
                    labels: labelRet,
                    datasets: [
                        {
                            label:
                                "[" +
                                this.deviceIdentificator +
                                ": " +
                                this.sensorIdSecondary +
                                "] " +
                                this.dateFrom +
                                " | " +
                                this.dateTo,
                            data: dataRet,
                            fill: false,
                            borderColor: "#2554FF",
                            backgroundColor: "#2554FF",
                            borderWidth: 1
                        }
                    ]
                };
                var chartAuxptions = {
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                },
                                gridLines: {
                                    display: true
                                }
                            }
                        ],
                        xAxes: [
                            {
                                gridLines: {
                                    display: false
                                }
                            }
                        ]
                    },
                    legend: {
                        display: true
                    },
                    responsive: true,
                    maintainAspectRatio: true
                };
                this.renderChart(chartDataGenerated, chartAuxptions);
            } catch (e) {
                console.error("catched! " + e);
            }
        },
        async asyncInterval(ms, triesLeft = 4) {
			await this.fetchCustom();
			triesLeft--;
            return new Promise((resolve, reject) => {
                this.intervalHandler = setInterval(
                    async () => {
                        if (await this.fetchCustom()) {
                            resolve();
                            clearInterval(this.intervalHandler);
                        } else if (triesLeft <= 1) {
                            reject("Tries left: <=1)");
                            clearInterval(this.intervalHandler);
                        }
                        triesLeft--;
                    },
                    2000
                );
            });
        }
	},
	destroyed() {
		console.log("chartlinestandalone destroyed");
		clearInterval(this.intervalHandler);
		//reject("chartlinestandalone destroyed");
    },
    async mounted() {
        this.asyncInterval();
        console.log(`Component ${this.$options.name} mounted!.`);
    }
};
</script>
