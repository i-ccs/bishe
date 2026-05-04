<template>
	<div class="page_user user_info" id="user_info">
		<div class="warp">
			<div class="container">
				<div class="row">
				<!-- 左侧边栏 
					<div class="col-12 col-md-3">
						<div class="card_menu">
						
							<list_menu_user :list_info="list_info"></list_menu_user>
						</div>
					</div>
				-->
					<div class="col-12">
						<div class="card_info">
							<!-- 个人资料 -->
							<div class="div_info">
								<h4 class="uc-title">个人资料</h4>
								
								<div class="uc-info-sections">
									<!-- 基础信息 -->
									<div class="uc-info-section">
										<div class="figure_avatar">
											<div class="change_avatar_box" @click="$refs.avatarInput.click()">
												<div class="uc-avatar-wrap">
													<b-img class="user_avator"
														:src="obj.avatar ? $fullUrl(obj.avatar) : '/img/default.png'" alt="" />
													<div class="uc-avatar-overlay">
														<i class="uc-icon">📷</i>
													</div>
												</div>
												<div class="upload_btn_wrap">
													<input type="file" ref="avatarInput" @change="change_avatar($event.target.files)" style="display: none" accept="image/*" />
													<b-button size="sm" variant="outline-primary">点击图片修改头像</b-button>
												</div>
											</div>
										</div>

										<div class="uc-info-row">
											<div class="uc-label">账号：</div>
											<div class="uc-value">{{ obj.username }}</div>
										</div>

										<div class="uc-info-row">
											<div class="uc-label">昵称：</div>
											<div class="uc-edit-box">
												<input v-if="display_input === 'flex'" type="text" v-model="form.nickname" class="uc-input" />
												<span v-else class="uc-value">{{ obj.nickname }}</span>
												<b-button size="sm" variant="link" @click="display_input = display_input === 'flex' ? 'none' : 'flex'">
													{{ display_input === 'flex' ? '取消' : '修改' }}
												</b-button>
												<b-button v-if="display_input === 'flex'" size="sm" variant="primary" @click="save_nickname()">保存</b-button>
											</div>
										</div>
									</div>

									<!-- 注册详细信息 -->
									<div class="uc-info-section" v-if="source_table">
										<div class="uc-info-row">
											<div class="uc-label">用户姓名：</div>
											<div class="uc-edit-box">
												<input v-model="form_sub.user_name" class="uc-input" placeholder="请输入真实姓名" />
											</div>
										</div>

										<div class="uc-info-row">
											<div class="uc-label">用户性别：</div>
											<div class="uc-edit-box">
												<select v-model="form_sub.user_gender" class="uc-select">
													<option :value="0">男</option>
													<option :value="1">女</option>
												</select>
											</div>
										</div>
									</div>

									<!-- 账户信息 -->
									<div class="uc-info-section">
										<div class="uc-info-row">
											<div class="uc-label">手机号码：</div>
											<div class="uc-edit-box">
												<input v-model="obj.phone" class="uc-input" placeholder="请输入手机号" />
											</div>
										</div>

										<div class="uc-info-row">
											<div class="uc-label">邮箱地址：</div>
											<div class="uc-edit-box">
												<input v-model="obj.email" class="uc-input" placeholder="请输入邮箱" />
											</div>
										</div>
									</div>
								</div>

								<div class="uc-actions">
									<b-button variant="primary" class="btn-save-all" @click="save_all()">保存所有修改</b-button>
									<b-button variant="outline-secondary" @click="$router.push('/user/password')">修改密码</b-button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from "@/mixins/page.js";
	//import list_menu_user from "@/components/diy/list_menu_user.vue";

	export default {
		mixins: [mixin],
		data() {
			return {
				url_get_obj: "~/api/user/get_obj?",
				query: {
					user_id: this.$store.state.user.user_id
				},
				display_input: "none",
				display_name: "block",
				form: {},
				// 输入聚焦
				focus_input: false,
				list_info: [{
						title: "个人资料",
						url: "/user/info",
						icon: "house-fill",
						selected: true,
					},
					{
						title: "密码修改",
						url: "/user/password",
						icon: "person-fill",
						selected: false,
					},

					{
						title: "收藏",
						url: "/user/collect",
						icon: "heart-fill",
						selected: false,
					},

				],
				file: null,
				source_table: null,
				source_table_name: null,
				source_table_check_url: "",
				source_table_url:"",
			};
		},
		methods: {
			/**
			 * 修改头像
			 * @param { Object } files 上传文件对象
			 */
			async change_avatar(files) {
				var _this = this;
				var form = new FormData();
				form.append("file", files[0]);
				var res = await this.$post("~/api/user/upload?", form);
				console.log(res)
				if (res.result) {
					var avatar = res.result.url;
					this.$post(
						"~/api/user/set?user_id=" + _this.user.user_id, {
							avatar,
						},
						(res) => {
							this.user.avatar = avatar;
							this.obj.avatar = avatar;
						}
					);
				} else {
					this.$toast(res.error.message);
				}
			},
			/**
			 * 跳出修改昵称输入框
			 */
			change_nickname() {
				this.display_input = "flex";
				this.display_name = "none";
				this.focus_input = true;
			},
			/**
			 * 保存昵称修改
			 */
			save_nickname() {
				var user_id = this.user.user_id;
				var nickname = this.form.nickname;
				this.$post(
					"~/api/user/set?user_id=" + user_id, {
						nickname,
					},
					(res) => {
						console.log(res);
						this.focus_input = false;
						this.display_input = "none";
						this.display_name = "block";
						this.user.nickname = nickname;
						this.obj.nickname = nickname;
					}
				);
			},
			/**
			 * 保存所有修改
			 */
			async save_all() {
				const user_id = this.user.user_id;
				
				// 1. 保存主表信息 (nickname, phone, email)
				const user_res = await this.$post("~/api/user/set?user_id=" + user_id, {
					nickname: this.obj.nickname,
					phone: this.obj.phone,
					email: this.obj.email
				});

				// 2. 保存子表信息 (user_name, user_gender)
				if (this.source_table && this.form_sub[this.source_table + '_id']) {
					const sub_res = await this.$post(
						"~/api/" + this.source_table + "/set?" + this.source_table + "_id=" + this.form_sub[this.source_table + '_id'],
						this.form_sub
					);
					if (sub_res.result) {
						this.$toast("资料修改成功!", "success");
					}
				} else if (user_res.result) {
					this.$toast("账号信息修改成功!", "success");
				}
				
				// 同步更新store
				this.$store.commit('user_set', Object.assign({}, this.user, this.obj));
			},
			get_obj_before(params) {
				params.user_id = this.$store.state.user.user_id;
				return params
			},
			async get_obj_after(json, func){
				let user_group = this.$store.state.user.user_group;
				var json_group = await this.$get("~/api/user_group/get_obj?name="+user_group);
				if(json_group.result && json_group.result.obj){
					if (json_group.result.obj.source_table) {
						this.source_table = json_group.result.obj.source_table
						this.source_table_name = user_group
						this.source_table_check_url = "/"+this.source_table +"/view";
						this.source_table_url = this.source_table_check_url+"?user_id=" +this.user.user_id;
						
						// 获取子表数据
						const sub_res = await this.$get("~/api/" + this.source_table + "/get_obj?user_id=" + this.user.user_id);
						if (sub_res.result && sub_res.result.obj) {
							this.form_sub = sub_res.result.obj;
						}
					}
				}
			}
		},
		components: {
			//list_menu_user,
		},
	};
</script>

<style scoped>
	.container {
		min-height: 800px;
		padding-top: 2rem;
	}

	.card_info {
		background: #fff;
		border-radius: 16px;
		padding: 3rem !important;
		box-shadow: 0 10px 30px rgba(0,0,0,0.05);
		max-width: 800px;
		margin: 0 auto;
	}

	.uc-title {
		color: #1a2740;
		font-weight: 700;
		margin-bottom: 2rem;
		padding-bottom: 1rem;
		border-bottom: 1px solid #f0f4f8;
		text-align: center;
	}

	.uc-info-sections {
		display: flex;
		flex-direction: column;
		gap: 2rem;
		max-width: 600px;
		margin: 0 auto;
	}

	.uc-info-section {
		padding: 1.5rem;
		background: #f8fbff;
		border-radius: 12px;
		border: 1px solid #eef4fa;
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.uc-info-row {
		display: flex;
		align-items: center;
		margin-bottom: 1rem;
		width: 100%;
		justify-content: center;
	}

	.uc-info-row:last-child {
		margin-bottom: 0;
	}

	.uc-label {
		width: 120px;
		color: #64748b;
		font-size: 14px;
		text-align: right;
		margin-right: 15px;
	}

	.uc-value {
		color: #1e293b;
		font-weight: 500;
		flex: 1;
		text-align: left;
	}

	.uc-edit-box {
		display: flex;
		align-items: center;
		gap: 10px;
		flex: 1;
		justify-content: flex-start;
	}

	.uc-input {
		border: 1px solid #cbd5e1;
		border-radius: 6px;
		padding: 6px 12px;
		font-size: 14px;
		width: 260px;
		transition: border-color 0.2s;
	}

	.uc-input:focus {
		outline: none;
		border-color: #1a6fa8;
	}

	.uc-select {
		border: 1px solid #cbd5e1;
		border-radius: 6px;
		padding: 6px 12px;
		font-size: 14px;
		background: #fff;
		width: 260px;
	}

	.figure_avatar {
		display: flex;
		align-items: center;
		margin-bottom: 1.5rem;
		width: 100%;
		justify-content: center;
	}

	.uc-avatar-wrap {
		position: relative;
		width: 80px;
		height: 80px;
		border-radius: 50%;
		overflow: hidden;
		cursor: pointer;
		border: 3px solid #fff;
		box-shadow: 0 4px 12px rgba(0,0,0,0.1);
		transition: transform 0.3s;
	}

	.uc-avatar-wrap:hover {
		transform: scale(1.05);
	}

	.user_avator {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}

	.uc-avatar-overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0,0,0,0.4);
		display: flex;
		align-items: center;
		justify-content: center;
		opacity: 0;
		transition: opacity 0.3s;
	}

	.uc-avatar-wrap:hover .uc-avatar-overlay {
		opacity: 1;
	}

	.uc-icon {
		color: #fff;
		font-size: 20px;
		font-style: normal;
	}

	.upload_btn_wrap {
		display: flex;
		flex-direction: column;
		gap: 8px;
	}

	.uc-actions {
		margin-top: 3rem;
		padding-top: 2rem;
		border-top: 1px solid #f0f4f8;
		display: flex !important;
		gap: 1.5rem;
		justify-content: center !important;
	}

	.btn-save-all {
		padding: 0.6rem 3rem;
		font-weight: 600;
	}
</style>
