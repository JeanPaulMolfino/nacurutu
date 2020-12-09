
<script>
import { Line, mixins } from 'vue-chartjs'
// const { reactiveProp } = mixins //const { reactiveData } = mixins
const { reactiveProp } = mixins

console.log(`Component linechart mounted?.`);

export default {
	name: 'chartline',
	beforeCreate() {
		console.log(`Component ${this.$options.name} beforCreate hook has been called.`);
	},
	extends: Line,
	mixins: [reactiveProp],
	/*props: ['options'],*/
    /*props: {
        chartData: {
            type: Object,
            default: {
                labels: [`no_data_00`, `no_data_01`, `no_data_02`],
                datasets: [
                    {
                        label: `no_data_provided_00`,
                        data: [0, 69, 420],
                        fill: false,
                        borderColor: `#2554FF`,
                        backgroundColor: `#2554FF`,
						borderWidth: 1
					},
					{
                        label: `no_data_provided_01`,
                        data: [0, 420, 69],
                        fill: false,
                        borderColor: `#2554FF`,
                        backgroundColor: `#2554FF`,
                        borderWidth: 1
                    }
                ]
            }
        },
        chartOptions: {
            type: Object,
            default: {
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
        }
    },*/
    mounted() {
        console.log(`Component ${this.$options.name} mounted!.`);
        this.renderChart(this.chartData, this.chartOptions);
    }
};
</script>
<!-- 
Original Source:
	https://vue-chartjs.org/guide/
Guia para propiedades y etc..
	https://www.chartjs.org/docs/latest/charts/line.html


Basicamente es un adapter para Chart.js
Uso: 
	- Espera dos props, el componente se usa estilo ==> 	<linechart :chartData="chartDataGenerated" :chartOptions="chartOptionsGenerated" />
		-- Donde chartDataGenerated y chartOptionsGenerated son las variables de quien contenga <linechart/>
	- De recibir nulls, utiliza los defaults establecidos aqui.
	- [[ No realizar cambios aqui ]]
-->