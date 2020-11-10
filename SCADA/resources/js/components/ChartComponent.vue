<!-- 
<script>
    import {Chart} from 'Chart.js';
    export default {
        props: {
            labels: String,
            dataProp: String
        },
        methods: {
            renderChart() {
                new Chart(document.getElementById('canvas').getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: JSON.parse(this.labels),
                        datasets: [{
                            label: '# of Laravel apps made by Jack Russels',
                            data: JSON.parse(this.dataProp),
                            backgroundColor: [
                                '#2ecc71',
                                '#e74c3c',
                                '#8e44ad',
                                '#d35400',
                                '#16a085'
                            ]
                        }]
                    },
                    options: {
                        title: {
                            display: true,
                            fontSize: 22,
                            text: 'Example'
                        }
                    }
                });
            }
        },
        mounted() {
            this.renderChart();
        }
    }
</script>

<template>
    <div class="container">
        <div id="chart">
        </div>
    </div>
</template>
-->




<script>
    //@yield('content')
    import { Chartisan } from '@chartisan/chartjs'
    
    const chart = new Chartisan({
        el: '#chart',
        url: 'http://127.0.0.1:8000/chart1Data',
        // You can also pass the data manually instead of the url:
        // data: { ... }
    })
    
    console.log('Component Chart mounted?.')

    export default {
        mounted() {
            console.log('Component Chart mounted 2.')
        }
    }
</script>
