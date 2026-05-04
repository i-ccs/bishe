<template>
	<el-main class="bg edit_wrap article">
		<el-card class="premium-view-card" shadow="never">
			<div slot="header" class="premium-header">
				<span class="premium-title">{{ form.article_id ? '编辑文章' : '新增文章' }}</span>
				<span class="premium-subtitle">撰写并发布系统文章，支持图文并茂的编辑器内容</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="80px" label-position="top">
				<div class="premium-section-title">文章属性</div>
				<el-row :gutter="20">
					<el-col :xs="24" :sm="24" :lg="8">
						<el-form-item label="封面图" prop="img">
							<el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
								action="" :http-request="uploadImg" :show-file-list="false">
								<img v-if="form.img" :src="$fullUrl(form.img)" class="avatar">
								<div v-else class="upload-placeholder">
									<i class="el-icon-plus avatar-uploader-icon"></i>
									<div class="el-upload__text">点击或拖拽上传封面</div>
								</div>
							</el-upload>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :lg="16">
						<el-row :gutter="20">
							<el-col :xs="24" :sm="24" :lg="24">
								<el-form-item label="标题" prop="title">
									<el-input v-model="form.title" placeholder="请输入文章标题" prefix-icon="el-icon-edit"></el-input>
								</el-form-item>
							</el-col>
							<el-col :xs="24" :sm="12" :lg="12">
								<el-form-item label="分类" prop="type">
									<el-select v-model="form.type" placeholder="请选择分类" style="width: 100%">
										<el-option v-for="(obj ,i) in list_artcle_type" :key="obj.name" :label="obj.name" :value="obj.name"></el-option>
									</el-select>
								</el-form-item>
							</el-col>
							<el-col :xs="24" :sm="12" :lg="12">
								<el-form-item label="标签" prop="tag">
									<el-input v-model="form.tag" placeholder="多个标签用逗号分隔" prefix-icon="el-icon-collection-tag"></el-input>
								</el-form-item>
							</el-col>
							<el-col :xs="24" :sm="24" :lg="24">
								<el-form-item label="摘要描述" prop="description">
									<el-input type="textarea" v-model="form.description" :rows="3" placeholder="请输入文章简介..."></el-input>
								</el-form-item>
							</el-col>
						</el-row>
					</el-col>
				</el-row>

				<div class="premium-section-title">正文内容</div>
				<el-row>
					<el-col :xs="24">
						<el-form-item label-width="0px">
							<quill-editor v-model="form.content" class="premium-editor"></quill-editor>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="(form['article_id'] && $check_action('/article/view','set')) || (!form['article_id'] && $check_action('/article/view','add'))">
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
				field: "article_id",
				url_add: "~/api/article/add?",
				url_set: "~/api/article/set?",
				url_get_obj: "~/api/article/get_obj?",
				url_upload: "~/api/article/upload?",
				query: { article_id: 0 },
				form: {
					article_id: 0,
					title: "",
					type: "",
					views: 0,
					source: "",
					url: "",
					tag: "",
					content: "",
					img: "",
					description: "",
				},
				list_artcle_type: []
			}
		},
		methods: {
			uploadImg(param) {
				this.uploadFile(param.file, "img");
			},
			async get_artcle_type() {
				var json = await this.$get("~/api/category/get_list?");
				if (json.result) {
					this.list_artcle_type = json.result.list;
				} else if (json.error) {
					console.error(json.error);
				}
			},
		},
		created() {
			this.get_artcle_type();
		}
	}
</script>

<style scoped>
	.avatar-uploader >>> .el-upload {
		border: 1px dashed #dcdfe6;
		border-radius: 12px;
		cursor: pointer;
		position: relative;
		overflow: hidden;
		transition: all 0.3s;
		width: 100%;
		max-width: 320px;
		height: 200px;
	}

	.avatar-uploader >>> .el-upload:hover {
		border-color: #409EFF;
		background: rgba(64, 158, 255, 0.02);
	}

	.avatar-uploader >>> .el-upload-dragger {
		width: 100%;
		height: 100%;
		border: none;
		background: none;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}

	.avatar-uploader-icon {
		font-size: 32px;
		color: #8c939d;
		margin-bottom: 8px;
	}

	.avatar {
		width: 100%;
		height: 100%;
		display: block;
		object-fit: cover;
	}

	.upload-placeholder {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}

	.premium-editor >>> .ql-container {
		min-height: 450px;
		border-bottom-left-radius: 8px;
		border-bottom-right-radius: 8px;
		font-size: 15px;
	}

	.premium-editor >>> .ql-toolbar {
		border-top-left-radius: 8px;
		border-top-right-radius: 8px;
		background: #f8f9fa;
	}
</style>
