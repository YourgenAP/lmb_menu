<template>
  <div class="main__wrapper">
    <div id="wrapper">

      <h3 class="menu__title" :class="{ hidden: tabShow }">Меню</h3>
      <span id="close" @click="{ createRequestToClose(); }">&#10005;</span>

      <TabsWrapper :class="{ hidden: tabShow }">
        <Tab title="Основное">
          <ul class="menu__list">
            <li class="menu__list-item" @click="{ charShow = !charShow; }">
              <span>Персонаж</span>
            </li>
            <ul id="character_info" class="additional" :class="{ hidden: charShow }">
              <li class="menu__list-item">- Имя: {{ playerInfo.firstname }}</li>
              <li class="menu__list-item">- Фамилия: {{ playerInfo.secondname }}</li>
              <li class="menu__list-item">- Дата рождения: {{ playerInfo.birthday }}</li>
              <li class="menu__list-item">- Рег. номер: {{ playerInfo.regNumber }}</li>
            </ul>
            <li class="menu__list-item" id="anim" @click="{ animShow = false; tabShow = true; }">
              <span>Анимации</span>
            </li>
            <li class="menu__list-item" id="walk" @click="{ walkShow = false; tabShow = true; }">
              <span>Походки</span>
            </li>
            <li class="menu__list-item" id="inter" @click="{ interShow = false; tabShow = true; }">
              <span>Взаимодействие</span>
            </li>
            <li class="menu__list-item" id="sett" @click="{ settShow = false; tabShow = true; }">
              <span>Настройки</span>
            </li>
            <li class="menu__list-item" id="report" @click="{ repShow = false; }">
              <span>Репорт</span>
            </li>
          </ul>
        </Tab>

        <!-- <Tab title="Админ" v-if="this.playerInfo.isAdmin">
          <ul class="menu__list">
            <li class="menu__list-item" @click="createRequestToControlNames()">
              <span>Names</span>
            </li>
            <li class="menu__list-item" @click="createRequestToGiveModal()">
              <span>Меню выдачи</span>
            </li>
            <li class="menu__list-item" @click="createRequestToCallModal()">
              <span>Меню вызовов</span>
            </li>
          </ul>
        </Tab> -->
      </TabsWrapper>

      <div id="modal_main" class="modal">
        <div id="anim_modal" :class="{ hidden: animShow }">
          <LeftOutlined id="back" class="back_btn" @click="{ animShow = true; tabShow = false; }" />
          <h3 class="menu__title">Анимации</h3>
          <div class="top-sector"></div>
          <div class="anim_list">
            <AnimList :resource="resource" />
          </div>
        </div>

        <div id="walk_modal" :class="{ hidden: walkShow }">
          <LeftOutlined id="back" class="back_btn" @click="{ walkShow = true; tabShow = false; }" />
          <h3 class="menu__title">Походки</h3>
          <ul class="menu__list">
            <li class="menu__list-item" v-for="(item, index) in walks" :key="item"
              @click="createRequestToSetWalks(walks[index])">{{ walks[index].walksname }}</li>
          </ul>
        </div>

        <div id="inter_modal" :class="{ hidden: interShow }">
          <LeftOutlined id="back" class="back_btn" @click="{ interShow = true; tabShow = false; }" />
          <h3 class="menu__title">Взаимодействие</h3>
          <ul class="menu__list">
            <li class="menu__list-item" v-for="inter_item in interaction" :key="inter_item.id"
              @click="createIteraction(inter_item)">{{ inter_item.value }}
            </li>
          </ul>
        </div>

        <div id="sett_modal" :class="{ hidden: settShow }">
          <LeftOutlined id="back" class="back_btn" @click="{ settShow = true; tabShow = false; }" />
          <h3 class="menu__title">Настройки</h3>
          <ul class="menu__list">
            <li class="menu__list-item" v-for="sett_item in settings" :key="sett_item.id"
              @click="createSettings(sett_item)">{{ sett_item.value }}</li>
            <!-- <li class="menu__list-item" @click="{ themeShow = !themeShow; }">
              <span>Изменить тему</span>
              <button id="theme_btn" class="list__btn">></button>
            </li>
            <ul id="theme_area" class="additional" :class="{ hidden: themeShow }">
              <label>Насыщенность:</label>
              <input type="range" id="range" min="20" max="90" v-model="range" />
            </ul> -->
          </ul>
        </div>

        <div id="report_modal" class="light" :class="{ hidden: repShow }">
          <div class="title__container">
            <h3 class="menu__title">Репорт</h3>
            <label id="desc" for="report_input">Кратко опишите вашу проблему</label>
          </div>
          <span id="close" @click="{ repShow = true; }">&#10005;</span>
          <div class="rep__container">
            <!-- <label for="report-content">{{ report.length }} / 256</label> -->
            <textarea name="report-content" id="report-content" ref="report" cols="30" rows="10"
              v-model="report"></textarea>
          </div>
          <div class="button-container">
            <button type="submit" @click="{ repShow = true; createReport(); }">Отправить</button>
            <img src="../assets/send.svg" alt="SendIcon" @click="{ repShow = true; createReport(); }">
          </div>
        </div>

        <div id="report_modal" class="light" :class="{ hidden: policeShow }">
          <div class="title__container">
            <h3 class="menu__title">Вызов шерифов</h3>
            <label id="desc" for="report_input">Опишите вашу ситуацию</label>
          </div>
          <span id="close" @click="{ policeShow = true; }">&#10005;</span>
          <div class="rep__container">
            <!-- <label for="report-content">{{ report.length }} / 256</label> -->
            <textarea name="report-content" id="report-content" ref="report" cols="30" rows="10"
              v-model="callPolice"></textarea>
          </div>
          <div class="button-container">
            <button type="submit" @click="{ policeShow = true; createCallPolice(); }">Отправить</button>
            <img src="../assets/send.svg" alt="SendIcon" @click="{ policeShow = true; createCallPolice(); }">
          </div>
        </div>

        <div id="report_modal" class="light" :class="{ hidden: doctorShow }">
          <div class="title__container">
            <h3 class="menu__title">Вызов докторов</h3>
            <label id="desc" for="report_input">Опишите вашу ситуацию</label>
          </div>
          <span id="close" @click="{ doctorShow = true; }">&#10005;</span>
          <div class="rep__container">
            <!-- <label for="report-content">{{ report.length }} / 256</label> -->
            <textarea name="report-content" id="report-content" ref="report" cols="30" rows="10"
              v-model="callDoctor"></textarea>
          </div>
          <div class="button-container">
            <button type="submit" @click="{ doctorShow = true; createCallDoctor(); }">Отправить</button>
            <img src="../assets/send.svg" alt="SendIcon" @click="{ doctorShow = true; createCallDoctor(); }">
          </div>
        </div>


        <div id="brend_footer" :class="{ hidden: footerShow }">
          <h3 class="brend__title">Lambda RDR</h3>
        </div>

        <div id="give_modal" :class="{ hidden: giveShow }">
          <LeftOutlined id="back" class="back_btn"
            @click="{ footerShow = !footerShow; giveShow = !giveShow; tabShow = !tabShow; }" />
          <GiveModal :resource="resource" />
        </div>

        <div id="inter-adm_modal" :class="{ hidden: interAdmShow }">
          <LeftOutlined id="back" class="back_btn"
            @click="{ footerShow = !footerShow; interAdmShow = !interAdmShow; tabShow = !tabShow; }" />
          <InterAdmModal />
        </div>

        <div id="player-manage_modal" :class="{ hidden: playerManageShow }">
          <LeftOutlined id="back" class="back_btn"
            @click="{ footerShow = !footerShow; playerManageShow = !playerManageShow; tabShow = !tabShow; }" />
          <PlayerManageModal />
        </div>

        <div id="veh-manage_modal" :class="{ hidden: vehManageShow }">
          <LeftOutlined id="back" class="back_btn"
            @click="{ footerShow = !footerShow; vehManageShow = !vehManageShow; tabShow = !tabShow; }" />
          <VehManageModal />
        </div>

        <div id="teleport_modal" :class="{ hidden: telepShow }">
          <LeftOutlined id="back" class="back_btn"
            @click="{ footerShow = !footerShow; telepShow = !telepShow; tabShow = !tabShow; }" />
          <TeleportModal />
        </div>

        <div id="event_modal" :class="{ hidden: eventMenuShow }">
          <LeftOutlined id="back" class="back_btn"
            @click="{ footerShow = !footerShow; eventMenuShow = !eventMenuShow; tabShow = !tabShow; }" />
          <EventMenuModal />
        </div>

      </div>
    </div>
  </div>
</template>

<script>
/* components */
import TabsWrapper from "./TabsWrapper.vue";
import Tab from "./Tab.vue";
import AnimList from "./AnimList.vue";
import GiveModal from "./Modals/GiveModal.vue";
import InterAdmModal from "./Modals/InterAdmModal.vue";
import PlayerManageModal from "./Modals/PlayerManageModal";
import VehManageModal from "./Modals/VehManageModal.vue";
import TeleportModal from "./Modals/TeleportModal.vue";
import EventMenuModal from "./Modals/EventMenuModal.vue";

/* data */
import walks from '../data/walks.json';

/* icons */
import { LeftOutlined } from '@ant-design/icons-vue';

export default {
  props: { resource: String, player: Object, isAdmin: Boolean },
  components: {
    TabsWrapper,
    Tab,
    AnimList,
    GiveModal,
    InterAdmModal,
    PlayerManageModal,
    VehManageModal,
    TeleportModal,
    EventMenuModal,
    LeftOutlined
  },

  data() {
    return {
      report: '',
      callPolice: '',
      callDoctor: '',
      walks: walks.walks,
      playerInfo: {
        firstname: this.player.playerName,
        secondname: this.player.playerSurname,
        regNumber: this.player.regNumber,
        birthday: this.player.playerDob,
        isAdmin: this.isAdmin
      },

      interaction: [
        { id: 0, value: "Связать руки" },
        { id: 1, value: "Обыскать" },
        { id: 2, value: "Развязать руки" },
        { id: 3, value: "Вызов шерифов" },
        { id: 4, value: "Вызов медиков" }
      ],

      settings: [
        { id: 0, value: "Вкл/Выкл миникарту" },
        { id: 1, value: "Вкл/Выкл 3D маркера" },
        { id: 2, value: "Изменить режим походки" },
        { id: 3, value: "Перезагрузить войс" },
        // { id: 4, value: "Перезагрузить хэш-персонажа" },
      ],

      admins: [
        { id: 0, value: "Noclip" },
        { id: 1, value: "Names" },
        { id: 2, value: "Игроки на карте" },
        { id: 3, value: "Координаты" },
        { id: 4, value: "Список игроков" },
      ],

      range: 5,
      walkShow: true,
      interShow: true,
      settShow: true,
      repShow: true,
      policeShow: true,
      doctorShow: true,
      tabShow: false,
      charShow: true,
      themeShow: true,
      animShow: true,
      giveShow: true,
      interAdmShow: true,
      playerManageShow: true,
      vehManageShow: true,
      telepShow: true,
      eventMenuShow: true,
      clothesShow: true,
      footerShow: false
    };
  },

  methods: {
    createReport() {
      if (this.report.length <= 0 || !this.report) {
        this.repShow = !this.repShow;
      } else {
        fetch(`https://${this.resource}/create-report`, {
          method: 'POST',
          body: JSON.stringify({ reportContent: this.report })
        })

        this.report = '';
      }
    },

    createIteraction(interaction) {
      switch (interaction.id) {
        case 0:
          fetch(`https://${this.resource}/cuff-player`, {
            method: 'POST',
          })
          break;

        case 1:
          fetch(`https://${this.resource}/search-player`, {
            method: 'POST',
          })
          break;

        case 2:
          fetch(`https://${this.resource}/uncuff-player`, {
            method: 'POST',
          })
          break;

        case 3:
          this.policeShow = !this.policeShow;
          break;

        case 4:
          this.doctorShow = !this.doctorShow;
          break;

        default:
          console.log('I`m into default!');
          break;
      }
    },

    createCallPolice() {
      fetch(`https://${this.resource}/create-custom-call-police`, {
        method: 'POST',
        body: JSON.stringify({ reasonCall: this.callPolice })
      })

      this.callPolice = '';
    },

    createCallDoctor() {
      fetch(`https://${this.resource}/create-custom-call-doctor`, {
        method: 'POST',
        body: JSON.stringify({ reasonCall: this.callDoctor })
      })

      this.callDoctor = '';
    },

    createSettings(settings) {
      switch (settings.id) {
        case 0:
          fetch(`https://${this.resource}/set-settings-control-map`, {
            method: 'POST',
          })
          break;

        case 1:
          fetch(`https://${this.resource}/set-settings-control-markers`, {
            method: 'POST',
          })
          break;

        case 2:
          fetch(`https://${this.resource}/set-settings-control-walk`, {
            method: 'POST',
          })
          break;

        case 3:
          fetch(`https://${this.resource}/set-settings-refresh-voice`, {
            method: 'POST',
          })
          break;

        // case 4:
        //   fetch(`https://${this.resource}/set-settings-refresh-player`, {
        //     method: 'POST',
        //   })
        //   break;

        default:
          console.log('I`m into default!');
          break;
      }
    },

    createRequestToClose() {
      fetch(`https://${this.resource}/request-to-close`, {
        method: 'POST'
      })
    },

    createRequestToSetWalks(param) {
      fetch(`https://${this.resource}/set-player-walk`, {
        method: 'POST',
        body: JSON.stringify({ walk: param })
      })
    },

    createRequestToControlNames() {
      fetch(`https://${this.resource}/request-to-control-names`, {
        method: 'POST',
      })
    },

    createRequestToGiveModal() {
      fetch(`https://${this.resource}/request-to-open-give-modal`, {
        method: 'POST',
      })
    },

    createRequestToCallModal() {
      fetch(`https://${this.resource}/request-to-open-call-modal`, {
        method: 'POST',
      })
    },
  },

  computed: {
    bgColor() {
      return {
        "background-color": "rgba(0, 0, 0, 0." + this.range + ")",
      };
    },
  }
};
</script>

<style>
::-webkit-scrollbar {
  width: 4px;
  padding: 0px 2px;
}

/* Track */
::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0);
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: rgba(148, 138, 138, 0.4);
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 0, 0, 0);
}

@font-face {
  font-family: "HapnaSlab-Serif";
  src: url("../fonts/HapnaSlabSerif-DemiBold.ttf") format("truetype");
  font-style: normal;
  font-weight: normal;
}

@font-face {
  font-family: "RDRLino-Regular";
  src: url("../fonts/RDRLino-Regular.ttf") format("truetype");
  font-style: normal;
  font-weight: normal;
}

.main__wrapper {
  width: 300px;
  height: auto;
  margin: 0;

  position: absolute;
  z-index: 9999;

  display: flex;
  flex-direction: column;
  justify-content: space-between;

  border-radius: 20px;
  background: linear-gradient(-45deg, rgba(0, 0, 0, 0) 36.51%, rgba(148, 138, 138, 0.25) 100%), rgba(0, 0, 0, 0.9);
  box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.35);
}

.menu__title {
  padding: 23px 80px;
  margin: 0;

  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

  text-align: center;
  font-family: "RDRLino-Regular";
  font-style: normal;
  font-weight: 400;
  font-size: 20px;

  color: #FFFFFF;
  background: rgba(148, 138, 138, 0.15);
  box-sizing: border-box;
  border-bottom: 2px solid rgba(255, 255, 255, 0.05);
  border-radius: 20px 20px 0px 0px;
  box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.35);
  text-shadow: 0px 0px 39px rgba(0, 0, 0, 0.45);
}

.tab__content {
  height: 260px;
  overflow-y: auto;
}

#brend_footer .brend__title {
  padding: 25px 80px;
  margin: 0;

  font-family: "RDRLino-Regular";
  font-style: normal;
  font-weight: 400;
  font-size: 14px;

  text-align: center;
  color: rgba(255, 255, 255, 0.65);
  background: rgba(0, 0, 0, 0);
}

.menu__list {
  margin: 0;
  padding: 0px;

  /* height: 370px; */
  overflow-y: auto;

  text-decoration: none;
  list-style: none;
}

#character_info .menu__list-item {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  padding: 11px 0px 11px 25px;
  border-top: 1px solid rgba(255, 255, 255, 0.15);
  color: rgba(255, 255, 255, 0.65);
}

#character_info .menu__list-item:last-child {
  border-bottom: none;
}

.menu__list-item {
  display: flex;
  justify-content: space-between;
  padding: 20px 0px 20px 25px;
  border-top: 1px solid rgba(255, 255, 255, 0.15);
  color: rgba(255, 255, 255, 0.65);
}

.menu__list-item:hover {
  cursor: pointer;
  color: #FFFFFF;
  background: rgba(148, 138, 138, 0.65);
  text-shadow: 0px 0px 20px rgba(0, 0, 0, 0.25);
}

.menu__list-item:first-child {
  border-top: 1px solid rgba(255, 255, 255, 0.15);
}

.menu__list-item:last-child {
  border-bottom: 1px solid rgba(255, 255, 255, 0.15);
}

.list__btn {
  border: none;
  background: none;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.65);
}

.hidden {
  display: none !important;
  padding: 0;
}

.unhidden {
  display: flex;
}

.menu__sector {
  display: flex;
}

.menu__sector-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  width: 100%;
  border-top: 1px solid rgba(255, 255, 255, 0.15);
}

.additional {
  padding-left: 20px;
}

#close {
  position: absolute;
  padding: 6px 10px;

  top: 16px;
  left: 245px;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.35);

  background: rgba(255, 255, 255, 0.06);
  border-radius: 8px;
  cursor: pointer;
}

#back {
  position: absolute;
  padding: 8px 9px;

  top: 17px;
  left: 23px;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.65);

  background: rgba(255, 255, 255, 0.06);
  border-radius: 8px;
  cursor: pointer;
}

#report_modal {
  position: absolute;
  padding: 0px 40px;
  top: 100px;
  left: 330px;
  width: 290px;

  display: flex;
  flex-direction: column;
  align-items: flex-start;

  border-radius: 20px;
  background: linear-gradient(-45deg, rgba(0, 0, 0, 0) 36.51%, rgba(148, 138, 138, 0.25) 100%), rgba(0, 0, 0, 0.9);
  box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.35);
}

#report_modal .title__container {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
  padding: 35px 0px 20px;
}

#report_modal #close {
  position: absolute;
  padding: 6px 10px;

  top: 30px;
  left: 305px;
  font-size: 14px;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.45);

  background: rgba(255, 255, 255, 0.06);
  border-radius: 8px;
  cursor: pointer;
}


#report_modal .menu__title {
  padding: 0px;
  margin: 0;

  display: flex;
  flex-direction: column;

  text-align: center;
  font-family: "RDRLino-Regular";
  font-style: normal;
  font-weight: 400;
  font-size: 24px;

  color: #FFFFFF;
  background: rgba(148, 138, 138, 0);
  box-sizing: border-box;
  border: none;
  box-shadow: none;
  text-shadow: none;
}

#report_modal label {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.65);
}

#report_modal .rep__container {
  position: relative;
}

#report_modal .rep__container label {
  position: absolute;
  left: 235px;
  top: 115px;

  font-family: 'RDRLino-Regular';
  font-style: normal;
  font-weight: 400;
  font-size: 13px;
  color: rgba(255, 255, 255, 0.65);
}

#report_modal textarea {
  padding: 12px 15px;
  width: 295px;
  height: 140px;

  outline: none;
  resize: none;

  font-family: "HapnaSlab-Serif";
  font-style: normal;
  font-weight: 400;
  font-size: 16px;
  color: rgba(255, 255, 255, 0.85);

  background: linear-gradient(224.05deg, rgba(0, 0, 0, 0) 36.51%, rgba(148, 138, 138, 0.05) 100%), rgba(255, 255, 255, 0.02);
  border-radius: 6px;
  box-sizing: border-box;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.35);
}

.report__input {
  width: 230px;
  padding: 8px 10px;
  margin: 4px 15px;

  outline: none;
  border: none;
  border-radius: 8px;
  background: rgba(59, 59, 59, 0.5);

  font-size: 14px;
  font-family: "RDRLino-Regular";
  color: rgba(255, 255, 255, 0.65)
}

#report_modal .button-container {
  margin: 0 auto;
  padding: 20px 0px 25px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}

#report_modal .button-container button {
  padding: 10px 30px;

  border: none;
  cursor: pointer;
  border-radius: 8px 0px 0px 8px;
  background-color: rgba(59, 59, 59, 0.5);

  color: rgba(255, 255, 255, 0.65);
  font-family: "RDRLino-Regular";
}

#report_modal .button-container img {
  margin-left: 2px;
  padding: 11px;

  border: none;
  cursor: pointer;
  border-radius: 0px 8px 8px 0px;
  background-color: rgba(59, 59, 59, 0.5);

  color: rgba(255, 255, 255, 0.65);
  font-family: "RDRLino-Regular";
}

#theme_area {
  padding: 10px;
}

#range::-webkit-slider-thumb {
  appearance: none;
  background: black;
  width: 15px;
  height: 15px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 5px;
}

.input_area {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.input_area label {
  padding: 20px 0px 5px;
  font-size: 15px;
}

#report_modal .input_area button:hover {
  background-color: rgba(70, 70, 70, 0.5);
}

.light {
  background-color: rgba(0, 0, 0, 0.35);
}

.search {
  width: 260px;
  padding: 5px 10px;
  margin: 5px 10px 10px;

  outline: none;
  border: none;
  border-radius: 5px;
  background: rgba(255, 255, 255, 0.3);

  font-size: 14px;
  font-family: "RDRLino-Regular";
  color: rgba(230, 230, 230, 0.8);
}

.search::placeholder {
  color: rgba(255, 255, 255, 0.445);
}

.top-sector {
  display: flex;
  justify-content: space-around;
  margin-bottom: 5px;
}

#walk_modal .menu__list {
  height: 360px;
  overflow-y: auto;
}
</style>