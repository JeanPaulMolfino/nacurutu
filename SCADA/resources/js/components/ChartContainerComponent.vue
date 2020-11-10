<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Example Chart Container Component</div>

                    <div class="card-body">
                              <chart-component></chart-component>
                                  <div id="chart">
                                   </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    /*    <div id="chart">
                        </div>
                        <chart-component></chart-component>
                        */

    export default {
        mounted() {
            console.log('Component ChartContainerComponent mounted.')
        }
    }
</script>