<template>
  <div>
    <h3 class="menu__title">Управление игроками</h3>
    <ul class="menu__list">
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Add in Whitelist</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Remove from WL</li>
      <li class="menu__list-item" @click="{ isDateModal = !isDateModal; getContent($event); }">Remove from WL by Date
      </li>
      <li class="menu__list-item" @click="{ getContent($event); }">Kick All</li>
      <li class="menu__list-item" @click="{ isMiddleModal = !isMiddleModal; getContent($event); }">Kick</li>
      <li class="menu__list-item" @click="{ isMiddleModal = !isMiddleModal; getContent($event); }">Ban</li>
      <li class="menu__list-item" @click="{ isMiddleModal = !isMiddleModal; getContent($event); }">Permanently Ban</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Unban</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Clear ID</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Clear inventory by ID
      </li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Clear trunks by ID</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Revive</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Show player groups</li>
      <li class="menu__list-item">Remove player groups</li>
      <li class="menu__list-item" @click="{ isMiddleModal = !isMiddleModal; getContent($event); }">Send ticket to player
      </li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Show player works</li>
      <li class="menu__list-item">Remove player works</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Show bank player</li>
    </ul>
  </div>

  <div id="report_modal" class="med_modal light" :class="{ hidden: isMiddleModal }">
    <div class="title__container">
      <h3 class="menu__title">{{ isContent }}</h3>
    </div>
    <span id="close" @click="{ isMiddleModal = true; }">&#10005;</span>
    <div class="input-bottom">
      <input type="text" placeholder="ID" />
      <input type="text" placeholder="Reason" />
      <div class="button__container">
        <button class="btn" @click="{ createRequest(); }">Отправить</button>
        <img src="../../assets/checkmark.svg" alt="SendIcon" @click="{ createRequest(); }">
      </div>
    </div>
  </div>

  <div id="report_modal" class="small_modal light" :class="{ hidden: isSmallModal }">
    <div class="title__container">
      <h3 class="menu__title">{{ isContent }}</h3>
    </div>
    <span id="close" @click="{ isSmallModal = true; }">&#10005;</span>
    <div class="input-bottom">
      <input type="text" placeholder="ID игрока" />
      <div class="button__container">
        <button class="btn" @click="{ createRequest(); }">Отправить</button>
        <img src="../../assets/checkmark.svg" alt="SendIcon" @click="{ createRequest(); }">
      </div>
    </div>
  </div>

  <div id="report_modal" class="small_modal light" :class="{ hidden: isDateModal }">
    <div class="title__container">
      <h3 class="menu__title">{{ isContent }}</h3>
    </div>
    <span id="close" @click="{ isDateModal = true; }">&#10005;</span>
    <div class="input-bottom">
      <input type="date" placeholder="Date" />
      <div class="button__container">
        <button class="btn" @click="{ createRequest(); }">Отправить</button>
        <img src="../../assets/checkmark.svg" alt="SendIcon" @click="{ createRequest(); }">
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isContent: 'none',
      nameAction: 'none',
      isSmallModal: true,
      isMiddleModal: true,
      isDateModal: true,
    }
  },

  methods: {
    getContent(event) {
      this.isContent = event.target.innerText;
    }
  }
};
</script>

<style scoped>
.menu__list {
  height: 360px;
  overflow-y: auto;
}

.med_modal {
  display: flex;
  min-width: 270px;
}

.small_modal {
  display: flex;
  min-width: 270px;
}

.input-bottom {
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  margin-top: 10px;
}


#report_modal.med_modal input {
  width: 295px;
  padding: 10px 15px;
  margin: 0px 0px 8px;

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

#report_modal.small_modal input {
  width: 295px;
  padding: 10px 15px;
  margin: 0px 0px 8px;

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

.med_modal input::placeholder {
  font-family: "HapnaSlab-Serif";
  color: rgba(255, 255, 255, 0.85);
}

.small_modal input::placeholder {
  font-family: "HapnaSlab-Serif";
  color: rgba(255, 255, 255, 0.85);
}

#report_modal.med_modal .title__container {
  padding: 35px 0px 10px;
}

#report_modal.small_modal .title__container {
  padding: 35px 0px 10px;
}

#report_modal.small_modal .button__container {
  margin: 0 auto;
  padding: 20px 0px 25px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}

#report_modal.med_modal .button__container {
  margin: 0 auto;
  padding: 20px 0px 25px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}

#report_modal.small_modal .button__container button {
  padding: 10px 30px;

  border: none;
  cursor: pointer;
  border-radius: 8px 0px 0px 8px;
  background-color: rgba(59, 59, 59, 0.5);

  color: rgba(255, 255, 255, 0.65);
  font-family: "RDRLino-Regular";
}

#report_modal.small_modal .button__container img {
  margin-left: 2px;
  padding: 10px;

  border: none;
  cursor: pointer;
  border-radius: 0px 8px 8px 0px;
  background-color: rgba(59, 59, 59, 0.5);

  color: rgba(255, 255, 255, 0.65);
  font-family: "RDRLino-Regular";
}

#report_modal.med_modal .button__container button {
  padding: 10px 30px;

  border: none;
  cursor: pointer;
  border-radius: 8px 0px 0px 8px;
  background-color: rgba(59, 59, 59, 0.5);

  color: rgba(255, 255, 255, 0.65);
  font-family: "RDRLino-Regular";
}

#report_modal.med_modal .button__container img {
  margin-left: 2px;
  padding: 10px;

  border: none;
  cursor: pointer;
  border-radius: 0px 8px 8px 0px;
  background-color: rgba(59, 59, 59, 0.5);

  color: rgba(255, 255, 255, 0.65);
  font-family: "RDRLino-Regular";
}

.med_modal #close {
  top: 9px;
  left: 245px;
}

.small_modal #close {
  top: 9px;
  left: 245px;
}

.menu__list-item:last-child {
  border-bottom: none;
}

.menu__list-item:last-child:hover {
  border-radius: 0px 0px 20px 20px;
  border-bottom: none;
}

.small_modal input[type="date"]::-webkit-inner-spin-butto {
  display: none;
}

.small_modal input[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0;
}

.small_modal input[type="date"]::-webkit-calendar-picker-indicator:hover {
  cursor: pointer;
}

.small_modal input[type="date"] {
  background: rgba(255, 255, 255, 0.3) url('../../assets/calendar.png') 94% no-repeat;
}
.menu__list-item:last-child {
  border-bottom: none;
}

.menu__list-item:last-child:hover {
  border-radius: 0px 0px 20px 20px;
}
</style>