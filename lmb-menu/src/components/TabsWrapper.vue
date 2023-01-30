<template>
  <div class="tabs">
    <ul class="tabs__header">
      <li v-for="title in tabTitles" :key="title" @click="selectedTitle = title"
        :class="{ selected: title == selectedTitle }">
        {{ title }}
      </li>
    </ul>
    <slot />
  </div>
</template>

<script>
import { provide, ref } from "vue";

export default {
  setup(props, { slots }) {
    const tabTitles = ref(slots.default().map((tab) => tab.props.title));
    const selectedTitle = ref(tabTitles.value[0]);

    provide("selectedTitle", selectedTitle);
    return {
      selectedTitle,
      tabTitles,
    };
  },
};
</script>

<style scoped>
.tabs {
  display: flex;
  flex-direction: column;
  padding: 0px 0px 10px 0px;
}

.tabs__header {
  margin: 0;
  padding: 0;

  list-style: none;

  display: flex;
  flex-direction: row;
}

.tabs__header li {
  margin: 5px;
  padding: 8px 16px;

  cursor: pointer;
  transition: 0.4s all ease-out;

  border: none;
  border-radius: 20px;
  color: rgba(255, 255, 255, 0.65);
  background: rgba(148, 138, 138, 0.15);
}

.tabs__header li:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.tabs__header li.selected {
  box-sizing: border-box;
  color: white;
}
</style>