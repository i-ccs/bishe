<template>
	<el-main class="bg edit_wrap">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce">
							<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code') || $check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
								<el-form-item label="商品编码" prop="prod_code">
																<el-input id="prod_code" v-model="form['prod_code']" placeholder="请输入商品编码"
											  v-if="(form['comm_infor_id'] && ($check_field('set','prod_code')||$check_field('set','prod_code'))) || (!form['comm_infor_id'] && ($check_field('add','prod_code')||$check_field('add','prod_code')))" :disabled="true"></el-input>
									<div v-else-if="$check_field('get','prod_code') || $check_field('get','prod_code')">{{form['prod_code'] || form['prod_code']}}</div>
															</el-form-item>
							</el-col>
								<el-col v-if="$check_field('get','prod_name') || $check_field('add','prod_name') || $check_field('set','prod_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品名称" prop="prod_name">
																<el-input id="prod_name" v-model="form['prod_name']" placeholder="请输入商品名称"
															v-if="(form['comm_infor_id'] && ($check_field('set','prod_name')||$check_field('set','prod_name'))) || (!form['comm_infor_id'] && ($check_field('add','prod_name')||$check_field('add','prod_name')))" :disabled="disabledObj['prod_name_isDisabled']"></el-input>
										<div v-else-if="$check_field('get','prod_name') || $check_field('get','prod_name')">{{form['prod_name'] || form['prod_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_category') || $check_field('add','prod_category') || $check_field('set','prod_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品类别" prop="prod_category">
												<el-input id="prod_category" v-model="form['prod_category']" placeholder="请输入商品类别"
							  v-if="(form['comm_infor_id'] && ($check_field('set','prod_category')||$check_field('set','prod_category'))) || (!form['comm_infor_id'] && ($check_field('add','prod_category')||$check_field('add','prod_category')))" :disabled="disabledObj['prod_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_category') || $check_field('get','prod_category')">{{form['prod_category'] || form['prod_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_brand') || $check_field('add','prod_brand') || $check_field('set','prod_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品品牌" prop="prod_brand">
												<el-input id="prod_brand" v-model="form['prod_brand']" placeholder="请输入商品品牌"
							  v-if="(form['comm_infor_id'] && ($check_field('set','prod_brand')||$check_field('set','prod_brand'))) || (!form['comm_infor_id'] && ($check_field('add','prod_brand')||$check_field('add','prod_brand')))" :disabled="disabledObj['prod_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_brand') || $check_field('get','prod_brand')">{{form['prod_brand'] || form['prod_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','comm_spec') || $check_field('add','comm_spec') || $check_field('set','comm_spec')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品规格" prop="comm_spec">
												<el-input id="comm_specifications" v-model="form['comm_spec']" placeholder="请输入商品规格"
							  v-if="(form['comm_infor_id'] && ($check_field('set','comm_spec')||$check_field('set','comm_spec'))) || (!form['comm_infor_id'] && ($check_field('add','comm_spec')||$check_field('add','comm_spec')))" :disabled="disabledObj['comm_spec_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','comm_spec') || $check_field('get','comm_spec')">{{form['comm_spec'] || form['comm_spec']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_invent') || $check_field('add','prod_invent') || $check_field('set','prod_invent')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品库存" prop="prod_inven">
								<el-input-number id="prod_inven" v-model.number="form['prod_inven']" :min="0"
						v-if="(form['comm_infor_id'] && ($check_field('set','prod_inven')||$check_field('set','prod_invent'))) || (!form['comm_infor_id'] && ($check_field('add','prod_inven')||$check_field('add','prod_invent')))" :disabled="disabledObj['prod_inven_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','prod_inven') || $check_field('get','prod_invent')">{{form['prod_inven'] || form['prod_invent']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_ima') || $check_field('add','prod_ima') || $check_field('set','prod_ima')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品图片" prop="prod_ima">
								<el-upload :disabled="disabledObj['prod_ima_isDisabled']" class="avatar-uploader" drag
						accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="upload_prod_ima"
						:show-file-list="false" v-if="(form['comm_infor_id'] && ($check_field('set','prod_ima')||$check_field('set','prod_ima'))) || (!form['comm_infor_id'] && ($check_field('add','prod_ima')||$check_field('add','prod_ima')))">
						<img id="prod_ima" v-if="form['prod_ima'] || form['prod_ima']" :src="$fullUrl(form['prod_ima'] || form['prod_ima'])" class="avatar">
						<i v-else class="el-icon-plus avatar-uploader-icon"></i>
					</el-upload>
					<el-image v-else-if="$check_field('get','prod_ima') || $check_field('get','prod_ima')" style="width: 100px; height: 100px"
						:src="$fullUrl(form['prod_ima'] || form['prod_ima'])" :preview-src-list="[$fullUrl(form['prod_ima'] || form['prod_ima'])]">
						<div slot="error" class="image-slot">
							<img src="../../../public/img/error.png" style="width: 90px; height: 90px" />
						</div>
					</el-image>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','comm_price') || $check_field('add','comm_price') || $check_field('set','comm_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品价格" prop="comm_price">
								<el-input-number id="comm_price" v-model.number="form['comm_price']" :min="0"
						v-if="(form['comm_infor_id'] && ($check_field('set','comm_price')||$check_field('set','comm_price'))) || (!form['comm_infor_id'] && ($check_field('add','comm_price')||$check_field('add','comm_price')))" :disabled="disabledObj['comm_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','comm_price') || $check_field('get','comm_price')">{{form['comm_price'] || form['comm_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_intro') || $check_field('add','prod_intro') || $check_field('set','prod_intro')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品介绍" prop="prod_intro">
								<el-input type="textarea" id="prod_intro" v-model="form['prod_intro']" placeholder="请输入商品介绍"
						v-if="(form['comm_infor_id'] && ($check_field('set','prod_intro')||$check_field('set','prod_intro'))) || (!form['comm_infor_id'] && ($check_field('add','prod_intro')||$check_field('add','prod_intro')))" :disabled="disabledObj['prod_intro_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_intro') || $check_field('get','prod_intro')">{{form['prod_intro'] || form['prod_intro']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_details') || $check_field('add','product_details') || $check_field('set','product_details')" :xs="24" :sm="24" :lg="24" class="el_form_editor_warp">
				<el-form-item label="商品详情" prop="prod_intro">
					<quill-editor v-model.number="form['prod_intro']"
						v-if="(form['comm_infor_id'] && ($check_field('set','prod_intro')||$check_field('set','product_details'))) || (!form['comm_infor_id'] && ($check_field('add','prod_intro')||$check_field('add','product_details'))) ">
					</quill-editor>
					<div v-else-if="$check_field('get','prod_intro') || $check_field('get','product_details')" v-html="form['prod_intro'] || form['product_details']"></div>
				</el-form-item>
			</el-col>
						
	
	
		
		
						<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['sou_user_id'] && 0 > 0">
			  <el-form-item label="销售限次">
				<el-input id="limit_times" v-model="form['sales_information_limit_times']" placeholder="销售限制次数，0为不限"
						  v-if="$check_option('/commodity_information/view','can_limits')"
				></el-input>
				<div v-else-if="$check_action('/commodity_information/view','get')" v-html="form['sales_information_limit_times']"></div>
			  </el-form-item>
			</el-col>
					<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['sou_user_id'] && 0 > 0">
			  <el-form-item label="采购限次">
				<el-input id="limit_times" v-model="form['purchasing_informtion_limit_times']" placeholder="采购限制次数，0为不限"
						  v-if="$check_option('/commodity_information/view','can_limits')"
				></el-input>
				<div v-else-if="$check_action('/commodity_information/view','get')" v-html="form['purchasing_informtion_limit_times']"></div>
			  </el-form-item>
			</el-col>
					<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['sou_user_id'] && 0 > 0">
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
							"prod_intro":  '', // 商品介绍/详情
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
							if (param.comm_price === null || param.comm_price === undefined || param.comm_price < 0) {
								return '价格不能小于0';
							}
							if (param.prod_invent === null || param.prod_invent === undefined || param.prod_invent < 0) {
								return '库存不能小于0';
							}
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
