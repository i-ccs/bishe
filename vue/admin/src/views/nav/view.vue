<template>
	<el-main class="bg edit_wrap nav">
		<el-card class="premium-view-card" shadow="never">
			<div slot="header" class="premium-header">
				<span class="premium-title">{{ form.nav_id ? '编辑导航项' : '新增导航项' }}</span>
				<span class="premium-subtitle">配置前端门户的导航菜单，支持多层级父子关联与多种跳转方式</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="80px" label-position="top">
				<div class="premium-section-title">菜单基础配置</div>
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="8">
						<el-form-item label="导航名称" prop="name">
							<el-input v-model="form.name" placeholder="显示在菜单上的文字" prefix-icon="el-icon-menu"></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :lg="8">
						<el-form-item label="显示位置" prop="location">
							<el-select v-model="form.location" style="width: 100%">
								<el-option v-for="obj in list_location" :key="obj.value" :label="obj.text" :value="obj.value"></el-option>
							</el-select>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :lg="8">
						<el-form-item label="父级菜单" prop="father_id">
							<el-select v-model="form.father_id" style="width: 100%">
								<el-option :key="-1" label="无 (作为一级菜单)" :value="0"></el-option>
								<el-option v-for="obj in list_nav" :key="obj.nav_id" :label="obj.name" :value="obj.nav_id"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">跳转属性</div>
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="12">
						<el-form-item label="链接地址 (URL)" prop="url">
							<el-input v-model="form.url" placeholder="以 / 或 http(s):// 开头" prefix-icon="el-icon-link"></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :lg="8">
						<el-form-item label="跳转方式" prop="target">
							<el-select v-model="form.target" style="width: 100%">
								<el-option v-for="obj in list_target" :key="obj.value" :label="obj.text" :value="obj.value"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="(form['nav_id'] && $check_action('/nav/view','set')) || (!form['nav_id'] && $check_action('/nav/view','add'))">
						<el-button type="primary" class="premium-btn-submit" @click="submit()" icon="el-icon-check">保存导航配置</el-button>
						<el-button class="premium-btn-cancel" @click="cancel()" icon="el-icon-close">取消</el-button>
					</template>
					<el-button v-else class="premium-btn-cancel" @click="cancel()" icon="el-icon-back">返回</el-button>
				</div>
			</el-form>
		</el-card>
	</el-main>
</template>

<script>
	import mixin from "../../mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				field: "nav_id",
				url_add: "~/api/nav/add?",
				url_set: "~/api/nav/set?",
				url_get_obj: "~/api/nav/get_obj?",
				url_upload: "~/api/nav/upload?",
				query: { nav_id: 0 },
				form: {
					nav_id: 0,
					name: '',
					location: 'top',
					target: "_self",
					url: "",
					father_id: 0
				},
				list_location: [
					{ text: "顶部导航", value: "top" },
					{ text: "侧边导航", value: "side" },
					{ text: "底部导航", value: "foot" }
				],
				list_target: [
					{ text: '新页面 (_blank)', value: "_blank" },
					{ text: '本页面 (_self)', value: "_self" },
					{ text: '父窗口 (_parent)', value: "_parent" },
					{ text: '全窗口 (_top)', value: "_top" }
				],
				list_nav: []
			}
		},
		methods: {
			async get_list_nav() {
				var json = await this.$get("~/api/nav/get_list?");
				if (json.result) { this.list_nav = json.result.list; }
			},
		},
		created() {
			this.get_list_nav();
		}
	}
</script>

<style scoped>
</style>
