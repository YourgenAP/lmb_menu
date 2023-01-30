<template>
  <div>

    <div class="list" :class="{ hidden: isCategories }">
      <ul class="menu__list">
        <li class="menu__list-item" v-for="(item, index) in animations" :key="index"
          @click="selectAnimCategories(item)">{{ index }}</li>
      </ul>
    </div>

    <div class="modals">
      <div class="anims" :class="{ hidden: isAnimlist }">
        <LeftOutlined id="back" class="back_btn" @click="{ isAnimlist = true; isCategories = false; }" />
        <input type="text" v-model="search" class="search" placeholder="Поиск" />
        <ul class="menu__list">
          <li class="menu__list-item" v-for="(item, index) in requestSearch" :key="index" @click="playSelectedAnim(animlist[index])">
            {{ index }}. {{ animlist[index].animname }}
            <!-- <StarOutlined @click="addToFavorites(animlist[index])" /> -->
          </li>
        </ul>
      </div>

    </div>
  </div>
</template>

<script>
import anim from '../data/animations.json';

import { LeftOutlined } from '@ant-design/icons-vue';

export default {
  components: {
    LeftOutlined
  },

  props: { resource: String },

  data() {
    return {
      animations: anim.anims[0],
      animlist: [],
      search: "",
      isCategories: false,
      isAnimlist: true,
    };
  },

  computed: {
    requestSearch() {
      return this.animlist.filter((anim) => {
        return anim.animname.toLowerCase().includes(this.search.toLowerCase());
      });
    }
  },

  methods: {
    selectAnimCategories(param) {
      this.animlist = param;
      this.isAnimlist = !this.isAnimlist;
      this.isCategories = !this.isCategories;
    },

    playSelectedAnim(param) {
      fetch(`https://${this.resource}/play-selected-anim`, {
        method: 'POST',
        body: JSON.stringify({ anim: param })
      })
    },

    addToFavorites(item) {
      anim.anims[0]["Избранное"].push(item);
    },
  },
};
</script>

<style scoped>
.list {
  height: 360px;
  overflow-y: auto;
}

.modals .anims {
  height: 360px;
  overflow-y: auto;
}

.modals .anims input {
  width: 275px;
  padding: 8px 10px;

  outline: none;
  resize: none;

  font-family: "HapnaSlab-Serif";
  font-style: normal;
  font-weight: 600;
  font-size: 16px;
  color: rgba(255, 255, 255, 0.85);

  background: linear-gradient(224.05deg, rgba(0, 0, 0, 0) 36.51%, rgba(148, 138, 138, 0.05) 100%), rgba(255, 255, 255, 0.02);
  border-radius: 6px;
  box-sizing: border-box;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.35);
}

.modal .search {
  width: 85%;
}

.modals .anims .menu__list-item span {
  font-size: 18px;
  margin-right: 15px;
}
</style>