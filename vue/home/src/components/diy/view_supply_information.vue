<template>
	<el-main class="bg edit_wrap">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce">
							<el-col v-if="$check_field('get','supplier_na') || $check_field('add','supplier_na') || $check_field('set','supplier_na')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="供应商名称" prop="supplier_na">
												<el-input id="supplier_na" v-model="form['supplier_na']" placeholder="请输入供应商名称"
							  v-if="(form['supply_infor_id'] && $check_field('set','supplier_na')) || (!form['supply_infor_id'] && $check_field('add','supplier_na'))" :disabled="disabledObj['supplier_na_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','supplier_na')">{{form['supplier_na']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','suppliers_phone_number') || $check_field('add','suppliers_phone_number') || $check_field('set','suppliers_phone_number')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="供应商电话" prop="suppliers_phone_number">
								<el-input id="suppliers_phone_number" v-model="form['suppliers_phone_number']" placeholder="请输入供应商电话" type="tel"
						v-if="(form['supply_infor_id'] && $check_field('set','suppliers_phone_number')) || (!form['supply_infor_id'] && $check_field('add','suppliers_phone_number'))">
					</el-input>
					<div v-else-if="$check_field('get','suppliers_phone_number')">{{form['suppliers_phone_number']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','comm_category') || $check_field('add','comm_category') || $check_field('set','comm_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品类别" prop="comm_category">
								<el-select id="comm_category" v-model="form['comm_category']"						v-if="(form['supply_infor_id'] && $check_field('set','comm_category')) || (!form['supply_infor_id'] && $check_field('add','comm_category'))">
						<el-option v-for="o in list_comm_category" :key="o['prod_category']" :label="o['prod_category']"
							:value="o['prod_category']">
						</el-option>
					</el-select>
					<div v-else-if="$check_field('get','comm_category')">{{form['comm_category']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','compreh_eva') || $check_field('add','compreh_eva') || $check_field('set','compreh_eva')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="综合评价" prop="compreh_eva">
												<el-input id="compreh_eva" v-model="form['compreh_eva']" placeholder="请输入综合评价"
							  v-if="(form['supply_infor_id'] && $check_field('set','compreh_eva')) || (!form['supply_infor_id'] && $check_field('add','compreh_eva'))" :disabled="disabledObj['compreh_eva_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','compreh_eva')">{{form['compreh_eva']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','supply_freq') || $check_field('add','supply_freq') || $check_field('set','supply_freq')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="供应频率" prop="supply_freq">
												<el-input id="supply_freq" v-model="form['supply_freq']" placeholder="请输入供应频率"
							  v-if="(form['supply_infor_id'] && $check_field('set','supply_freq')) || (!form['supply_infor_id'] && $check_field('add','supply_freq'))" :disabled="disabledObj['supply_freq_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','supply_freq')">{{form['supply_freq']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','supply_products') || $check_field('add','supply_products') || $check_field('set','supply_products')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="供应产品" prop="supply_products">
								<el-input type="textarea" id="supply_products" v-model="form['supply_products']" placeholder="请输入供应产品"
						v-if="(form['supply_infor_id'] && $check_field('set','supply_products')) || (!form['supply_infor_id'] && $check_field('add','supply_products'))" :disabled="disabledObj['supply_products_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','supply_products')">{{form['supply_products']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_quality') || $check_field('add','product_quality') || $check_field('set','product_quality')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="产品质量" prop="product_quality">
								<el-input type="textarea" id="product_quality" v-model="form['product_quality']" placeholder="请输入产品质量"
						v-if="(form['supply_infor_id'] && $check_field('set','product_quality')) || (!form['supply_infor_id'] && $check_field('add','product_quality'))" :disabled="disabledObj['product_quality_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_quality')">{{form['product_quality']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','cooperation_situ') || $check_field('add','cooperation_situ') || $check_field('set','cooperation_situ')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="合作情况" prop="cooperation_situ">
								<el-input type="textarea" id="cooperation_situ" v-model="form['cooperation_situ']" placeholder="请输入合作情况"
						v-if="(form['supply_infor_id'] && $check_field('set','cooperation_situ')) || (!form['supply_infor_id'] && $check_field('add','cooperation_situ'))" :disabled="disabledObj['cooperation_situ_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','cooperation_situ')">{{form['cooperation_situ']}}</div>
							</el-form-item>
			</el-col>
						
	
	
		
		
	
	
	
	
	</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/supply_information/view','set') || $check_action('/supply_information/view','add')">
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
				field: "supply_infor_id",
				url_add: "~/api/supply_information/add?",
				url_set: "~/api/supply_information/set?",
				url_get_obj: "~/api/supply_information/get_obj?",
				url_upload: "~/api/supply_information/upload?",

				query: {
					"supply_infor_id": 0,
				},

				form: {
								"supplier_na":  '', // 供应商名称
										"suppliers_phone_number":  '', // 供应商电话
										"comm_category":  '', // 商品类别
										"compreh_eva":  '', // 综合评价
										"supply_freq":  '', // 供应频率
										"supply_products":  '', // 供应产品
										"product_quality":  '', // 产品质量
										"cooperation_situ":  '', // 合作情况
											"supply_infor_id": 0, // ID
													},
				disabledObj:{
								"supplier_na_isDisabled": false,
										"suppliers_phone_number_isDisabled": false,
										"comm_category_isDisabled": false,
										"compreh_eva_isDisabled": false,
										"supply_freq_isDisabled": false,
										"supply_products_isDisabled": false,
										"product_quality_isDisabled": false,
										"cooperation_situ_isDisabled": false,
										},

	
				
										// 商品类别选项列表
				list_comm_category: [""],
	
				
				
				
				
				
			
			}
		},
		methods: {

	
	
			
	
			
				/**
			 * 获取商品类别列表
			 */
			async get_list_comm_category() {
				var json = await this.$get("~/api/commodity_information/get_list?");
				if(json.result && json.result.list){
					this.list_comm_category = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
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
																								let suppliers_phone_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
				if(param.suppliers_phone_number && !suppliers_phone_number_phone_regular.test(param.suppliers_phone_number)){
					return "手机号格式错误"
				}
																																																																																return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/supply_information/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/supply_information/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/supply_information/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/supply_information/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/supply_information/view','get');
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
								this.get_list_comm_category();
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
