<template>
  <h3 class="menu__title">Event Tools</h3>
  <ul class="menu__list">
    <li class="menu__list-item">Spawn prop</li>
    <li class="menu__list-item">Delete prop</li>
    <li class="menu__list-item">Delete props by radius</li>
    <li class="menu__list-item">Save characted</li>
    <li class="menu__list-item">Spawn NPC</li>
    <li class="menu__list-item">NPC Control</li>
    <li class="menu__list-item">Spawn fire</li>
    <li class="menu__list-item">Explosion menu</li>
    <li class="menu__list-item">No Ragdoll</li>
    <li class="menu__list-item">Frease ID</li>
    <li class="menu__list-item">Use default hash</li>
    <li class="menu__list-item">Use animal hash</li>
    <li class="menu__list-item">Unlimited ammo</li>
    <li class="menu__list-item">Full upgrade horse</li>
  </ul>
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