<template>
	<el-main class="bg edit_wrap announcement">
		<el-card class="premium-view-card" shadow="never">
			<div slot="header" class="premium-header">
				<span class="premium-title">{{ form.announcement_id ? '编辑公告' : '发布公告' }}</span>
				<span class="premium-subtitle">发布系统通知、活动提醒或维护公告</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="80px" label-position="top">
				<div class="premium-section-title">公告内容</div>
				<el-row :gutter="20">
					<el-col :xs="24" :sm="24" :lg="24">
						<el-form-item label="公告标题" prop="title">
							<el-input v-model="form.title" placeholder="请输入公告标题" prefix-icon="el-icon-notification"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :lg="24">
						<el-form-item label="正文详情" prop="content">
							<quill-editor v-model="form.content" class="premium-editor"></quill-editor>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="(form['announcement_id'] && $check_action('/announcement/view','set')) || (!form['announcement_id'] && $check_action('/announcement/view','add'))">
						<el-button type="primary" class="premium-btn-submit" @click="submit()" icon="el-icon-check">立即发布</el-button>
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
				"title": "announcement",
				field: "announcement_id",
				url_add: "~/api/announcement/add?",
				url_set: "~/api/announcement/set?",
				url_get_obj: "~/api/announcement/get_obj?",
				query: { announcement_id: 0 },
				form: {
					announcement_id: 0,
					title: "",
					content: ""
				},
			}
		},
		methods: {
			submit_check(params) {
				if (params.title === "") {
					return "标题不能为空";
				}
				if (params.content === "") {
					return "内容不能为空";
				}
				return null;
			},
		}
	}
</script>

<style scoped>
	.premium-editor >>> .ql-container {
		min-height: 400px;
		border-bottom-left-radius: 8px;
		border-bottom-right-radius: 8px;
	}
	.premium-editor >>> .ql-toolbar {
		border-top-left-radius: 8px;
		border-top-right-radius: 8px;
	}
</style>
