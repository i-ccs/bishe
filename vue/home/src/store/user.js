export default {
  state() {
    return {
      "user_id": 0,
      "token": "",
      "user_name": "",
      "referee_id": 0,
      "vip": 0,
      "gm": 0,
      "mc": 0,
      "phone": "",
      "phone_state": 0,
      "email": "",
      "email_state": 0,
      "login_ip": "",
      "login_time": "",
      "user_group": "",
      "user_admin": "",
      "signature": "",
      "nick_name": "",
      "avatar": "/img/avatar.png",
      "invite_code": "",
      "friends": "",
      "state": 0
    }
  },
  mutations: {
    user_set(state, obj) {
      for (var k in obj) {
        state[k] = obj[k];
      }
      if (obj.token) {
        $.db.set("token", obj.token, 120);
		$.db.set("user_group", obj.user_group, 120);
      }
    },
    sign_out(state) {
      $.db.del("token");
	  $.db.del("user_group");
      state.token = null;
      state.user_name = null;
      state.user_id = 0;
    }
  }
}
