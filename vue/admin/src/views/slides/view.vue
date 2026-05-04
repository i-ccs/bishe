<template>
	<el-main class="bg edit_wrap slides">
		<el-card class="premium-view-card" shadow="never">
			<div slot="header" class="premium-header">
				<span class="premium-title">{{ form.slides_id ? '编辑轮播图' : '添加轮播图' }}</span>
				<span class="premium-subtitle">设置首页大图轮播，提升页面视觉引导效果</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="80px" label-position="top">
				<div class="premium-section-title">轮播图设置</div>
				<el-row :gutter="30">
					<el-col :xs="24" :sm="24" :lg="10">
						<el-form-item label="背景图片" prop="img">
							<el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg" action=""
								:http-request="uploadimg" :show-file-list="false">
								<img v-if="form.img" :src="$fullUrl(form.img)" class="avatar">
								<div v-else class="upload-placeholder">
									<i class="el-icon-plus avatar-uploader-icon"></i>
									<div class="el-upload__text">点击或拖拽上传背景图</div>
								</div>
							</el-upload>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :lg="14">
						<el-row :gutter="20">
							<el-col :xs="24" :sm="24" :lg="24">
								<el-form-item label="轮播标题" prop="title">
									<el-input v-model="form.title" placeholder="显示在图片上的主标题" prefix-icon="el-icon-picture-outline"></el-input>
								</el-form-item>
							</el-col>
							<el-col :xs="24" :sm="24" :lg="24">
								<el-form-item label="跳转链接" prop="url">
									<el-input v-model="form.url" placeholder="点击图片后跳转的地址，以 http(s):// 开头" prefix-icon="el-icon-link"></el-input>
								</el-form-item>
							</el-col>
						</el-row>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="(form['slides_id'] && $check_action('/slides/view','set')) || (!form['slides_id'] && $check_action('/slides/view','add'))">
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
				table: "slides",
				field: "slides_id",
				url_add: "~/api/slides/add?",
				url_set: "~/api/slides/set?",
				url_get_obj: "~/api/slides/get_obj?",
				url_upload: "~/api/slides/upload?",
				query: { slides_id: 0 },
				form: {
					slides_id: 0,
					title: "",
					content: "",
					url: "",
					img: "",
					hits: 0
				},
			}
		},
		methods: {
			submit_check(params) {
				if (params.title === "") {
					return "标题不能为空";
				}
				return null;
			},
			uploadimg(param) {
				this.uploadFile(param.file);
			}
		},
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
		height: 240px;
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
</style>
