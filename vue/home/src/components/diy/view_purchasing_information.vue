<template>
	<el-main class="bg edit_wrap">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce">
							<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品编码" prop="prod_code">
												<el-input id="prod_code" v-model="form['prod_code']" placeholder="请输入商品编码"
							  v-if="(form['purch_inf_id'] && $check_field('set','prod_code')) || (!form['purch_inf_id'] && $check_field('add','prod_code'))" :disabled="disabledObj['prod_code_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_code')">{{form['prod_code']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_name') || $check_field('add','prod_name') || $check_field('set','prod_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品名称" prop="prod_name">
												<el-input id="prod_name" v-model="form['prod_name']" placeholder="请输入商品名称"
							  v-if="(form['purch_inf_id'] && $check_field('set','prod_name')) || (!form['purch_inf_id'] && $check_field('add','prod_name'))" :disabled="disabledObj['prod_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_name')">{{form['prod_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_category') || $check_field('add','prod_category') || $check_field('set','prod_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品类别" prop="prod_category">
												<el-input id="prod_category" v-model="form['prod_category']" placeholder="请输入商品类别"
							  v-if="(form['purch_inf_id'] && $check_field('set','prod_category')) || (!form['purch_inf_id'] && $check_field('add','prod_category'))" :disabled="disabledObj['prod_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_category')">{{form['prod_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_brand') || $check_field('add','prod_brand') || $check_field('set','prod_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品品牌" prop="prod_brand">
												<el-input id="prod_brand" v-model="form['prod_brand']" placeholder="请输入商品品牌"
							  v-if="(form['purch_inf_id'] && $check_field('set','prod_brand')) || (!form['purch_inf_id'] && $check_field('add','prod_brand'))" :disabled="disabledObj['prod_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_brand')">{{form['prod_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','comm_spec') || $check_field('add','comm_spec') || $check_field('set','comm_spec')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品规格" prop="comm_spec">
												<el-input id="comm_spec" v-model="form['comm_spec']" placeholder="请输入商品规格"
							  v-if="(form['purch_inf_id'] && $check_field('set','comm_spec')) || (!form['purch_inf_id'] && $check_field('add','comm_spec'))" :disabled="disabledObj['comm_spec_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','comm_spec')">{{form['comm_spec']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','comm_price') || $check_field('add','comm_price') || $check_field('set','comm_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品价格" prop="comm_price">
								<el-input-number id="comm_price" v-model.number="form['comm_price']" :min="0"
						v-if="(form['purch_inf_id'] && $check_field('set','comm_price')) || (!form['purch_inf_id'] && $check_field('add','comm_price'))" :disabled="disabledObj['comm_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','comm_price')">{{form['comm_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purch_order_number') || $check_field('add','purch_order_number') || $check_field('set','purch_order_number')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="采购单号" prop="purch_order_number">
												<el-input id="purch_order_number" v-model="form['purch_order_number']" placeholder="请输入采购单号"
							  v-if="(form['purch_inf_id'] && $check_field('set','purch_order_number')) || (!form['purch_inf_id'] && $check_field('add','purch_order_number'))" :disabled="true"></el-input>
					<div v-else-if="$check_field('get','purch_order_number')">{{form['purch_order_number']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','supplier_na') || $check_field('add','supplier_na') || $check_field('set','supplier_na')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="供应商名称" prop="supplier_na">
								<el-select id="supplier_na" v-model="form['supplier_na']"						v-if="(form['purch_inf_id'] && $check_field('set','supplier_na')) || (!form['purch_inf_id'] && $check_field('add','supplier_na'))">
						<el-option v-for="o in list_supplier_na" :key="o['supplier_na']" :label="o['supplier_na']"
							:value="o['supplier_na']">
						</el-option>
					</el-select>
					<div v-else-if="$check_field('get','supplier_na')">{{form['supplier_na']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purch_date') || $check_field('add','purch_date') || $check_field('set','purch_date')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="采购日期" prop="purch_date">
								<el-date-picker :disabled="disabledObj['purch_date_isDisabled']" v-if="(form['purch_inf_id'] && $check_field('set','purch_date')) || (!form['purch_inf_id'] && $check_field('add','purch_date'))" id="purch_date"
						v-model="form['purch_date']" type="date" placeholder="选择日期" :picker-options="purch_date_disableOptions" value-format="yyyy-MM-dd">
					</el-date-picker>
					<div v-else-if="$check_field('get','purch_date')">{{form['purch_date']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purch_quantity') || $check_field('add','purch_quantity') || $check_field('set','purch_quantity')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="采购数量" prop="purch_quantity">
								<el-input-number id="purch_quantity" v-model.number="form['purch_quantity']" :min="0"
						v-if="(form['purch_inf_id'] && $check_field('set','purch_quantity')) || (!form['purch_inf_id'] && $check_field('add','purch_quantity'))" :disabled="disabledObj['purch_quantity_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','purch_quantity')">{{form['purch_quantity']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purch_unit_price') || $check_field('add','purch_unit_price') || $check_field('set','purch_unit_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="采购单价" prop="purch_unit_price">
								<el-input-number id="purch_unit_price" v-model.number="form['purch_unit_price']" :min="0"
						v-if="(form['purch_inf_id'] && $check_field('set','purch_unit_price')) || (!form['purch_inf_id'] && $check_field('add','purch_unit_price'))" :disabled="disabledObj['purch_unit_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','purch_unit_price')">{{form['purch_unit_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','total_purch_price') || $check_field('add','total_purch_price') || $check_field('set','total_purch_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="采购总价" prop="total_purch_price">
								{{toFixed(form['purch_quantity'] * form['purch_unit_price'])}}
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','procur_status') || $check_field('add','procur_status') || $check_field('set','procur_status')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="采购情况" prop="procur_status">
								<el-input type="textarea" id="procur_status" v-model="form['procur_status']" placeholder="请输入采购情况"
						v-if="(form['purch_inf_id'] && $check_field('set','procur_status')) || (!form['purch_inf_id'] && $check_field('add','procur_status'))" :disabled="disabledObj['procur_status_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','procur_status')">{{form['procur_status']}}</div>
							</el-form-item>
			</el-col>
						
	
	
		
		
	
	
	
	
	</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/purchasing_information/view','set') || $check_action('/purchasing_information/view','add')">
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
				field: "purch_inf_id",
				url_add: "~/api/purchasing_information/add?",
				url_set: "~/api/purchasing_information/set?",
				url_get_obj: "~/api/purchasing_information/get_obj?",
				url_upload: "~/api/purchasing_information/upload?",

				query: {
					"purch_inf_id": 0,
				},

				form: {
								"prod_code":  '', // 商品编码
										"prod_name":  '', // 商品名称
										"prod_category":  '', // 商品类别
										"prod_brand":  '', // 商品品牌
										"comm_spec":  '', // 商品规格
										"comm_price":  0, // 商品价格
										"purch_order_number": this.$get_stamp(), // 采购单号
										"supplier_na":  '', // 供应商名称
										"purch_date":  '', // 采购日期
										"purch_quantity":  0, // 采购数量
										"purch_unit_price":  0, // 采购单价
															"procur_status":  '', // 采购情况
											"purch_inf_id": 0, // ID
													},
				disabledObj:{
								"prod_code_isDisabled": false,
										"prod_name_isDisabled": false,
										"prod_category_isDisabled": false,
										"prod_brand_isDisabled": false,
										"comm_spec_isDisabled": false,
					          			"comm_price_isDisabled": false,
										"purch_order_number_isDisabled": false,
										"supplier_na_isDisabled": false,
										"purch_date_isDisabled": false,
					          			"purch_quantity_isDisabled": false,
					          			"purch_unit_price_isDisabled": false,
					          			"total_purch_price_isDisabled": false,
										"procur_status_isDisabled": false,
										},

	
				
				
				
				
				
				
										// 供应商名称选项列表
				list_supplier_na: [""],
	
				
						purch_date_disableOptions: {
					disabledDate(time) {
						return time.getTime() < Date.now() - 8.64e7;
					},
				},
			
				
				
				
			
			}
		},
		methods: {

	
	
			
	
			
	
			
	
			
	
			
	
			
	
			
				/**
			 * 获取供应商名称列表
			 */
			async get_list_supplier_na() {
				var json = await this.$get("~/api/supply_information/get_list?");
				if(json.result && json.result.list){
					this.list_supplier_na = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
					
			
	
			
	
			
	
			
	
										set_total_purch_price(){
				this.form.total_purch_price = parseFloat(this.form.purch_quantity) * parseFloat(this.form.purch_unit_price)
			},
							// 自动计算精度处理
		toFixed: function(num){
			if (!isNaN(num)) {
				return ((num + '').indexOf('.') == -1) ? num : num.toFixed(2);
			}
		},
		
	
		
			/**
			 * 获取对象之前
			 * @param {Object} param
			 */
			get_obj_before(param) {
				var form = "";
											// 获取缓存数据附加
				form = $.db.get("form");
									$.push(this.form ,form);
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
							if(dbKey === "sour_table"){
								this.form['sour_table'] = form[dbKey];
							}
							if(dbKey === "sour_id"){
								this.form['sour_id'] = form[dbKey];
							}
							if(dbKey === "sour_user_id"){
								this.form['sour_user_id'] = form[dbKey];
							}
						})
					})
				}
																		        if (this.form["purch_date"] && JSON.stringify(this.form["purch_date"]).indexOf("-")===-1){
          this.form["purch_date"] = this.$toTime(parseInt(this.form["purch_date"]),"yyyy-MM-dd")
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

																																														if(json.result.obj["purch_date"]=="0000-00-00"){
				  json.result.obj["purch_date"] = null;
				}
				if(parseInt(json.result.obj["purch_date"]) > 9999){
					json.result.obj["purch_date"] = this.$toTime(parseInt(json.result.obj["purch_date"]),"yyyy-MM-dd")
				}
																								

			},

																																																																																									/**
					 * 提交前事件
					 * @param {Object} param 提交参数
					 */
					submit_before: function(param) {
						// console.log('提交前事件', param);
						// 保存计算结果
																																																																																																																																																																				this.set_total_purch_price()
																																param = this.form
						// 循环参数
						for(var key in param){
							// 错误回调
							try{
								var value = param[key];
								// 值判断与值校验
								console.log("键 ,值 ,类型" ,key ,value ,value instanceof Date);
								if(value && value instanceof Date){
									param[key] = this.$toTime(value ,"yyyy-MM-dd hh:mm:ss");
								}
							}
							catch(err){
								console.log(key ,"转日期错误：" ,err ,"收到请无视!");
							}
						}
						return param;
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
								return '单价不能小于0';
							}
							if (param.purch_quantity === null || param.purch_quantity === undefined || param.purch_quantity < 0) {
								return '数量不能小于0';
							}
							if (param.purch_unit_price === null || param.purch_unit_price === undefined || param.purch_unit_price < 0) {
								return '采购单价不能小于0';
							}
							if (!param.purch_date){
								return "采购日期不能为空";
							}
							return null;
						},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/purchasing_information/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/view','get');
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
																		this.get_list_supplier_na();
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
