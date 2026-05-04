<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="profile-card" shadow="never" v-if="is_view()">
			<div slot="header" class="card-header">
				<span class="header-title">注册用户信息设置</span>
				<span class="header-subtitle">查看并更新注册用户的详细资料</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="120px" label-position="top">
				<el-row :gutter="40">
					<!-- 左侧：头像与摘要 -->
					<el-col :xs="24" :sm="24" :lg="8" class="profile-side">
						<div class="avatar-section">
							<el-form-item label="用户头像" prop="avatar">
								<el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
									action="" :http-request="uploadimg" :show-file-list="false">
									<img v-if="form.avatar" :src="$fullUrl(form.avatar)" class="avatar">
									<div v-else class="upload-placeholder">
										<i class="el-icon-plus avatar-uploader-icon"></i>
										<div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
									</div>
								</el-upload>
							</el-form-item>
							
							<div class="profile-summary" v-if="form.user_name">
								<h2 class="user-name">{{ form.nick_name || form.user_name }}</h2>
								<el-tag size="small" type="success" effect="plain" class="group-tag">{{ form.user_group }}</el-tag>
								<div class="status-indicator">
									<span class="status-dot" :class="'status-' + form.state"></span>
									<span class="status-text">{{ list_user_state.find(i => i.value === form.state)?.name }}</span>
								</div>
							</div>
						</div>
					</el-col>

					<!-- 右侧：详细信息 -->
					<el-col :xs="24" :sm="24" :lg="16" class="profile-main">
						<div class="section-container">
							<div class="section-title">账号信息</div>
							<el-row :gutter="20">
								<el-col :span="12" :xs="24">
									<el-form-item label="账号" prop="user_name">
										<el-input v-if="!obj.user_name" v-model="form.user_name" placeholder="请输入账号" prefix-icon="el-icon-user"></el-input>
										<div v-else class="readonly-field">
											<i class="el-icon-user"></i>
											<span>{{ obj.user_name }}</span>
										</div>
									</el-form-item>
								</el-col>
								
								<el-col :span="12" :xs="24">
									<el-form-item label="昵称" prop="nick_name">
										<el-input v-model="form.nick_name" placeholder="请输入昵称" prefix-icon="el-icon-postcard"></el-input>
									</el-form-item>
								</el-col>
							</el-row>

							<el-row :gutter="20">
								<el-col :span="12" :xs="24">
									<el-form-item label="邮箱" prop="email">
										<el-input type="email" v-model="form.email" placeholder="请输入邮箱" prefix-icon="el-icon-message"></el-input>
									</el-form-item>
								</el-col>
								
								<el-col :span="12" :xs="24">
									<el-form-item label="状态" prop="state">
										<el-select :disabled="user_group!=='管理员'" v-model="form.state" placeholder="请选择" style="width: 100%">
											<el-option v-for="group in list_user_state" :key="group.value" :label="group.name"
												:value="group.value">
												<span class="option-item">
													<span class="status-dot" :class="'status-' + group.value"></span>
													{{ group.name }}
												</span>
											</el-option>
										</el-select>
									</el-form-item>
								</el-col>
							</el-row>

							<el-row :gutter="20" v-if="!obj.password">
								<el-col :span="24">
									<el-form-item label="密码" prop="password">
										<el-input type="password" v-model="form.password" placeholder="请输入密码" show-password prefix-icon="el-icon-lock"></el-input>
									</el-form-item>
								</el-col>
							</el-row>
						</div>

						<div class="section-container mt-4">
							<div class="section-title">个人资料</div>
							<el-row :gutter="20">
								<el-col :span="12" :xs="24">
									<el-form-item label="手机号" prop="phone">
										<el-input id="phone" v-model="form['phone']" placeholder="请输入手机号" prefix-icon="el-icon-phone"
											v-if="user_group === '管理员' || (form['user_id'] && $check_field('set','phone')) || (!form['user_id'] && $check_field('add','phone'))"></el-input>
										<div v-else class="readonly-field">
											<span>{{ form['phone'] }}</span>
										</div>
									</el-form-item>
								</el-col>

								<el-col :span="12" :xs="24">
									<el-form-item label="用户性别" prop="user_gender">
										<el-select id="user_gender" v-model="form['user_gender']" style="width: 100%">
											<el-option v-for="o in list_user_gender" :key="o.value" :label="o.text" :value="o.value">
											</el-option>
										</el-select>
									</el-form-item>
								</el-col>
							</el-row>
						</div>

						<div class="form-actions">
							<template v-if="$check_action('/registered_user/view','set') || $check_action('/registered_user/view','add')">
								<el-button type="primary" class="btn-submit" @click="submit()" icon="el-icon-check">提交保存</el-button>
								<el-button class="btn-cancel" @click="cancel()" icon="el-icon-close">取消</el-button>
							</template>
							<el-button v-else class="btn-cancel" @click="cancel()" icon="el-icon-back">返回</el-button>
						</div>
					</el-col>
				</el-row>
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
				field: "user_id",
				url_add: "~/api/user/register?",
				url_set: "~/api/user/set?",
				url_get_obj: "~/api/user/get_obj?",
				url_upload: "~/api/user/upload?",


				is_password: true,

				query: {
					"user_id": 0,
				},

				obj: {
					user_id: 0,
					user_name: '',
					nick_name: '',
					password: '',
					avatar: '',
					email: '',
					user_group: "注册用户",
					state: 1,
					user_gender: '男',
					phone: ''
					},

				form: {
					user_id: 0,
				    user_name: '',
					nick_name: '',
				    password: '',
					avatar: '',
					email: '',
					user_group: "注册用户",
					state: 1,
					user_gender: '男',
					phone: ''
					},

				disabledObj:{
								"user_name_isDisabled": false,
										"user_gender_isDisabled": false,
							},



				list_state: [{
					value: 0,
					name: "未认证"
				}, {
					value: 1,
					name: "审核中"
				}, {
					value: 2,
					name: "已认证"
				}],

				list_user_state: [{
					value: 1,
					name: "可用"
				}, {
					value: 2,
					name: "异常"
				}, {
					value: 3,
					name: "已冻结"
				}, {
					value: 4,
					name: "已注销"
				}],
				list_user_gender: [
					{ text: '男', value: 0 },
					{ text: '女', value: 1 }
				],
			}
		},
		methods: {
			get_obj_before(param) {
				var form = "";
				if(this.form && form){
					Object.keys(this.form).forEach(key => {
						Object.keys(form).forEach(dbKey => {
							if(key === dbKey){
								this.disabledObj[key+'_isDisabled'] = true;
								this.form[key] = form[dbKey]
							}
							if(dbKey === "source_table"){
								this.form['source_table'] = form[dbKey];
							}
							if(dbKey === "source_id"){
								this.form['source_id'] = form[dbKey];
							}
							if(dbKey === "source_user_id"){
								this.form['source_user_id'] = form[dbKey];
							}
						})
					})
				}
				$.db.del("form");
				return param;
			},

			get_obj_after(json, func){
				var user = json.result.obj;
				this.is_password = user.password ? false : true;
			},

			delImg(img, key = "img"){
				var _this = this;
				_this.form_sub[key].splice(img, 1);
			},

			async submit(param, func){
				if (!param) {
					param = this.form;
				}
				param.avatar = param.avatar == "" ? "/api/upload/default_avatar.jpg" : param.avatar;
				var pm = this.events("submit_before", Object.assign({}, param)) || param;
				var msg = await this.events("submit_check", pm);
				var ret;
				if (msg) {
					this.$toast(msg, 'danger');
				} else {
					ret = this.events("submit_main", pm, func);
				}
				return ret;
			},

			async submit_check(param){
				var ret = null;
				var email_regular = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
				var {user_name ,password ,nick_name ,user_group ,email} = param;
				if(!user_name){
					ret = "账号不能为空";
				} else if(user_name.length > 16 || user_name.length < 5){
					ret = "账号长度应为5到16个字符之间！";
				} else if(!password){
					ret = "密码不能为空!";
				} else if(this.is_password && (password.length > 16 || password.length < 5)){
					ret = "密码长度应为5到16个字符之间！";
				} else if(nick_name && (nick_name.length > 12 || nick_name.length < 2)){
					ret = "昵称长度应为2个字符到12个字符之间";
				} else if(email && !email_regular.test(email)){
					ret = "请输入正确的邮箱地址 例：test@test.com!";
				} else if(!user_group){
					ret = "请选择用户组!";
				}
				return ret;
			},

			submit_after(json,func){
				this.$toast("保存成功!" ,"success");
				this.$router.go(-1);
			},



			is_view(){
				var bl = false;
				if(!bl){
					bl = this.$check_action('/registered_user/table','add');
				}
				if(!bl){
					bl = this.$check_action('/registered_user/table','set');
				}
				if(!bl){
					bl = this.$check_action('/registered_user/view','add');
				}
				if(!bl){
					bl = this.$check_action('/registered_user/view','set');
				}
				if(!bl){
					bl = this.$check_action('/registered_user/view','get');
				}
				return bl;
			},
			uploadimg(param) {
				this.uploadFile(param.file, "avatar");
			},
		},
	}
</script>

<style scoped>
	.edit_wrap {
		padding: 20px;
		background-color: #f5f7fa;
		min-height: calc(100vh - 60px);
	}

	.profile-card {
		max-width: 1000px;
		margin: 0 auto;
		border-radius: 12px;
		box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05) !important;
		border: none;
	}

	.card-header {
		padding: 10px 0;
	}

	.header-title {
		font-size: 20px;
		font-weight: 600;
		color: #303133;
		display: block;
	}

	.header-subtitle {
		font-size: 13px;
		color: #909399;
		margin-top: 5px;
		display: block;
	}

	.profile-side {
		border-right: 1px solid #ebeef5;
		padding-bottom: 20px;
	}

	.avatar-section {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding-top: 20px;
	}

	.avatar-uploader {
		width: 180px;
		height: 180px;
		margin-bottom: 20px;
	}

	.avatar-uploader >>> .el-upload {
		border: 2px dashed #dcdfe6;
		border-radius: 50%;
		cursor: pointer;
		position: relative;
		overflow: hidden;
		transition: all 0.3s;
		width: 100%;
		height: 100%;
	}

	.avatar-uploader >>> .el-upload:hover {
		border-color: #409EFF;
		background-color: rgba(64, 158, 255, 0.02);
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

	.avatar {
		width: 100%;
		height: 100%;
		object-fit: cover;
		border-radius: 50%;
	}

	.upload-placeholder {
		color: #909399;
	}

	.avatar-uploader-icon {
		font-size: 32px;
		margin-bottom: 10px;
	}

	.profile-summary {
		text-align: center;
		margin-top: 20px;
	}

	.user-name {
		margin: 0 0 10px 0;
		font-size: 22px;
		color: #303133;
	}

	.group-tag {
		margin-bottom: 15px;
	}

	.status-indicator {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 8px;
		margin-top: 10px;
	}

	.status-dot {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		display: inline-block;
	}

	.status-1 { background-color: #67C23A; }
	.status-2 { background-color: #E6A23C; }
	.status-3 { background-color: #F56C6C; }
	.status-4 { background-color: #909399; }

	.status-text {
		font-size: 14px;
		color: #606266;
	}

	.profile-main {
		padding-left: 20px !important;
	}

	.section-container {
		margin-bottom: 30px;
	}

	.section-title {
		font-size: 16px;
		font-weight: 600;
		color: #303133;
		margin-bottom: 20px;
		padding-bottom: 10px;
		border-bottom: 1px solid #f0f2f5;
		position: relative;
	}

	.section-title::after {
		content: "";
		position: absolute;
		bottom: -1px;
		left: 0;
		width: 40px;
		height: 2px;
		background: #67C23A;
	}

	.readonly-field {
		background-color: #f5f7fa;
		border: 1px solid #e4e7ed;
		border-radius: 4px;
		padding: 0 15px;
		height: 40px;
		display: flex;
		align-items: center;
		color: #606266;
		gap: 10px;
	}

	.readonly-field i {
		color: #909399;
	}

	.option-item {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.form-actions {
		margin-top: 40px;
		padding-top: 20px;
		border-top: 1px solid #f0f2f5;
		display: flex;
		gap: 15px;
	}

	.btn-submit {
		padding: 12px 30px;
		font-weight: 500;
		box-shadow: 0 4px 12px rgba(103, 194, 58, 0.3);
	}

	.btn-cancel {
		padding: 12px 30px;
	}

	.mt-4 {
		margin-top: 20px;
	}

	@media (max-width: 992px) {
		.profile-side {
			border-right: none;
			border-bottom: 1px solid #ebeef5;
			margin-bottom: 30px;
		}
		.profile-main {
			padding-left: 0 !important;
		}
	}
</style>
