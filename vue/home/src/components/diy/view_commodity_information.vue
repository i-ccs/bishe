<template>
	<el-main class="bg edit_wrap">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce">
							<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品编码" prop="product_code">
												<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码"
							  v-if="(form['commodity_information_id'] && $check_field('set','product_code')) || (!form['commodity_information_id'] && $check_field('add','product_code'))" :disabled="true"></el-input>
					<div v-else-if="$check_field('get','product_code')">{{form['product_code']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品名称" prop="product_name">
												<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称"
							  v-if="(form['commodity_information_id'] && $check_field('set','product_name')) || (!form['commodity_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_name')">{{form['product_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品类别" prop="product_category">
												<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别"
							  v-if="(form['commodity_information_id'] && $check_field('set','product_category')) || (!form['commodity_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_category')">{{form['product_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品品牌" prop="product_brand">
												<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌"
							  v-if="(form['commodity_information_id'] && $check_field('set','product_brand')) || (!form['commodity_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_brand')">{{form['product_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','commodity_specifications') || $check_field('add','commodity_specifications') || $check_field('set','commodity_specifications')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品规格" prop="commodity_specifications">
												<el-input id="commodity_specifications" v-model="form['commodity_specifications']" placeholder="请输入商品规格"
							  v-if="(form['commodity_information_id'] && $check_field('set','commodity_specifications')) || (!form['commodity_information_id'] && $check_field('add','commodity_specifications'))" :disabled="disabledObj['commodity_specifications_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','commodity_specifications')">{{form['commodity_specifications']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_inventory') || $check_field('add','product_inventory') || $check_field('set','product_inventory')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品库存" prop="product_inventory">
								<el-input-number id="product_inventory" v-model.number="form['product_inventory']"
						v-if="(form['commodity_information_id'] && $check_field('set','product_inventory')) || (!form['commodity_information_id'] && $check_field('add','product_inventory'))" :disabled="disabledObj['product_inventory_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','product_inventory')">{{form['product_inventory']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_images') || $check_field('add','product_images') || $check_field('set','product_images')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品图片" prop="product_images">
								<el-upload :disabled="disabledObj['product_images_isDisabled']" class="avatar-uploader" drag
						accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="upload_product_images"
						:show-file-list="false" v-if="(form['commodity_information_id'] && $check_field('set','product_images')) || (!form['commodity_information_id'] && $check_field('add','product_images'))">
						<img id="product_images" v-if="form['product_images']" :src="$fullUrl(form['product_images'])" class="avatar">
						<i v-else class="el-icon-plus avatar-uploader-icon"></i>
					</el-upload>
					<el-image v-else-if="$check_field('get','product_images')" style="width: 100px; height: 100px"
						:src="$fullUrl(form['product_images'])" :preview-src-list="[$fullUrl(form['product_images'])]">
						<div slot="error" class="image-slot">
							<img src="../../../public/img/error.png" style="width: 90px; height: 90px" />
						</div>
					</el-image>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','commodity_price') || $check_field('add','commodity_price') || $check_field('set','commodity_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品价格" prop="commodity_price">
								<el-input-number id="commodity_price" v-model.number="form['commodity_price']"
						v-if="(form['commodity_information_id'] && $check_field('set','commodity_price')) || (!form['commodity_information_id'] && $check_field('add','commodity_price'))" :disabled="disabledObj['commodity_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','commodity_price')">{{form['commodity_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_introduction') || $check_field('add','product_introduction') || $check_field('set','product_introduction')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品介绍" prop="product_introduction">
								<el-input type="textarea" id="product_introduction" v-model="form['product_introduction']" placeholder="请输入商品介绍"
						v-if="(form['commodity_information_id'] && $check_field('set','product_introduction')) || (!form['commodity_information_id'] && $check_field('add','product_introduction'))" :disabled="disabledObj['product_introduction_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_introduction')">{{form['product_introduction']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_details') || $check_field('add','product_details') || $check_field('set','product_details')" :xs="24" :sm="24" :lg="24" class="el_form_editor_warp">
				<el-form-item label="商品详情" prop="product_details">
					<quill-editor v-model.number="form['product_details']"
						v-if="(form['commodity_information_id'] && $check_field('set','product_details')) || (!form['commodity_information_id'] && $check_field('add','product_details')) ">
					</quill-editor>
					<div v-else-if="$check_field('get','product_details')" v-html="form['product_details']"></div>
				</el-form-item>
			</el-col>
						
	
	
		
		
						<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['source_user_id'] && 0 > 0">
			  <el-form-item label="销售限次">
				<el-input id="limit_times" v-model="form['sales_information_limit_times']" placeholder="销售限制次数，0为不限"
						  v-if="$check_option('/commodity_information/view','can_limits')"
				></el-input>
				<div v-else-if="$check_action('/commodity_information/view','get')" v-html="form['sales_information_limit_times']"></div>
			  </el-form-item>
			</el-col>
					<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['source_user_id'] && 0 > 0">
			  <el-form-item label="采购限次">
				<el-input id="limit_times" v-model="form['purchasing_information_limit_times']" placeholder="采购限制次数，0为不限"
						  v-if="$check_option('/commodity_information/view','can_limits')"
				></el-input>
				<div v-else-if="$check_action('/commodity_information/view','get')" v-html="form['purchasing_information_limit_times']"></div>
			  </el-form-item>
			</el-col>
					<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['source_user_id'] && 0 > 0">
			  <el-form-item label="库存限次">
				<el-input id="limit_times" v-model="form['inventory_information_limit_times']" placeholder="库存限制次数，0为不限"
						  v-if="$check_option('/commodity_information/view','can_limits')"
				></el-input>
				<div v-else-if="$check_action('/commodity_information/view','get')" v-html="form['inventory_information_limit_times']"></div>
			  </el-form-item>
			</el-col>
			
	
	
	
	</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/commodity_information/view','set') || $check_action('/commodity_information/view','add')">
					<el-button type="primary" @click="submit()">提交</el-button>
					<el-button @click="cancel()">取消</el-button>
				</el-form-item>
				<el-form-item v-else>
					<el-button @click="cancel()">返回</el-button>
				</el-form-item>
			</el-col>

		</el-form>
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
	
	
			
	
			
	
			
	
		
			/**
			 * 获取对象之前
			 * @param {Object} param
			 */
			get_obj_before(param) {
				var form = "";
																			if(this.form && form){
					Object.keys(this.form).forEach(key => {
						Object.keys(form).forEach(dbKey => {
							// if(dbKey === "charging_standard"){
							// 	this.form['charging_rules'] = form[dbKey];
							// 	this.disabledObj['charging_rules_isDisabled'] = true;
							// };
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

			/**
			 * 获取对象之后
			 * @param {Object} json
			 * @param {Object} func
			 */
			get_obj_after(json, func){

																																																		

			},

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
			/**
			 * 提交前验证事件
			 * @param {Object} 请求参数
			 * @return {String} 验证成功返回null, 失败返回错误提示
			 */
						submit_check(param) {
																																																																																																																								return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/commodity_information/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/commodity_information/view','get');
					console.log(bl ? "你有视图查询权限视作有查询权限" : "你没有视图查询权限");
				}

				console.log(bl ? "具有当前页面的查看权，请注意这不代表你有字段的查看权" : "无权查看当前页，请注意即便有字段查询权限没有页面查询权限也不行");

				return bl;
			},
			/**
			 * 上传文件
			 * @param {Object} param
			 */
			uploadimg(param) {
				this.uploadFile(param.file, "avatar");
			},

		},
		created() {
																						},
	}
</script>

<style>
	.avatar-uploader .el-upload {
		border: 1px dashed #d9d9d9;
		border-radius: 6px;
		cursor: pointer;
		position: relative;
		overflow: hidden;
	}

	.avatar-uploader .el-upload:hover {
		border-color: #409EFF;
	}

	.avatar-uploader-icon {
		font-size: 28px;
		color: #8c939d;
		width: 178px;
		height: 178px;
		line-height: 178px;
		text-align: center;
	}

	.avatar {
		width: 178px;
		height: 178px;
		display: block;
	}
	
	.img_multiple{
		overflow: hidden;
	}
	.img_multiple .img_block{
		float: left;
		margin-right: 5px;
		margin-bottom: 5px;
		position: relative;
	}
	.img_multiple .img_block img{
		height: 100px;
		width: auto;
	}
	.img_multiple .img_del{
		position: absolute;
		top: 5px;
		right: 5px;
		width: 20px;
		height: 20px;
		background: #0000008a;
		color: #fff;
		line-height: 20px;
		text-align: center;
		border-radius: 100%;
		cursor: pointer;
	}




</style>
