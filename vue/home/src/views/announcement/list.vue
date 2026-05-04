<template>
  <div class="page_announcement" id="announcement_list">
    <div class="warp">
      <div class="container">
        <div class="left_box">
            <span></span>
            <span></span>
            <span></span>
          </div>
        <div class="row">
          <div class="col-12">
            <div class="car_announcement">
              <!-- 公告列表 -->
              <div class="announcement_list">
                <div class="announcement_list_title">
                  <span class="title">{{$page_title("/announcement/list") || "公告列表"}}</span>
                </div>
                <router-link
                  class="announcement_block"
                  v-for="(o, i) in list"
                  :key="i"
                  :to="'/announcement/details?' + 'announcement_id' + '=' + o.announcement_id"
                >
                  <div class="announcement_title ellipsis_2">
                    {{ o.title }}
                  </div>
                  <div class="announcement_create_time">
                    {{ o.create_time| formatDate }}
                  </div>
                </router-link>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <!-- 分页器 -->
          <div class="col overflow-auto flex_cc">
            <b-pagination
                v-model="query.page"
                :total-rows="count"
                :per-page="query.size"
                @change="goToPage"
            />
          </div>
        </div>
        <div class="right_box">
            <span></span>
            <span></span>
            <span></span>
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
      url_get_list: "~/api/announcement/get_list",
      list: [],
      query: {
        title: "",
        page: 1,
        size: 10,
      },
      // 页面数
      count_pages: 1,
    };
  },
  methods: {
    /**
     * 获取公告后
     * @param {Object} json 响应对象
     */
    get_list_after(json) {
      this.count_pages = Math.ceil(json.result.count / this.query.size);
    },
    goToPage(v){
      this.query.page = v;
      this.goToNew(v)
    }
  },
};
</script>

<style scoped>
.flex_cc {
  display: flex;
  justify-content: center;
  align-items: center;
}
.ellipsis_2 {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.container {
  min-height: 800px;
}
.announcement_block {
  display: flex;
  justify-content: space-between;
  padding: 10px;
  margin: 5px;
}
.announcement_title {
  text-overflow: ellipsis;
  white-space: nowrap;
}
  .announcement_list_title{
    margin: 0 0.5rem;
    background-color: #d2d2d2;
    color: white;
    display: flex;
    height: 4rem;
    align-items: center;
    justify-content: space-between;
    border-radius: 0.5rem;
  }
.title {
  font-size: 1.5rem;
  font-weight: bold;
  padding-left: 1rem;
}
</style>
