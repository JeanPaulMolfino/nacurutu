<template>
  <div class="row">
    <div
      v-for="(dispositivo, index) in dispositivos"
      :key="index"
      class="col-md-3 col-6 my-1"
    >
      <div class="card h-100">
        <div class="card-body" style="text-align: center">
          <div class="card-title">
            {{ dispositivo.identificador }}
            <button @click="anadirTab(dispositivo)" class="addBtn">
              <svg
                width="1em"
                height="1em"
                viewBox="0 0 16 16"
                class="bi bi-plus-circle-fill"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"
                />
              </svg>
            </button>
          </div>
          <div>
            <span class="badge badge-pill badge-info">{{
              dispositivo.categoria
            }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "listDispositivos",
  props: {
    dispositivos: [],
    anadirTab: Function,
  },
};
</script>

<style scoped>
.addBtn {
  padding: 4px 7px;
  background-color: transparent;
  color: #4cb22a;
  cursor: pointer;
  border: transparent;
  position: absolute;
  top: 0;
  right: 0;
}
</style>