<template>
  <div>
    <h3 class="menu__title">Взаимодействие (adm)</h3>
    <ul class="menu__list">
      <li class="menu__list-item">Revive ID</li>
      <li class="menu__list-item">Ticket to player</li>
      <li class="menu__list-item">Message to all players</li>
      <li class="menu__list-item">Show inventory player</li>
      <li class="menu__list-item">Spectate ID</li>
      <li class="menu__list-item">Change player info</li>
      <li class="menu__list-item">Noneat</li>
      <li class="menu__list-item">Kill ID</li>
      <li class="menu__list-item">Get character by ID</li>
      <li class="menu__list-item">Set character by ID</li>
      <li class="menu__list-item">Show vehicle player</li>
      <li class="menu__list-item">Give player vehicle</li>
      <li class="menu__list-item">Take player vehicle</li>
      <li class="menu__list-item">Show player homes</li>
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
}
</style>