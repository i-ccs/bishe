<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
							<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品编码" prop="product_code">
															<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码"
							  v-if="(form['purchasing_information_id'] && $check_field('set','product_code')) || (!form['purchasing_information_id'] && $check_field('add','product_code'))" :disabled="disabledObj['product_code_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_code')">{{form['product_code']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品名称" prop="product_name">
															<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称"
							  v-if="(form['purchasing_information_id'] && $check_field('set','product_name')) || (!form['purchasing_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_name')">{{form['product_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品类别" prop="product_category">
															<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别"
							  v-if="(form['purchasing_information_id'] && $check_field('set','product_category')) || (!form['purchasing_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_category')">{{form['product_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品品牌" prop="product_brand">
															<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌"
							  v-if="(form['purchasing_information_id'] && $check_field('set','product_brand')) || (!form['purchasing_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_brand')">{{form['product_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','merchandise_specifications') || $check_field('add','merchandise_specifications') || $check_field('set','merchandise_specifications')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品规格" prop="merchandise_specifications">
															<el-input id="merchandise_specifications" v-model="form['merchandise_specifications']" placeholder="请输入商品规格"
							  v-if="(form['purchasing_information_id'] && $check_field('set','merchandise_specifications')) || (!form['purchasing_information_id'] && $check_field('add','merchandise_specifications'))" :disabled="disabledObj['merchandise_specifications_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','merchandise_specifications')">{{form['merchandise_specifications']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','merchandise_price') || $check_field('add','merchandise_price') || $check_field('set','merchandise_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品价格" prop="merchandise_price">
											<el-input-number id="merchandise_price" v-model.number="form['merchandise_price']"
						v-if="(form['purchasing_information_id'] && $check_field('set','merchandise_price')) || (!form['purchasing_information_id'] && $check_field('add','merchandise_price'))" :disabled="disabledObj['merchandise_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','merchandise_price')">{{form['merchandise_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purchase_order_number') || $check_field('add','purchase_order_number') || $check_field('set','purchase_order_number')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="采购单号" prop="purchase_order_number">
															<el-input id="purchase_order_number" v-model="form['purchase_order_number']" placeholder="请输入采购单号"
							  v-if="(form['purchasing_information_id'] && $check_field('set','purchase_order_number')) || (!form['purchasing_information_id'] && $check_field('add','purchase_order_number'))" :disabled="true"></el-input>
					<div v-else-if="$check_field('get','purchase_order_number')">{{form['purchase_order_number']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','supplier_name') || $check_field('add','supplier_name') || $check_field('set','supplier_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="供应商名称" prop="supplier_name">
											<el-select id="supplier_name" v-model="form['supplier_name']"						v-if="(form['purchasing_information_id'] && $check_field('set','supplier_name')) || (!form['purchasing_information_id'] && $check_field('add','supplier_name'))">
						<el-option v-for="o in list_supplier_name" :key="o['supplier_name']" :label="o['supplier_name']"
							:value="o['supplier_name']">
						</el-option>
					</el-select>
					<div v-else-if="$check_field('get','supplier_name')">{{form['supplier_name']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purchase_date') || $check_field('add','purchase_date') || $check_field('set','purchase_date')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="采购日期" prop="purchase_date">
											<el-date-picker :disabled="disabledObj['purchase_date_isDisabled']" v-if="(form['purchasing_information_id'] && $check_field('set','purchase_date')) || (!form['purchasing_information_id'] && $check_field('add','purchase_date'))" id="purchase_date"
						v-model="form['purchase_date']" type="date" placeholder="选择日期" :picker-options="purchase_date_disableOptions" value-format="yyyy-MM-dd">
					</el-date-picker>
					<div v-else-if="$check_field('get','purchase_date')">{{form['purchase_date']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purchase_quantity') || $check_field('add','purchase_quantity') || $check_field('set','purchase_quantity')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="采购数量" prop="purchase_quantity">
											<el-input-number id="purchase_quantity" v-model.number="form['purchase_quantity']"
						v-if="(form['purchasing_information_id'] && $check_field('set','purchase_quantity')) || (!form['purchasing_information_id'] && $check_field('add','purchase_quantity'))" :disabled="disabledObj['purchase_quantity_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','purchase_quantity')">{{form['purchase_quantity']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','purchase_unit_price') || $check_field('add','purchase_unit_price') || $check_field('set','purchase_unit_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="采购单价" prop="purchase_unit_price">
											<el-input-number id="purchase_unit_price" v-model.number="form['purchase_unit_price']"
						v-if="(form['purchasing_information_id'] && $check_field('set','purchase_unit_price')) || (!form['purchasing_information_id'] && $check_field('add','purchase_unit_price'))" :disabled="disabledObj['purchase_unit_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','purchase_unit_price')">{{form['purchase_unit_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','total_purchase_price') || $check_field('add','total_purchase_price') || $check_field('set','total_purchase_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="采购总价" prop="total_purchase_price">
											{{toFixed(form['purchase_quantity'] * form['purchase_unit_price'])}}
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','procurement_status') || $check_field('add','procurement_status') || $check_field('set','procurement_status')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="采购情况" prop="procurement_status">
											<el-input type="textarea" id="procurement_status" v-model="form['procurement_status']" placeholder="请输入采购情况"
						v-if="(form['purchasing_information_id'] && $check_field('set','procurement_status')) || (!form['purchasing_information_id'] && $check_field('add','procurement_status'))" :disabled="disabledObj['procurement_status_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','procurement_status')">{{form['procurement_status']}}</div>
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
				field: "purchasing_information_id",
				url_add: "~/api/purchasing_information/add?",
				url_set: "~/api/purchasing_information/set?",
				url_get_obj: "~/api/purchasing_information/get_obj?",
				url_upload: "~/api/purchasing_information/upload?",

				query: {
					"purchasing_information_id": 0,
				},

				form: {
								"product_code":  '', // 商品编码
										"product_name":  '', // 商品名称
										"product_category":  '', // 商品类别
										"product_brand":  '', // 商品品牌
										"merchandise_specifications":  '', // 商品规格
										"merchandise_price":  0, // 商品价格
										"purchase_order_number": this.$get_stamp(), // 采购单号
										"supplier_name":  '', // 供应商名称
										"purchase_date":  '', // 采购日期
										"purchase_quantity":  0, // 采购数量
										"purchase_unit_price":  0, // 采购单价
										"total_purchase_price": 0,
										"procurement_status":  '', // 采购情况
											"purchasing_information_id": 0, // ID
															},
				disabledObj:{
								"product_code_isDisabled": false,
										"product_name_isDisabled": false,
										"product_category_isDisabled": false,
										"product_brand_isDisabled": false,
										"merchandise_specifications_isDisabled": false,
					          			"merchandise_price_isDisabled": false,
										"purchase_order_number_isDisabled": false,
										"supplier_name_isDisabled": false,
										"purchase_date_isDisabled": false,
					          			"purchase_quantity_isDisabled": false,
					          			"purchase_unit_price_isDisabled": false,
					          			"total_purchase_price_isDisabled": false,
										"procurement_status_isDisabled": false,
										},

	
			
			
			
			
			
			
									// 供应商名称选项列表
				list_supplier_name: [""],
	
			
					purchase_date_disableOptions: {
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
			
						async get_list_supplier_name() {
				var json = await this.$get("~/api/supply_information/get_list?");
				if(json.result && json.result.list){
					this.list_supplier_name = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
								
			
	
			
	
			
	
			
	
										set_total_purchase_price(){
				this.form.total_purchase_price = parseFloat(this.form.purchase_quantity) * parseFloat(this.form.purchase_unit_price)
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
									        if (this.form["purchase_date"] && JSON.stringify(this.form["purchase_date"]).indexOf("-")===-1){
          this.form["purchase_date"] = this.$toTime(parseInt(this.form["purchase_date"]),"yyyy-MM-dd")
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
																																														if(this.form["purchase_date"]=="0000-00-00"){
				  this.form["purchase_date"] = null;
				}
				if(parseInt(this.form["purchase_date"]) > 9999){
					this.form["purchase_date"] = this.$toTime(parseInt(this.form["purchase_date"]),"yyyy-MM-dd")
				}
																								

			},

																																																																																									/**
					 * 提交前事件
					 * @param {Object} param 提交参数
					 */
					submit_before: function(param) {
						// 保存计算结果
																																																																																																																																																																				this.set_total_purchase_price()
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
					
																																																																																															if (!param.purchase_date){
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
																		this.get_list_supplier_name();
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
