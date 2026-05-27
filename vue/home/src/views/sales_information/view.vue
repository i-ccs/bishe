<template>
	<div class="page_user" id="user_address">
		<div class="warp">
			<div class="container">
				<div class="row justify-content-between">
				<!-- 根据权限显示左侧菜单栏 -->
				<div class="col-12 col-md-3" v-if="$check_action('/sales_information/table','get') || $check_action('/registered_user/table','get') || $check_action('/commodity_information/table','get') || $check_action('/supply_information/table','get') || $check_action('/purchasing_information/table','get') || $check_action('/inventory_information/table','get') || $check_action('/collect/list','get') || $check_action('/comment/table','get')">
					<div class="card_menu">
						<!-- 左侧边栏：根据权限显示菜单项 -->
						<list_admin_menu_user></list_admin_menu_user>
					</div>
				</div>
				<!-- 根据权限显示详情/表单区域 -->
				<div class="col-12" :class="$check_action('/sales_information/table','get') || $check_action('/registered_user/table','get') || $check_action('/commodity_information/table','get') || $check_action('/supply_information/table','get') || $check_action('/purchasing_information/table','get') || $check_action('/inventory_information/table','get') || $check_action('/collect/list','get') || $check_action('/comment/table','get') ? 'col-md-9' : ''">
					<div class="card_addres pl-2">
						<!-- 销售信息表单：根据权限显示 -->
						<div v-if="$check_action('/sales_information/view','get')"><span>销售信息</span></div>
						<view_sales_information v-if="$check_action('/sales_information/view','get')"></view_sales_information>
						<!-- 无权限提示 -->
						<div v-else style="text-align: center; padding: 40px 20px; color: #999;">
							<p>您没有权限查看销售信息详情</p>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>


<script>
	import list_admin_menu_user from "@/components/diy/list_admin_menu_user.vue";
	import view_sales_information from "../../components/diy/view_sales_information.vue";
	export default {
		data() {
			return {
			};
		},
		mounted() {
		},
		methods: {
		},
		components: {
			list_admin_menu_user,
			view_sales_information,
		},
	};
</script>

<style scoped>
	.container {
		min-height: 800px;
	}
</style>
