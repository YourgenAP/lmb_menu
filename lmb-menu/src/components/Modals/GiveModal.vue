<template>
  <div>
    <h3 class="menu__title">Меню выдачи</h3>
    <ul class="menu__list">
      <li class="menu__list-item" @click="{ medModalShow = !medModalShow; getContent($event); }">Выдача оружия</li>
      <li class="menu__list-item" @click="{ smallModalShow = !smallModalShow; getContent($event); }">Выдача здоровья
      </li>
      <li class="menu__list-item">Выдача золотых статов</li>
      <li class="menu__list-item" @click="{ smallModalShow = !smallModalShow; getContent($event); }">Выдача денег</li>
      <li class="menu__list-item" @click="{ medModalShow = !medModalShow; getContent($event); }">Выдача айтемов</li>
    </ul>

    <div id="report_modal" class="med_modal light" :class="{ hidden: medModalShow }">
      <div class="title__container">
        <h3 class="menu__title">{{ actionName }}</h3>
      </div>
      <span id="close" @click="{ medModalShow = true; }">&#10005;</span>
      <div class="input-bottom">
        <input type="text" ref="idPlayer" placeholder="ID игрока" />
        <input type="text" ref="itemName" placeholder="Название предмета" />
        <input type="text" ref="itemCount" placeholder="Кол-во" />
        <div class="button__container">
          <button class="btn" @click="{ createRequest(); }">Отправить</button>
          <img src="../../assets/checkmark.svg" alt="SendIcon" @click="{ createRequest(); }">
        </div>
      </div>
    </div>

    <div id="report_modal" class="small_modal light" :class="{ hidden: smallModalShow }">
      <div class="title__container">
        <h3 class="menu__title">{{ actionName }}</h3>
      </div>
      <span id="close" @click="{ smallModalShow = true; }">&#10005;</span>
      <div class="input-bottom">
        <input type="text" ref="idPlayer_" placeholder="ID игрока" />
        <input type="text" ref="itemCount_" placeholder="Кол-во" />
        <div class="button__container">
          <button class="btn" @click="{ createRequest(); }">Отправить</button>
          <img src="../../assets/checkmark.svg" alt="SendIcon" @click="{ createRequest(); }">
        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  props: { resource: String },
  data() {
    return {
      idPlayer: 0,
      itemName: 'none',
      itemCount: 0,
      idPlayer_: 0,
      itemCount_: 0,
      actionName: '',
      dataObject: {},
      errorMsg: '',
      medModalShow: true,
      smallModalShow: true,
    }
  },

  methods: {
    getContent(event) {
      this.actionName = event.target.innerText;
      this.errorMsg = this.actionName;
    },

    createRequest() {
      this.idPlayer = parseInt(this.$refs.idPlayer.value);
      this.itemName = this.$refs.itemName.value;
      this.itemCount = this.$refs.itemCount.value;

      this.idPlayer_ = this.$refs.idPlayer_.value;
      this.itemCount_ = this.$refs.itemCount_.value;

      switch (this.actionName) {
        case 'Выдача оружия':
          this.dataObject = { playerId: this.idPlayer, itemName: this.itemName, itemCount: this.itemCount };
          break;

        case 'Выдача здоровья':
          this.dataObject = { 'playerId': this.idPlayer_, 'itemCount': this.itemCount_ };
          break;

        case 'Выдача золотых статов':
          console.log(`${this.actionName}`);
          break;

        case 'Выдача денег':
          this.dataObject = { 'playerId': this.idPlayer_, 'itemCount': this.itemCount_ };
          break;

        case 'Выдача айтемов':
          this.dataObject = { 'playerId': this.idPlayer, 'itemName': this.itemName, 'itemCount': this.itemCount };
          break;
      }
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
</style>