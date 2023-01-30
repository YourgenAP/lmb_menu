<template>
  <Menu v-if="this.isVisible" :resource="this.resource" :player="this.player" :isAdmin="isAdmin" />
</template>

<script>
import Menu from "./components/Menu.vue";

export default {
  name: "App",
  data() {
    return {
      isVisible: false,
      resource: '',
      player: null,
      isAdmin: false,
    }
  },

  components: {
    Menu,
  },

  mounted() {
    window.addEventListener('message', (e) => {
      console.log(e.data)

      if (e.data.type === 'open-main-menu') {
        this.isVisible = !this.isVisible;
      }

      if(e.data.type === 'close-main-menu') {
        this.isVisible = !this.isVisible;
      }

      if (e.data.resource) {
        console.log(e.data.resource)
        this.resource = e.data.resource;
      }

      if (e.data.player) {
        this.player = e.data.player;
      }

      if (e.data.group) {
        if (e.data.group == 'admin') {
          this.isAdmin = true;
        } else {
          this.isAdmin = false;
        }
      }

    })

    // window.addEventListener('keydown', (e) => {
    //   if (e.key === '`' || e.key === 'ё') {
    //     this.isVisible = !this.isVisible;
    //   }
    // })
  },

  unmounted() {
    window.removeEventListener("message");
  }
};
</script>

<style>
body {
  overflow-x: hidden;
  overflow-y: hidden;

  /* background-image: url('./assets/backscreen.jpg');
  background-repeat: no-repeat; */
}
</style>
