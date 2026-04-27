<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
							<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品编码" prop="product_code">
															<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码"
							  v-if="(form['inventory_information_id'] && $check_field('set','product_code')) || (!form['inventory_information_id'] && $check_field('add','product_code'))" :disabled="disabledObj['product_code_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_code')">{{form['product_code']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品名称" prop="product_name">
															<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称"
							  v-if="(form['inventory_information_id'] && $check_field('set','product_name')) || (!form['inventory_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_name')">{{form['product_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品类别" prop="product_category">
															<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别"
							  v-if="(form['inventory_information_id'] && $check_field('set','product_category')) || (!form['inventory_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_category')">{{form['product_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品品牌" prop="product_brand">
															<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌"
							  v-if="(form['inventory_information_id'] && $check_field('set','product_brand')) || (!form['inventory_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_brand')">{{form['product_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_inventory') || $check_field('add','product_inventory') || $check_field('set','product_inventory')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品库存" prop="product_inventory">
											<el-input-number id="product_inventory" v-model.number="form['product_inventory']"
						v-if="(form['inventory_information_id'] && $check_field('set','product_inventory')) || (!form['inventory_information_id'] && $check_field('add','product_inventory'))" :disabled="disabledObj['product_inventory_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','product_inventory')">{{form['product_inventory']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','check_date') || $check_field('add','check_date') || $check_field('set','check_date')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="核对日期" prop="check_date">
											<el-date-picker :disabled="disabledObj['check_date_isDisabled']" v-if="(form['inventory_information_id'] && $check_field('set','check_date')) || (!form['inventory_information_id'] && $check_field('add','check_date'))" id="check_date"
						v-model="form['check_date']" type="date" placeholder="选择日期" :picker-options="check_date_disableOptions" value-format="yyyy-MM-dd">
					</el-date-picker>
					<div v-else-if="$check_field('get','check_date')">{{form['check_date']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','check_quantity') || $check_field('add','check_quantity') || $check_field('set','check_quantity')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="核对数量" prop="check_quantity">
											<el-input-number id="check_quantity" v-model.number="form['check_quantity']"
						v-if="(form['inventory_information_id'] && $check_field('set','check_quantity')) || (!form['inventory_information_id'] && $check_field('add','check_quantity'))" :disabled="disabledObj['check_quantity_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','check_quantity')">{{form['check_quantity']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','inventory') || $check_field('add','inventory') || $check_field('set','inventory')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="库存情况" prop="inventory">
											<el-input type="textarea" id="inventory" v-model="form['inventory']" placeholder="请输入库存情况"
						v-if="(form['inventory_information_id'] && $check_field('set','inventory')) || (!form['inventory_information_id'] && $check_field('add','inventory'))" :disabled="disabledObj['inventory_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','inventory')">{{form['inventory']}}</div>
							</el-form-item>
			</el-col>
						
	
	
		
		
	
	
	
		
		
	
		</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/inventory_information/view','set') || $check_action('/inventory_information/view','add')">
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
				field: "inventory_information_id",
				url_add: "~/api/inventory_information/add?",
				url_set: "~/api/inventory_information/set?",
				url_get_obj: "~/api/inventory_information/get_obj?",
				url_upload: "~/api/inventory_information/upload?",

				query: {
					"inventory_information_id": 0,
				},

				form: {
								"product_code":  '', // 商品编码
										"product_name":  '', // 商品名称
										"product_category":  '', // 商品类别
										"product_brand":  '', // 商品品牌
										"product_inventory":  0, // 商品库存
										"check_date":  '', // 核对日期
										"check_quantity":  0, // 核对数量
										"inventory":  '', // 库存情况
											"inventory_information_id": 0, // ID
															},
				disabledObj:{
								"product_code_isDisabled": false,
										"product_name_isDisabled": false,
										"product_category_isDisabled": false,
										"product_brand_isDisabled": false,
					          			"product_inventory_isDisabled": false,
										"check_date_isDisabled": false,
					          			"check_quantity_isDisabled": false,
										"inventory_isDisabled": false,
										},

	
			
			
			
			
			
					check_date_disableOptions: {
				disabledDate(time) {
					return time.getTime() < Date.now() - 8.64e7;
				},
			},
		
			
		
			}
		},
		methods: {

	
	
			
	
			
	
			
	
			
	
			
	
			
	
			
	
		
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
						        if (this.form["check_date"] && JSON.stringify(this.form["check_date"]).indexOf("-")===-1){
          this.form["check_date"] = this.$toTime(parseInt(this.form["check_date"]),"yyyy-MM-dd")
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
																															if(this.form["check_date"]=="0000-00-00"){
				  this.form["check_date"] = null;
				}
				if(parseInt(this.form["check_date"]) > 9999){
					this.form["check_date"] = this.$toTime(parseInt(this.form["check_date"]),"yyyy-MM-dd")
				}
														

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
					
																																																														if (!param.check_date){
					return "核对日期不能为空";
				}
																																						return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/inventory_information/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/inventory_information/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/inventory_information/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/inventory_information/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/inventory_information/view','get');
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
