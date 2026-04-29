<template>
  <div class="list_menu diy_menu">
    <router-link
            to="/user_center/index"
            class="menu_item"
            :class="{ selected: this.$route.path=== '/user_center/index'}"
     >
      <span class="left_span">个人首页</span>
      <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
    </router-link>
          <router-link
          to="/registered_user/table"
          class="menu_item"
          :class="{ selected: this.$route.path=== '/registered_user/table'}"
          v-if="$check_action('/registered_user/table','get')">
        <span class="left_span">{{ $page_title("/registered_user/table") || 注册用户 }}</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
      </router-link>
              <router-link
          to="/merchandise_information/table"
          class="menu_item"
          :class="{ selected: this.$route.path=== '/merchandise_information/table'}"
          v-if="$check_action('/merchandise_information/table','get')">
        <span class="left_span">{{ $page_title("/merchandise_information/table") || 商品信息 }}</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
      </router-link>
              <router-link
          to="/sales_information/table"
          class="menu_item"
          :class="{ selected: this.$route.path=== '/sales_information/table'}"
          v-if="$check_action('/sales_information/table','get')">
        <span class="left_span">{{ $page_title("/sales_information/table") || 销售信息 }}</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
      </router-link>
              <router-link
          to="/supply_information/table"
          class="menu_item"
          :class="{ selected: this.$route.path=== '/supply_information/table'}"
          v-if="$check_action('/supply_information/table','get')">
        <span class="left_span">{{ $page_title("/supply_information/table") || 供应信息 }}</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
      </router-link>
              <router-link
          to="/purchasing_information/table"
          class="menu_item"
          :class="{ selected: this.$route.path=== '/purchasing_information/table'}"
          v-if="$check_action('/purchasing_information/table','get')">
        <span class="left_span">{{ $page_title("/purchasing_information/table") || 采购信息 }}</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
      </router-link>
              <router-link
          to="/inventory_information/table"
          class="menu_item"
          :class="{ selected: this.$route.path=== '/inventory_information/table'}"
          v-if="$check_action('/inventory_information/table','get')">
        <span class="left_span">{{ $page_title("/inventory_information/table") || 库存信息 }}</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
      </router-link>
      <router-link
              to="/user/collect"
              class="menu_item"
              :class="{ selected: this.$route.path=== '/user/collect'}"
              v-if="$check_action('/collect/list','get')">
        <span class="left_span">收藏</span>
        <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
  </router-link>
	<router-link
	            to="/comment/table"
	            class="menu_item"
	            :class="{ selected: this.$route.path=== '/comment/table'}"
	            v-if="$check_action('/comment/table','get')">
	      <span class="left_span">评论管理</span>
	      <span class="right_span"><b-icon icon="house-fill"></b-icon></span>
	</router-link>
  </div>
</template>

<script>
import mixin from "@/mixins/page.js";
export default {
  mixins: [mixin],
  data() {
    return {
    };
  },
  mounted() {
  },
  methods: {
  },

  components: {
  },
};
</script>

<style scoped>
.list_menu {
  flex: 0 0 25%;
  border-bottom: 1px solid #eee;
}
.menu_item {
  display: flex;
  justify-content: space-between;
  padding: 15px 20px;
  border: 1px solid #eee;
  border-bottom: none;
  background-color: #fff;
}
.menu_item.selected {
  background-color: #000;
}
.menu_item.selected span {
  color: #fff ;
}
.content {
  flex: 0 0 74%;
}
</style>
