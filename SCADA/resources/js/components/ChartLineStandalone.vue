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
            default: `2020-12-04`
        },
        dateTo: {
            type: String,
            default: `2021-01-01`
        },
        endpoint: {
            type: String,
			default: `http://127.0.0.1:8000/endpoints/get:medidasbydispositivo/`
			// '/api/userlist')
            //default: `/endpoints/get:medidasbydispositivo/`
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
                            label: "Line Chart",
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
            }
        
				//this.loaded = true;
				this.renderChart(chartDataGenerated, chartAuxptions);
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
