<template>
	<el-main class="bg edit_wrap">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce">
							<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品编码" prop="prod_code">
												<el-input id="prod_code" v-model="form['prod_code']" placeholder="请输入商品编码"
							  v-if="(form['invent_info_id'] && $check_field('set','prod_code')) || (!form['invent_info_id'] && $check_field('add','prod_code'))" :disabled="disabledObj['prod_code_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_code')">{{form['prod_code']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_name') || $check_field('add','prod_name') || $check_field('set','prod_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品名称" prop="prod_name">
												<el-input id="prod_name" v-model="form['prod_name']" placeholder="请输入商品名称"
							  v-if="(form['invent_info_id'] && $check_field('set','prod_name')) || (!form['invent_info_id'] && $check_field('add','prod_name'))" :disabled="disabledObj['prod_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_name')">{{form['prod_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_category') || $check_field('add','prod_category') || $check_field('set','prod_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品类别" prop="prod_category">
												<el-input id="prod_category" v-model="form['prod_category']" placeholder="请输入商品类别"
							  v-if="(form['invent_info_id'] && $check_field('set','prod_category')) || (!form['invent_info_id'] && $check_field('add','prod_category'))" :disabled="disabledObj['prod_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_category')">{{form['prod_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_brand') || $check_field('add','prod_brand') || $check_field('set','prod_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品品牌" prop="prod_brand">
												<el-input id="prod_brand" v-model="form['prod_brand']" placeholder="请输入商品品牌"
							  v-if="(form['invent_info_id'] && $check_field('set','prod_brand')) || (!form['invent_info_id'] && $check_field('add','prod_brand'))" :disabled="disabledObj['prod_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','prod_brand')">{{form['prod_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','prod_invent') || $check_field('add','prod_invent') || $check_field('set','prod_invent')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="商品库存" prop="prod_invent">
								<el-input-number id="prod_invent" v-model.number="form['prod_invent']" :min="0"
						v-if="(form['invent_info_id'] && $check_field('set','prod_invent')) || (!form['invent_info_id'] && $check_field('add','prod_invent'))" :disabled="disabledObj['prod_invent_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','prod_invent')">{{form['prod_invent']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','check_date') || $check_field('add','check_date') || $check_field('set','check_date')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="核对日期" prop="check_date">
								<el-date-picker :disabled="disabledObj['check_date_isDisabled']" v-if="(form['invent_info_id'] && $check_field('set','check_date')) || (!form['invent_info_id'] && $check_field('add','check_date'))" id="check_date"
						v-model="form['check_date']" type="date" placeholder="选择日期" :picker-options="check_date_disableOptions" value-format="yyyy-MM-dd">
					</el-date-picker>
					<div v-else-if="$check_field('get','check_date')">{{form['check_date']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','check_quant') || $check_field('add','check_quant') || $check_field('set','check_quant')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="核对数量" prop="check_quant">
								<el-input-number id="check_quant" v-model.number="form['check_quant']" :min="0"
						v-if="(form['invent_info_id'] && $check_field('set','check_quant')) || (!form['invent_info_id'] && $check_field('add','check_quant'))" :disabled="disabledObj['check_quant_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','check_quant')">{{form['check_quant']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','inventory') || $check_field('add','inventory') || $check_field('set','inventory')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
				<el-form-item label="库存情况" prop="inventory">
								<el-input type="textarea" id="inventory" v-model="form['inventory']" placeholder="请输入库存情况"
						v-if="(form['invent_info_id'] && $check_field('set','inventory')) || (!form['invent_info_id'] && $check_field('add','inventory'))" :disabled="disabledObj['inventory_isDisabled']"></el-input>
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
				field: "invent_info_id",
				url_add: "~/api/inventory_information/add?",
				url_set: "~/api/inventory_information/set?",
				url_get_obj: "~/api/inventory_information/get_obj?",
				url_upload: "~/api/inventory_information/upload?",

				query: {
					"invent_info_id": 0,
				},

				form: {
								"prod_code":  '', // 商品编码
										"prod_name":  '', // 商品名称
										"prod_category":  '', // 商品类别
										"prod_brand":  '', // 商品品牌
										"prod_invent":  0, // 商品库存
										"check_date":  '', // 核对日期
										"check_quant":  0, // 核对数量
										"inventory":  '', // 库存情况
											"invent_info_id": 0, // ID
													},
				disabledObj:{
								"prod_code_isDisabled": false,
										"prod_name_isDisabled": false,
										"prod_category_isDisabled": false,
										"prod_brand_isDisabled": false,
					          			"prod_invent_isDisabled": false,
										"check_date_isDisabled": false,
					          			"check_quant_isDisabled": false,
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

																															if(json.result.obj["check_date"]=="0000-00-00"){
				  json.result.obj["check_date"] = null;
				}
				if(parseInt(json.result.obj["check_date"]) > 9999){
					json.result.obj["check_date"] = this.$toTime(parseInt(json.result.obj["check_date"]),"yyyy-MM-dd")
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
							if (param.prod_invent === null || param.prod_invent === undefined || param.prod_invent < 0) {
								return '库存不能小于0';
							}
							if (param.check_quant === null || param.check_quant === undefined || param.check_quant < 0) {
								return '核对数量不能小于0';
							}
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
