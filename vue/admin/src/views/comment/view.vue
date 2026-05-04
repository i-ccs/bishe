<template>
	<el-main class="bg edit_wrap comment">
		<el-card class="premium-view-card" shadow="never">
			<div slot="header" class="premium-header">
				<span class="premium-title">评论详情</span>
				<span class="premium-subtitle">查看及管理用户发布的评论内容与互动详情</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="100px" label-position="top">
				<div v-if="query.reply_to_id" class="premium-section-title">回复对象</div>
				<el-row :gutter="20" v-if="query.reply_to_id">
					<el-col :xs="24" :sm="12">
						<el-form-item label="被回复人">
							<div class="premium-readonly-field">{{reply_obj.nick_name}}</div>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24">
						<el-form-item label="原评论内容">
							<div class="premium-readonly-field" style="height: auto; padding: 15px; line-height: 1.6;">{{reply_obj.content}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">评论/回复内容</div>
				<el-row :gutter="20">
					<el-col :xs="24" :sm="8" v-if="!query.reply_to_id">
						<el-form-item label="用户头像">
							<el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
								action="" :http-request="uploadAvatar" :show-file-list="false">
								<img v-if="form.avatar" :src="$fullUrl(form.avatar)" class="avatar">
								<div v-else class="upload-placeholder">
									<i class="el-icon-plus avatar-uploader-icon"></i>
								</div>
							</el-upload>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="16" v-if="!query.reply_to_id">
						<el-form-item label="用户昵称" prop="nick_name">
							<el-input v-model="form.nick_name" placeholder="请输入昵称" prefix-icon="el-icon-user"></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24">
						<el-form-item label="正文详情" prop="content">
							<quill-editor v-model="form.content" class="premium-editor"></quill-editor>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<el-button class="premium-btn-cancel" @click="cancel()" icon="el-icon-back">返回列表</el-button>
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
				field: "comment_id",
				url_add: "~/api/comment/add?",
				url_set: "~/api/comment/set?",
				url_get_obj: "~/api/comment/get_obj?",
				url_upload: "~/api/comment/upload?",
				query: { comment_id: 0, reply_to_id: 0 },
				form: {
					comment_id: 0,
					avatar: "",
					content: "",
					reply_to_id: 0
				},
				reply_obj: { nick_name: "", content: "" }
			}
		},
		methods: {
			uploadAvatar(param) {
				this.uploadFile(param.file, "avatar");
			},
			async get_obj_comment() {
				if(this.query.reply_to_id){
					var res = await this.$get("~/api/comment/get_obj?comment_id=" + this.query.reply_to_id);
					if (res.result) { this.reply_obj = res.result.obj; }
				}
			},
			get_obj_before(param){
				if(!param.source_id){
					var form = this.form;
					var user = this.user;
					form.reply_to_id = param.reply_to_id || 0;
					form.avatar = user.avatar;
					form.nick_name = user.nick_name;
				}
				return param;
			}
		},
		created() {
			this.get_obj_comment();
		}
	}
</script>

<style scoped>
	.avatar-uploader >>> .el-upload {
		border: 1px dashed #dcdfe6;
		border-radius: 50%;
		cursor: pointer;
		position: relative;
		overflow: hidden;
		transition: all 0.3s;
		width: 120px;
		height: 120px;
	}
	.avatar-uploader >>> .el-upload:hover { border-color: #409EFF; }
	.avatar-uploader >>> .el-upload-dragger { width: 100%; height: 100%; border: none; background: none; display: flex; align-items: center; justify-content: center; }
	.avatar-uploader-icon { font-size: 24px; color: #8c939d; }
	.avatar { width: 100%; height: 100%; display: block; object-fit: cover; }
	.premium-editor >>> .ql-container { min-height: 200px; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px; }
	.premium-editor >>> .ql-toolbar { border-top-left-radius: 8px; border-top-right-radius: 8px; }
</style>
