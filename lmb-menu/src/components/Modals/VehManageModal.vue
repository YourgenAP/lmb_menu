<template>
  <div>
    <h3 class="menu__title">Управление т/с</h3>
    <ul class="menu__list">
      <li class="menu__list-item">Spawn horse</li>
      <li class="menu__list-item">Delete horse</li>
      <li class="menu__list-item">Revive horse</li>
      <li class="menu__list-item">Delete horses by radius</li>
      <li class="menu__list-item">Spawn carriage</li>
      <li class="menu__list-item">Delete carriage</li>
      <li class="menu__list-item">Fix carriage</li>
      <li class="menu__list-item">Delete carriages by radius</li>
      <li class="menu__list-item">Clear traffic</li>
      <li class="menu__list-item">Return horse in stable</li>
      <li class="menu__list-item">Return carriage in garage</li>
      <li class="menu__list-item">Show vehicle ID</li>
    </ul>
  </div>
</template>


<style scoped>
.menu__list {
  height: 360px;
  overflow-y: auto;
}

.menu__list-item:last-child {
  border-bottom: none;
}

.menu__list-item:last-child:hover {
  border-radius: 0px 0px 20px 20px;
  border-bottom: none;
}

</style>