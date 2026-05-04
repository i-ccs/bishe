<template>
  <div class="page_announcement announcement-detail" id="announcement_list">
    <div class="warp">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="car_announcement">
              <div class="announcement_list">
                <span>公告</span>
                <div class="announcement_title">
                  <h5>{{ obj.title }}</h5>
                </div>
                <div class="announcement_creat_time">
                  {{ $toTime( obj.create_time,"yyyy-MM-dd hh:mm:ss") }}
                </div>
                <div class="announcement_content" v-html="obj.content"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import mixin from "@/mixins/page.js";
export default {
  mixins: [mixin],
  data() {
    return {
      url_get_obj: "~/api/announcement/get_obj?",
      field: "announcement_id",
      query: {
        announcement_id: 0,
      },
      obj: {},
    };
  },
  methods: {
    /**
     * 获取留言后
     * @param {Object} json 响应对象
     */
    get_obj_after(json) {
      console.log(JSON.stringify(json));
    },
  },
};
</script>

<style scoped>
.page_announcement {
  text-align: center;
}
.container{
  min-height: 600px;
}
.announcement_list >*{
  padding: 10px;
}
.page_announcement > view {
  margin-top: 1rem;
}
.announcement_title{
  margin-top: 20px;

}
.announcement_creat_time{
  color: var(--color_tip);
}
.announcement_content{
  color: var(--color_paragraph);
  text-align: left;
}
</style>
