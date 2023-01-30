<template>
  <div>
    <h3 class="menu__title">Телепорт</h3>
    <ul class="menu__list teleport_menu">
      <li class="menu__list-item">Тп на метку</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Тп к игроку</li>
      <li class="menu__list-item" @click="{ isSmallModal = !isSmallModal; getContent($event); }">Тп к себе</li>
      <li class="menu__list-item" @click="{ isMiddleModal = !isMiddleModal; getContent($event); }">Тп по координатам
      </li>
    </ul>
  </div>

  <div id="report_modal" class="med_modal light" :class="{ hidden: isMiddleModal }">
    <span id="close" @click="{ isMiddleModal = true; }">&#10005;</span>
    <div class="title__container">
      <h3 class="menu__title">{{ isContent }}</h3>
    </div>
    <div class="input-bottom">
      <input type="text" placeholder="X" />
      <input type="text" placeholder="Y" />
      <input type="text" placeholder="Z" />
      <div class="button__container">
        <button class="btn" @click="{ createRequest(); }">Отправить</button>
        <img src="../../assets/checkmark.svg" alt="SendIcon" @click="{ createRequest(); }">
      </div>
    </div>
  </div>

  <div id="report_modal" class="small_modal light" :class="{ hidden: isSmallModal }">
    <span id="close" @click="{ isSmallModal = true; }">&#10005;</span>
    <div class="title__container">
      <h3 class="menu__title">{{ isContent }}</h3>
    </div>
    <div class="input-bottom">
      <input type="text" placeholder="ID игрока" />
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
      isSmallModal: true,
      isMiddleModal: true,
      isContent: 'none',
      nameAction: 'none'
    };
  },

  methods: {
    getContent(event) {
      this.isContent = event.target.innerText;
    },

    createRequest(event) {
      console.log(event)
    }
  }
};

</script>

<style scoped>
.med_modal {
  display: flex;
  min-width: 290px;
}

.small_modal {
  display: flex;
  min-width: 290px;
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
  top: 25px;
  left: 250px;
}

.small_modal #close {
  top: 14px;
  left: 250px;
}

.menu__list-item:last-child {
  border-bottom: none;
}

.menu__list-item:last-child:hover {
  border-radius: 0px 0px 20px 20px;
}
</style>