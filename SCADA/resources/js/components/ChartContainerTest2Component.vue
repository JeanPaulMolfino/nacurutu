<template>
  <div>
    <linechart-component></linechart-component>
    <b-container fluid>
      <charttest2-component></charttest2-component>
      <charttest2-component></charttest2-component>
      <charttest2-component></charttest2-component>
      <charttest2-component></charttest2-component>
    </b-container>
  </div>
</template>
<script>
console.log("Component ChartContainerTest2Component mounted?.");
export default {
  mounted() {
    console.log("Component ChartContainerTest2Component mounted.");
  },
};
</script>
