<template>
  <div id="window" class="light">
    <!-- <Same draggable="true" :resource="resource" @mousedown="onMouseDown($event)" @dragstart="onDragStart($event)"
      @dragend="onDragStop($event)" @dragenter.prevent @dragover.prevent /> -->
    <Same :resource="resource" :player="player" :isAdmin="isAdmin" />
  </div>
</template>

<script>
import Same from "./Same.vue";

export default {
  props: { resource: String, player: Object, isAdmin: Boolean },
  components: { Same },

  data() {
    return {
      user: {
        group: 'user'
      }
    }
  }

  // setup() {
  //   var coordX = 0;

  //   const onDragStart = (event) => {
  //     event.dataTransfer.dropEffect = 'move';
  //     event.dataTransfer.effectAllowed = 'move';
  //   }

  //   const onMouseDown = (event) => {
  //     coordX = event.offsetX;
  //   }

  //   const onDragStop = (event) => {
  //     const el = event.target;
  //     el.style.position = 'absolute';
  //     el.style.zIndex = '9999';

  //     if (event.pageX == (window.innerWidth - 1)) {
  //       el.style.left = (event.pageX - el.offsetWidth - 15) + 'px';
  //       el.style.top = (event.pageY - 12) + 'px';
  //     } else {
  //       el.style.left = (event.pageX - coordX) + 'px';
  //       el.style.top = (event.pageY - 12) + 'px';
  //     }
  //   }

  //   return {
  //     onDragStart,
  //     onDragStop,
  //     onMouseDown,
  //     coordX
  //   }

  // }
};
</script>

<style scoped>
@font-face {
  font-family: "RDRLino-Regular";
  src: url("../fonts/RDRLino-Regular.ttf") format("truetype");
  font-style: normal;
  font-weight: normal;
}

#window {
  max-width: 300px !important;
  padding: 0;
  margin: 0;
  background-size: cover;
  font-family: "RDRLino-Regular";
  color: rgb(255, 235, 235, 0.8);
  font-weight: 1;
  font-size: 16px;
  border-radius: 5px;
}

.light {
  background-color: rgba(0, 0, 0, 0.35);
}
</style>>
