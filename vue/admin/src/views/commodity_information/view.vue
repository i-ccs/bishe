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
					<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="product_code">
							<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码" prefix-icon="el-icon-collection-tag"
								v-if="(form['commodity_information_id'] && $check_field('set','product_code')) || (!form['commodity_information_id'] && $check_field('add','product_code'))" :disabled="true"></el-input>
							<div v-else-if="$check_field('get','product_code')" class="premium-readonly-field">{{form['product_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="product_name">
							<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称" prefix-icon="el-icon-goods"
								v-if="(form['commodity_information_id'] && $check_field('set','product_name')) || (!form['commodity_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_name')" class="premium-readonly-field">{{form['product_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="product_category">
							<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别" prefix-icon="el-icon-folder"
								v-if="(form['commodity_information_id'] && $check_field('set','product_category')) || (!form['commodity_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_category')" class="premium-readonly-field">{{form['product_category']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品品牌" prop="product_brand">
							<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌" prefix-icon="el-icon-price-tag"
								v-if="(form['commodity_information_id'] && $check_field('set','product_brand')) || (!form['commodity_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_brand')" class="premium-readonly-field">{{form['product_brand']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','commodity_specifications') || $check_field('add','commodity_specifications') || $check_field('set','commodity_specifications')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品规格" prop="commodity_specifications">
							<el-input id="commodity_specifications" v-model="form['commodity_specifications']" placeholder="请输入商品规格" prefix-icon="el-icon-info"
								v-if="(form['commodity_information_id'] && $check_field('set','commodity_specifications')) || (!form['commodity_information_id'] && $check_field('add','commodity_specifications'))" :disabled="disabledObj['commodity_specifications_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','commodity_specifications')" class="premium-readonly-field">{{form['commodity_specifications']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">价格与库存</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_inventory') || $check_field('add','product_inventory') || $check_field('set','product_inventory')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品库存" prop="product_inventory">
							<el-input-number id="product_inventory" v-model.number="form['product_inventory']" style="width: 100%" :min="0"
								v-if="(form['commodity_information_id'] && $check_field('set','product_inventory')) || (!form['commodity_information_id'] && $check_field('add','product_inventory'))" :disabled="disabledObj['product_inventory_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','product_inventory')" class="premium-readonly-field">{{form['product_inventory']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','commodity_price') || $check_field('add','commodity_price') || $check_field('set','commodity_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品价格" prop="commodity_price">
							<el-input-number id="commodity_price" v-model.number="form['commodity_price']" style="width: 100%"
								v-if="(form['commodity_information_id'] && $check_field('set','commodity_price')) || (!form['commodity_information_id'] && $check_field('add','commodity_price'))" :disabled="disabledObj['commodity_price_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','commodity_price')" class="premium-readonly-field">{{form['commodity_price']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">图文介绍</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_images') || $check_field('add','product_images') || $check_field('set','product_images')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="商品图片" prop="product_images">
							<el-upload :disabled="disabledObj['product_images_isDisabled']" class="avatar-uploader" drag
								accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="upload_product_images"
								:show-file-list="false" v-if="(form['commodity_information_id'] && $check_field('set','product_images')) || (!form['commodity_information_id'] && $check_field('add','product_images'))">
								<img id="product_images" v-if="form['product_images']" :src="$fullUrl(form['product_images'])" class="avatar">
								<div v-else class="upload-placeholder">
									<i class="el-icon-plus avatar-uploader-icon"></i>
									<div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
								</div>
							</el-upload>
							<el-image v-else-if="$check_field('get','product_images')" style="width: 150px; height: 150px; border-radius: 8px;"
								:src="$fullUrl(form['product_images'])" :preview-src-list="[$fullUrl(form['product_images'])]">
								<div slot="error" class="image-slot">
									<img src="/img/error.png" style="width: 90px; height: 90px" />
								</div>
							</el-image>
						</el-form-item>
					</el-col>

					<el-col v-if="$check_field('get','product_introduction') || $check_field('add','product_introduction') || $check_field('set','product_introduction')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="商品介绍" prop="product_introduction">
							<el-input type="textarea" :rows="4" id="product_introduction" v-model="form['product_introduction']" placeholder="请输入商品介绍"
								v-if="(form['commodity_information_id'] && $check_field('set','product_introduction')) || (!form['commodity_information_id'] && $check_field('add','product_introduction'))" :disabled="disabledObj['product_introduction_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_introduction')" class="premium-readonly-field" style="min-height: 80px;">{{form['product_introduction']}}</div>
						</el-form-item>
					</el-col>

					<el-col v-if="$check_field('get','product_details') || $check_field('add','product_details') || $check_field('set','product_details')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="商品详情" prop="product_details">
							<quill-editor v-model="form['product_details']" class="premium-editor"
								v-if="(form['commodity_information_id'] && $check_field('set','product_details')) || (!form['commodity_information_id'] && $check_field('add','product_details')) ">
							</quill-editor>
							<div v-else-if="$check_field('get','product_details')" v-html="form['product_details']" class="premium-readonly-field" style="display: block; height: auto; padding: 20px;"></div>
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
				field: "commodity_information_id",
				url_add: "~/api/commodity_information/add?",
				url_set: "~/api/commodity_information/set?",
				url_get_obj: "~/api/commodity_information/get_obj?",
				url_upload: "~/api/commodity_information/upload?",

				query: {
					"commodity_information_id": 0,
				},

				form: {
								"product_code": this.$get_stamp(), // 商品编码
										"product_name":  '', // 商品名称
										"product_category":  '', // 商品类别
										"product_brand":  '', // 商品品牌
										"commodity_specifications":  '', // 商品规格
										"product_inventory":  0, // 商品库存
										"product_images":  '', // 商品图片
										"commodity_price":  0, // 商品价格
										"product_introduction":  '', // 商品介绍
										"product_details":  '', // 商品详情
											"commodity_information_id": 0, // ID
													"sales_information_limit_times": 0, // 销售限制次数
							"purchasing_information_limit_times": 0, // 采购限制次数
							"inventory_information_limit_times": 0, // 库存限制次数
												},
				disabledObj:{
								"product_code_isDisabled": false,
										"product_name_isDisabled": false,
										"product_category_isDisabled": false,
										"product_brand_isDisabled": false,
										"commodity_specifications_isDisabled": false,
					          			"product_inventory_isDisabled": false,
										"product_images_isDisabled": false,
					          			"commodity_price_isDisabled": false,
										"product_introduction_isDisabled": false,
										"product_details_isDisabled": false,
										},
				}
		},
		methods: {
						/**
			 * 上传商品图片
			 * @param {Object} param 图片参数
			 */
			upload_product_images(param){
									this.uploadFile(param.file, "product_images");
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
				if (!param.product_name || param.product_name.trim() === '') {
					console.log('验证失败：商品名称为空');
					return '商品名称不能为空';
				}
				
				// 验证商品类别
				if (!param.product_category || param.product_category.trim() === '') {
					console.log('验证失败：商品类别为空');
					return '商品类别不能为空';
				}
				
				// 验证商品品牌
				if (!param.product_brand || param.product_brand.trim() === '') {
					console.log('验证失败：商品品牌为空');
					return '商品品牌不能为空';
				}
				
				// 验证商品规格
				if (!param.commodity_specifications || param.commodity_specifications.trim() === '') {
					console.log('验证失败：商品规格为空');
					return '商品规格不能为空';
				}
				
				// 验证商品图片
				if (!param.product_images || param.product_images.trim() === '') {
					console.log('验证失败：商品图片为空');
					return '商品图片不能为空';
				}
				
				// 验证商品价格 - 价格必须大于0
				if (param.commodity_price === null || param.commodity_price === undefined || param.commodity_price <= 0) {
					console.log('验证失败：商品价格无效', param.commodity_price);
					return '商品价格必须大于0';
				}
				
				// 验证商品库存 - 库存不能小于0
				if (param.product_inventory === null || param.product_inventory === undefined || param.product_inventory < 0) {
					console.log('验证失败：商品库存无效', param.product_inventory);
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
