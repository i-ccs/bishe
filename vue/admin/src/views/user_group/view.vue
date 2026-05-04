<template>
	<el-main class="bg edit_wrap">
		<el-card class="premium-view-card" shadow="never">
			<div slot="header" class="premium-header">
				<span class="premium-title">{{ form.group_id ? '编辑用户组' : '新增用户组' }}</span>
				<span class="premium-subtitle">配置系统权限组及其基础属性，支持设置显示优先级</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="100px" label-position="top">
				<div class="premium-section-title">基础属性</div>
				<el-row :gutter="30">
					<el-col :xs="24" :sm="14" :lg="12">
						<el-form-item label="用户组名称" prop="name">
							<el-input v-model="form.name" placeholder="请输入唯一的用户组名称" prefix-icon="el-icon-user-solid"></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="10" :lg="8">
						<el-form-item label="显示优先级" prop="display">
							<el-input-number v-model="form.display" :min="0" :max="999" style="width: 100%"></el-input-number>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col :xs="24" :sm="24" :lg="20">
						<el-form-item label="职能描述" prop="description">
							<el-input type="textarea" :rows="5" v-model="form.description" placeholder="请详细描述该用户组的职能与权限范围..."></el-input>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="user_group == '管理员' || (form['group_id'] && $check_action('/user_group/view','set')) || (!form['group_id'] && $check_action('/user_group/view','add'))">
						<el-button type="primary" class="premium-btn-submit" @click="submit()" icon="el-icon-check">提交保存</el-button>
						<el-button class="premium-btn-cancel" @click="cancel()" icon="el-icon-close">取消</el-button>
					</template>
					<el-button v-else class="premium-btn-cancel" @click="cancel()" icon="el-icon-back">返回</el-button>
				</div>
			</el-form>
		</el-card>
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				field: "group_id",
				url_add: "~/api/user_group/add?",
				url_set: "~/api/user_group/set?",
				url_get_obj: "~/api/user_group/get_obj?",
				url_upload: "~/api/user_group/upload?",
				query: { group_id: 0 },
				form: {
					group_id: 0,
					name: '',
					display: 100,
					description:""
				}
			}
		},
		methods: {
			uploadimg(param) {
				this.uploadFile(param.file, "icon");
			},
		}
	}
</script>

<style scoped>
</style>
