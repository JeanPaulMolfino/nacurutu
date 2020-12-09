<script>
	import { Line } from 'vue-chartjs'
	/*
	const getData = async () => {
		const response = await fetch('http://127.0.0.1:8000/endpoints/get:medidasbydispositivo/EM1234/2/2020-12-04/2021-01-01');
		const myJson = await response.json(); //extract JSON from the http response
		return myJson;
	}

	const getDataSet = () => {
		getData().then((data) => {
			//console.log(a.length);
			var dataRet = new Array(data.length);
			for (var i = 0; i < data.length; i++) {
				dataRet[i] = data[i].lectura;
			}
			//console.log(dataRet);
			return dataRet;
		});
	};
	*/
	
/*
[{"lectura":"22","tiempo":"2020-12-05 11:03:01"},{"lectura":"26","tiempo":"2020-12-05 11:03:02"},{"lectura":"47","tiempo":"2020-12-05 11:03:03"},{"lectura":"29","tiempo":"2020-12-05 11:03:04"},{"lectura":"52","tiempo":"2020-12-05 11:03:05"},{"lectura":"33","tiempo":"2020-12-05 11:03:06"},{"lectura":"40","tiempo":"2020-12-05 11:03:07"},{"lectura":"26","tiempo":"2020-12-05 11:03:08"},{"lectura":"35","tiempo":"2020-12-05 11:03:09"},{"lectura":"40","tiempo":"2020-12-05 11:03:10"},{"lectura":"31","tiempo":"2020-12-05 11:03:11"},{"lectura":"41","tiempo":"2020-12-05 11:03:12"},{"lectura":"45","tiempo":"2020-12-05 11:03:13"},{"lectura":"32","tiempo":"2020-12-05 11:03:14"},{"lectura":"32","tiempo":"2020-12-05 11:03:15"},{"lectura":"59","tiempo":"2020-12-05 11:03:16"},{"lectura":"50","tiempo":"2020-12-05 11:03:17"},{"lectura":"28","tiempo":"2020-12-05 11:03:18"},{"lectura":"45","tiempo":"2020-12-05 11:03:19"},{"lectura":"59","tiempo":"2020-12-05 11:03:20"}]
[22, 26, 47, 29, 52, 33","tiempo":"2020-12-05 11:03:06"},{"lectura":"40","tiempo":"2020-12-05 11:03:07"},{"lectura":"26","tiempo":"2020-12-05 11:03:08"},{"lectura":"35","tiempo":"2020-12-05 11:03:09"},{"lectura":"40","tiempo":"2020-12-05 11:03:10"},{"lectura":"31","tiempo":"2020-12-05 11:03:11"},{"lectura":"41","tiempo":"2020-12-05 11:03:12"},{"lectura":"45","tiempo":"2020-12-05 11:03:13"},{"lectura":"32","tiempo":"2020-12-05 11:03:14"},{"lectura":"32","tiempo":"2020-12-05 11:03:15"},{"lectura":"59","tiempo":"2020-12-05 11:03:16"},{"lectura":"50","tiempo":"2020-12-05 11:03:17"},{"lectura":"28","tiempo":"2020-12-05 11:03:18"},{"lectura":"45","tiempo":"2020-12-05 11:03:19"},{"lectura":"59","tiempo":"2020-12-05 11:03:20"}]
[600,	1150,	342,	6050,	2522,	3241,	1259,	157,	1545, 9841]
 */
	//let labels = ["Montevideo", "Cabanatuan", "Daegu", "Jerusalem", "Fairfield", "New York", "Gangtok", "Buenos Aires", "Hafar Al-Batin", "Idlib"];
	//let dataSet = [600, 1150, 342, 6050, 2522, 3241, 1259, 157, 1545, 841];

	export default {
		extends: Line,
		data () {
			return {
				chartData: {
					labels: ["Montevideo", "Cabanatuan", "Hafar Al-Batin", "Idlib"],
					datasets: [
						{
							label: 'Line Chart',
							//data: [600,	1150,	342,	6050,	2522,	3241,	1259,	157,	1545, 9841],
							data: [600, 1150, 1545, 841],
							fill: false,
							borderColor: '#2554FF',
							backgroundColor: '#2554FF',
							borderWidth: 1
						}
					]
				},
				options: {
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							},
							gridLines: {
								display: true
							}
						}],
						xAxes: [ {
							gridLines: {
								display: false
							}
						}]
					},
					legend: {
						display: true
					},
					responsive: true,
					maintainAspectRatio: false
				}
			}
		},
		mounted () {
			const getData = async () => {
				const response = await fetch('http://127.0.0.1:8000/endpoints/get:medidasbydispositivo/EM1234/2/2020-12-02/2021-01-01');
				const myJson = await response.json(); //extract JSON from the http response
				return myJson;
			}

			const getDataSet = () => {
				getData().then((data) => {
					//console.log(a.length);
					var dataRet = new Array(data.length);
					var labelRet = new Array(data.length);
					for (var i = 0; i < data.length; i++) {
						dataRet[i] = data[i].lectura;
						labelRet[i] = data[i].tiempo;
					}
					//console.log(dataRet);

					var chartData2 = {
						labels: labelRet,
						datasets: [
							{
								label: 'Line Chart',
								data: dataRet,
								fill: false,
								borderColor: '#2554FF',
								backgroundColor: '#2554FF',
								borderWidth: 1
							}
						]
					}


					//console.log(chartData2);
					this.renderChart(chartData2, this.options)
					//return dataRet;
				});
			};

			getDataSet();



			console.log('Component LineChartComponent mounted.')
		}
	}
</script>