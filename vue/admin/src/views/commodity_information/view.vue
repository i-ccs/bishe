<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="premium-view-card" shadow="never" v-if="is_view()">
			<div slot="header" class="premium-header">
				<span class="premium-title">商品详情</span>
				<span class="premium-subtitle">管理商品的基本信息、库存及详细介绍</span>
			</div>

			<el-form ref="form" :model="form" :rules="rules" status-icon label-width="120px" label-position="top">
				<div class="premium-section-title">基本信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="prod_code">
							<el-input id="prod_code" v-model="form['prod_code']" placeholder="请输入商品编码" prefix-icon="el-icon-collection-tag"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_code')) || (!form['comm_infor_id'] && $check_field('add','prod_code'))" :disabled="true"></el-input>
							<div v-else-if="$check_field('get','prod_code')" class="premium-readonly-field">{{form['prod_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','prod_name') || $check_field('add','prod_name') || $check_field('set','prod_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="prod_name">
							<el-input id="prod_name" v-model="form['prod_name']" placeholder="请输入商品名称" prefix-icon="el-icon-goods"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_name')) || (!form['comm_infor_id'] && $check_field('add','prod_name'))" :disabled="disabledObj['prod_name_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','prod_name')" class="premium-readonly-field">{{form['prod_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','prod_category') || $check_field('add','prod_category') || $check_field('set','prod_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="prod_category">
							<el-input id="prod_category" v-model="form['prod_category']" placeholder="请输入商品类别" prefix-icon="el-icon-folder"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_category')) || (!form['comm_infor_id'] && $check_field('add','prod_category'))" :disabled="disabledObj['prod_category_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','prod_category')" class="premium-readonly-field">{{form['prod_category']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_brand') || $check_field('add','prod_brand') || $check_field('set','prod_brand')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品品牌" prop="prod_brand">
							<el-input id="prod_brand" v-model="form['prod_brand']" placeholder="请输入商品品牌" prefix-icon="el-icon-price-tag"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_brand')) || (!form['comm_infor_id'] && $check_field('add','prod_brand'))" :disabled="disabledObj['prod_brand_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','prod_brand')" class="premium-readonly-field">{{form['prod_brand']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','comm_spec') || $check_field('add','comm_spec') || $check_field('set','comm_spec')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品规格" prop="comm_spec">
							<el-input id="comm_spec" v-model="form['comm_spec']" placeholder="请输入商品规格" prefix-icon="el-icon-info"
								v-if="(form['comm_infor_id'] && $check_field('set','comm_spec')) || (!form['comm_infor_id'] && $check_field('add','comm_spec'))" :disabled="disabledObj['comm_spec_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','comm_spec')" class="premium-readonly-field">{{form['comm_spec']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">价格与库存</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_inven') || $check_field('add','prod_inven') || $check_field('set','prod_inven')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品库存" prop="prod_inven">
							<el-input-number id="prod_inven" v-model.number="form['prod_inven']" style="width: 100%" :min="0"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_inven')) || (!form['comm_infor_id'] && $check_field('add','prod_inven'))" :disabled="disabledObj['prod_inven_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','prod_inven')" class="premium-readonly-field">{{form['prod_inven']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','comm_price') || $check_field('add','comm_price') || $check_field('set','comm_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品价格" prop="comm_price">
							<el-input-number id="comm_price" v-model.number="form['comm_price']" style="width: 100%"
								v-if="(form['comm_infor_id'] && $check_field('set','comm_price')) || (!form['comm_infor_id'] && $check_field('add','comm_price'))" :disabled="disabledObj['comm_price_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','comm_price')" class="premium-readonly-field">{{form['comm_price']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">图文介绍</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_ima') || $check_field('add','prod_ima') || $check_field('set','prod_ima')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="商品图片" prop="prod_ima">
							<el-upload :disabled="disabledObj['prod_ima_isDisabled']" class="avatar-uploader" drag
								accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="upload_prod_ima"
								:show-file-list="false" v-if="(form['comm_infor_id'] && $check_field('set','prod_ima')) || (!form['comm_infor_id'] && $check_field('add','prod_ima'))">
								<img id="prod_ima" v-if="form['prod_ima']" :src="$fullUrl(form['prod_ima'])" class="avatar">
								<div v-else class="upload-placeholder">
									<i class="el-icon-plus avatar-uploader-icon"></i>
									<div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
								</div>
							</el-upload>
							<el-image v-else-if="$check_field('get','prod_ima')" style="width: 150px; height: 150px; border-radius: 8px;"
								:src="$fullUrl(form['prod_ima'])" :preview-src-list="[$fullUrl(form['prod_ima'])]">
								<div slot="error" class="image-slot">
									<img src="/img/error.png" style="width: 90px; height: 90px" />
								</div>
							</el-image>
						</el-form-item>
					</el-col>

					<el-col v-if="$check_field('get','prod_intro') || $check_field('add','prod_intro') || $check_field('set','prod_intro')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="商品介绍" prop="prod_intro">
							<el-input type="textarea" :rows="4" id="prod_intro" v-model="form['prod_intro']" placeholder="请输入商品介绍"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_intro')) || (!form['comm_infor_id'] && $check_field('add','prod_intro'))" :disabled="disabledObj['prod_intro_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','prod_intro')" class="premium-readonly-field" style="min-height: 80px;">{{form['prod_intro']}}</div>
						</el-form-item>
					</el-col>

					<el-col v-if="$check_field('get','prod_intro') || $check_field('add','prod_intro') || $check_field('set','prod_intro')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="商品详情" prop="prod_intro">
							<quill-editor v-model="form['prod_intro']" class="premium-editor"
								v-if="(form['comm_infor_id'] && $check_field('set','prod_intro')) || (!form['comm_infor_id'] && $check_field('add','prod_intro')) ">
							</quill-editor>
							<div v-else-if="$check_field('get','prod_intro')" v-html="form['prod_intro']" class="premium-readonly-field" style="display: block; height: auto; padding: 20px;"></div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="$check_action('/commodity_information/view','set') || $check_action('/commodity_information/view','add')">
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
				field: "comm_infor_id",
				url_add: "~/api/commodity_information/add?",
				url_set: "~/api/commodity_information/set?",
				url_get_obj: "~/api/commodity_information/get_obj?",
				url_upload: "~/api/commodity_information/upload?",

				query: {
					"comm_infor_id": 0,
				},

				form: {
							"prod_code": this.$get_stamp(), // 商品编码
							"prod_name":  '', // 商品名称
							"prod_category":  '', // 商品类别
							"prod_brand":  '', // 商品品牌
							"comm_spec":  '', // 商品规格
							"prod_inven":  0, // 商品库存
							"prod_ima":  '', // 商品图片
							"comm_price":  0, // 商品价格
							"prod_intro":  '', // 商品介绍
							"comm_infor_id": 0, // ID
							"sales_information_limit_times": 0, // 销售限制次数
							"purchasing_informtion_limit_times": 0, // 采购限制次数
							"inventory_information_limit_times": 0, // 库存限制次数
												},
				disabledObj:{
								"prod_code_isDisabled": false,
								"prod_name_isDisabled": false,
								"prod_category_isDisabled": false,
								"prod_brand_isDisabled": false,
								"comm_spec_isDisabled": false,
								"prod_inven_isDisabled": false,
								"prod_ima_isDisabled": false,
								"comm_price_isDisabled": false,
								"prod_intro_isDisabled": false,
								},
				}
		},
		methods: {
						/**
			 * 上传商品图片
			 * @param {Object} param 图片参数
			 */
			upload_prod_ima(param){
									this.uploadFile(param.file, "prod_ima");
								},

			get_obj_before(param) {
				var form = "";
				if(this.form && form){
					Object.keys(this.form).forEach(key => {
						Object.keys(form).forEach(dbKey => {
							if(key === dbKey){
								this.disabledObj[key+'_isDisabled'] = true;
								this.form[key] = form[dbKey]
							}
							if(dbKey === "sou_table"){
								this.form['sou_table'] = form[dbKey];
							}
							if(dbKey === "sou_id"){
								this.form['sou_id'] = form[dbKey];
							}
							if(dbKey === "sou_user_id"){
								this.form['sou_user_id'] = form[dbKey];
							}
						})
					})
				}
				$.db.del("form");
				return param;
			},

			get_obj_after(json, func){},

			async submit(param, func){
				if (!param) {
					param = this.form;
				}
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
			
			submit_check(param) {
				console.log('开始验证商品数据:', param);
				
				// 验证商品名称
				if (!param.prod_name || param.prod_name.trim() === '') {
					console.log('验证失败：商品名称为空');
					return '商品名称不能为空';
				}
				
				// 验证商品类别
				if (!param.prod_category || param.prod_category.trim() === '') {
					console.log('验证失败：商品类别为空');
					return '商品类别不能为空';
				}
				
				// 验证商品品牌
				if (!param.prod_brand || param.prod_brand.trim() === '') {
					console.log('验证失败：商品品牌为空');
					return '商品品牌不能为空';
				}
				
				// 验证商品规格
				if (!param.comm_spec || param.comm_spec.trim() === '') {
					console.log('验证失败：商品规格为空');
					return '商品规格不能为空';
				}
				
				// 验证商品图片
				if (!param.prod_ima || param.prod_ima.trim() === '') {
					console.log('验证失败：商品图片为空');
					return '商品图片不能为空';
				}
				
				// 验证商品价格 - 价格必须大于0
				if (param.comm_price === null || param.comm_price === undefined || param.comm_price <= 0) {
					console.log('验证失败：商品价格无效', param.comm_price);
					return '商品价格必须大于0';
				}
				
				// 验证商品库存 - 库存不能小于0
				if (param.prod_inven === null || param.prod_inven === undefined || param.prod_inven < 0) {
					console.log('验证失败：商品库存无效', param.prod_inven);
					return '商品库存不能小于0';
				}
				
				console.log('验证通过');
				return null;
			},

			is_view(){
				var bl = false;
				if(!bl){
					bl = this.$check_action('/commodity_information/table','add');
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/table','set');
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/view','add');
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/view','set');
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/view','get');
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
	.avatar-uploader >>> .el-upload {
		border: 1px dashed #dcdfe6;
		border-radius: 8px;
		cursor: pointer;
		position: relative;
		overflow: hidden;
		transition: all 0.3s;
		width: 178px;
		height: 178px;
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
		font-size: 28px;
		color: #8c939d;
	}

	.avatar {
		width: 178px;
		height: 178px;
		display: block;
		object-fit: contain;
	}

	.upload-placeholder {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}

	.premium-editor >>> .ql-container {
		min-height: 300px;
		border-bottom-left-radius: 8px;
		border-bottom-right-radius: 8px;
	}

	.premium-editor >>> .ql-toolbar {
		border-top-left-radius: 8px;
		border-top-right-radius: 8px;
	}
</style>
