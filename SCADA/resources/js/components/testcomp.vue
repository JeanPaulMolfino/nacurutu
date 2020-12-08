<template>
    <div id="container">
        <div class="contentContainerContainer">
            <div class="contentContainer">
                <div class="tabContainer">
                    <div
                        @click="seleccionarFruta('dispositivos')"
                        :class="[
                            isActive('dispositivos') ? 'activeTab' : 'tab'
                        ]"
                    >
                        <p>Dispositivos</p>
                    </div>
                    <div
                        v-for="(fruta, index) in frutas"
                        :key="index"
                        @click="seleccionarFruta(fruta.nombre)"
                        :class="[isActive(fruta.nombre) ? 'activeTab' : 'tab']"
                    >
                        <p>{{ fruta.nombre }}</p>
                        <button @click="eliminarTab(fruta)" class="deleteBtn">
                            X
                        </button>
                    </div>
                </div>

                <div v-for="(fruta, index) in frutas" :key="index">
                    <div
                        v-if="
                            fruta.nombre === tabSeleccionada ||
                                (tabSeleccionada === '' && index === 0)
                        "
                    >
                        <div class="descripcion">
                            <img v-bind:src="fruta.foto" class="frutaImg" />
                            <p>{{ fruta.descripcion }}</p>
                        </div>
                    </div>
                </div>
                <div>
                    <div v-if="'dispositivos' === tabSeleccionada">
                        <div class="descripcion">
                            <button
                                @click="nuevoDispositivo()"
                                class="nuevoBtn"
                            >
                                NUEVO DISPOSITIVO
                            </button>
                            <div
                                v-for="(fruta, index) in frutasDesechadas"
                                :key="index"
                                class="frutasDesechadas"
                            >
                                <p>
                                    {{ fruta.nombre }}
                                    <button
                                        @click="anadirTab(fruta)"
                                        class="addBtn"
                                    >
                                        +
                                    </button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    expand:false,
    props: {},
    data() {
        return {
            titulo: "Testeo de Tabs",
            frutas: [],
            tabSeleccionada: "dispositivos",
            frutasDesechadas: [
                {
                    nombre: "Uva",
                    foto: "uva.jpg",
                    descripcion:
                        "La uva es una fruta perosa.Se denomina pera al fruto de distintas especies del género Pyrus, integrado por árboles caducifolios conocidos comúnmente como perales.1​ Sin embargo, cuando se trata del fruto comestible, se hace referencia mayormente al producido por el llamado peral común (Pyrus communis). La pera es una fruta jugosa, carnosa, y una de las más importantes producidas en las regiones templadas. En China, son consideradas como un símbolo de longevidad, porque aunque sus flores sugieren fragilidad, crecen en el peral, un árbol caracterizado por su fuerza y longevidad, capaz de resistir las sequías más duras. El carácter intenso bajo esa fragilidad aparente es una característica común en las flores y frutos de su familia -la de las Rosáceas-: rosas, fresas, melocotones y cerezas. Además, su inconfundible sabor resiste la destilación para elaborar aguardiente. La pera es una de las frutas que mejor tolera el organismo y de las que menos alergias producen, tiene un alto contenido en agua (más del 80%), por lo que es muy fácil de digerir; es rica en fibra, vitamina C y posee propiedades antioxidantes. 3​Por ende se considera muy adecuada para lograr un enriquecimiento vitamínico y favorecer una dieta sana y equilibrada.",
                    datos: [10, 20, 30, 20],
                    labels: [
                        new Date("2018-07-07 00:00:00"),
                        new Date("2018-07-08 00:00:00")
                    ]
                },
                {
                    nombre: "Pera",
                    foto: "pera.jpg",
                    descripcion:
                        "La pera es una fruta perosa.Se denomina pera al fruto de distintas especies del género Pyrus, integrado por árboles caducifolios conocidos comúnmente como perales.1​ Sin embargo, cuando se trata del fruto comestible, se hace referencia mayormente al producido por el llamado peral común (Pyrus communis). La pera es una fruta jugosa, carnosa, y una de las más importantes producidas en las regiones templadas. En China, son consideradas como un símbolo de longevidad, porque aunque sus flores sugieren fragilidad, crecen en el peral, un árbol caracterizado por su fuerza y longevidad, capaz de resistir las sequías más duras. El carácter intenso bajo esa fragilidad aparente es una característica común en las flores y frutos de su familia -la de las Rosáceas-: rosas, fresas, melocotones y cerezas. Además, su inconfundible sabor resiste la destilación para elaborar aguardiente. La pera es una de las frutas que mejor tolera el organismo y de las que menos alergias producen, tiene un alto contenido en agua (más del 80%), por lo que es muy fácil de digerir; es rica en fibra, vitamina C y posee propiedades antioxidantes. 3​Por ende se considera muy adecuada para lograr un enriquecimiento vitamínico y favorecer una dieta sana y equilibrada.",
                    datos: [10, 20, 30, 20],
                    labels: [
                        new Date("2018-07-07 00:00:00"),
                        new Date("2018-07-08 00:00:00")
                    ]
                },
                {
                    nombre: "Manzana",
                    foto: "manzana.jpg",
                    descripcion:
                        "La manzana cae del arbol. La manzana es el fruto comestible de la especie Malus domestica, llamada comúnmente manzano. Es una fruta pomácea de forma redonda y sabor más o menos dulce, dependiendo de la variedad.Los manzanos se cultivan en todo el mundo y son las especies más cultivadas en el género Malus. El árbol se originó en Asia Central, donde su ancestro salvaje, Malus sieversii, todavía se encuentra hoy en día. Las manzanas se han cultivado durante miles de años en Asia y Europa y fueron traídas a América del Norte por colonos europeos. Las manzanas tienen un significado religioso y mitológico en muchas culturas, incluyendo la tradición nórdica, griega y cristiana europea.  Los manzanos son grandes si se cultivan a partir de semillas. Generalmente, los cultivares de manzana se propagan injertando en portainjertos, que controlan el tamaño del árbol resultante. Hay más de 7.500 cultivares conocidos de manzanas, lo que resulta en una gama de características deseadas. Diferentes cultivares se crían para diversos gustos y uso, incluyendo cocinar, comer crudo y la producción de sidra. Los árboles y los frutos son propensos a una serie de problemas de hongos, bacterias y plagas, que pueden ser controlados por una serie de medios orgánicos y no orgánicos. En 2010, el genoma del fruto fue secuenciado como parte de la investigación sobre el control de enfermedades y la reproducción selectiva en la producción de manzanas.La producción mundial de manzanas en 2018 fue de 86 millones de toneladas, y China representa casi la mitad del total.",
                    datos: [10, 20, 30, 20],
                    labels: [
                        new Date("2018-07-07 00:00:00"),
                        new Date("2018-07-08 00:00:00")
                    ]
                },
                {
                    nombre: "Platano",
                    foto: "banana.jpg",
                    descripcion:
                        "Sopa du macaco toma tu banana. La banana,1​ plátano,2​ guineo, banano, maduro, cambur o gualele, es un fruto comestible, botánicamente una baya, de varios tipos de grandes plantas herbáceas del género Musa. A estas plantas de gran porte que tienen aspecto de arbolillo se las denomina plataneras, bananeros, bananeras, plátanos o bananos.3 Es un fruto con cualidades variables en tamaño, color y firmeza, alargado, generalmente curvado y carnoso, rico en almidón cubierto con una cáscara, que puede ser verde, amarilla, roja, púrpura o marrón cuando está madura. Los frutos crecen en piñas que cuelgan de la parte superior de la planta.",
                    datos: [10, 20, 30, 20],
                    labels: [
                        new Date("2018-07-07 00:00:00"),
                        new Date("2018-07-08 00:00:00")
                    ]
                }
            ]
        };
    },
    methods: {
        seleccionarFruta(fruta) {
            this.tabSeleccionada = fruta;
        },
        isActive(fruta) {
            var resultado = fruta === this.tabSeleccionada;
            return resultado;
        },
        eliminarTab(fruta) {
            for (var i = 0; i < this.frutas.length; i++) {
                if (this.frutas[i] === fruta) {
                    this.frutas.splice(i, 1);
                }
            }
        },
        añadirTab(fruta) {
            if (this.frutas.includes(fruta)) {
                this.tabSeleccionada = fruta.nombre;
            } else {
                this.frutas.push(fruta);
            }
        }
    },
    methods: {
        seleccionarFruta(fruta) {
            this.tabSeleccionada = fruta;
        },
        isActive(fruta) {
            var resultado = fruta === this.tabSeleccionada;
            return resultado;
        },
        eliminarTab(fruta) {
            for (var i = 0; i < this.frutas.length; i++) {
                if (this.frutas[i] === fruta) {
                    this.frutas.splice(i, 1);
                }
            }
        },
        anadirTab(fruta) {
            if (this.frutas.includes(fruta)) {
                this.tabSeleccionada = fruta.nombre;
            } else {
                this.frutas.push(fruta);
            }
        }
    },
    mounted() {
        console.log("Componente listado montado.");
    }
};
</script>

<style scoped>
* {
    margin: 0;
}

.container {
    display: flex;
    width: 100vw;
    margin: 20px 1vw 0 1vw;
    min-height: 500px;
    font-size: 3vw;
}

.tab {
    background-color: #6a9dc4;
    position: relative;
    top: 0;
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    transition: all 0.3s ease;
    font-size: 1em;
    font-weight: 500;
    cursor: pointer;
    justify-content: center;
    color: cornsilk;
    border: none;
}

.tabContainer {
    display: flex;
    flex-direction: row;
    height: 3em;
}

.activeTab {
    background-color: #0d8af0;
    color: #1b3447;
    position: relative;
    top: 0;
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    transition: all 0.3s ease;
    font-size: 1.2em;
    font-weight: 700;
    cursor: pointer;
    justify-content: center;
    text-transform: uppercase;
    border: none;
}

.descripcion {
    padding: 2em 3em;
    font-size: 0.9em;
}

.tab:hover {
    color: black;
}

.frutaImg {
    height: 20vw;
    float: left;
    margin: 1em 1em 0.5em 0;
}

.frutasDesechadas {
    flex-direction: column;
    padding: 0.5vw 2vw;
}

.desechadasContainer {
    border-style: solid;
    border-radius: 36px 0 0 36px;
    border-color: black;
    border-width: 3px;
    width: 15vw;
    font-size: 2vw;
    background-color: #98aab7;
    display: flex;
    flex-direction: column;
    align-self: flex-start;
    height: 100vh;
    min-height: 500px;
}

.contentContainerContainer {
    width: 98vw;
    background-color: #b9d3e8;
}

.contentContainer {
    font-size: 2vw;
}

.title {
    text-align: center;
}

.addBtn {
    border-radius: 50%;
    padding: 4px 7px;
    background-color: #4cb22a;
    color: #335627;
    cursor: pointer;
    border: transparent;
}

.deleteBtn {
    border-radius: 50%;
    padding: 4px 7px;
    background-color: #d13636;
    color: #e8bebe;
    cursor: pointer;
    justify-content: flex-end;
    align-self: end;
    margin-left: 15vw;
    margin-top: 4px;
    position: absolute;
    border: transparent;
}
</style>
