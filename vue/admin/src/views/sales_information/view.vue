<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
							<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品编码" prop="product_code">
															<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码"
							  v-if="(form['sales_information_id'] && $check_field('set','product_code')) || (!form['sales_information_id'] && $check_field('add','product_code'))" :disabled="disabledObj['product_code_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_code')">{{form['product_code']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品名称" prop="product_name">
															<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称"
							  v-if="(form['sales_information_id'] && $check_field('set','product_name')) || (!form['sales_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_name')">{{form['product_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品类别" prop="product_category">
															<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别"
							  v-if="(form['sales_information_id'] && $check_field('set','product_category')) || (!form['sales_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_category')">{{form['product_category']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品品牌" prop="product_brand">
															<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌"
							  v-if="(form['sales_information_id'] && $check_field('set','product_brand')) || (!form['sales_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_brand')">{{form['product_brand']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','merchandise_price') || $check_field('add','merchandise_price') || $check_field('set','merchandise_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商品价格" prop="merchandise_price">
											<el-input-number id="merchandise_price" v-model.number="form['merchandise_price']"
						v-if="(form['sales_information_id'] && $check_field('set','merchandise_price')) || (!form['sales_information_id'] && $check_field('add','merchandise_price'))" :disabled="disabledObj['merchandise_price_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','merchandise_price')">{{form['merchandise_price']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','sales_order_number') || $check_field('add','sales_order_number') || $check_field('set','sales_order_number')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="销售单号" prop="sales_order_number">
															<el-input id="sales_order_number" v-model="form['sales_order_number']" placeholder="请输入销售单号"
							  v-if="(form['sales_information_id'] && $check_field('set','sales_order_number')) || (!form['sales_information_id'] && $check_field('add','sales_order_number'))" :disabled="true"></el-input>
					<div v-else-if="$check_field('get','sales_order_number')">{{form['sales_order_number']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','user_id') || $check_field('add','user_id') || $check_field('set','user_id')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="注册用户" prop="user_id">
																					<div v-if="user_group !== '管理员'">
							{{ get_user_session_user_id(form['user_id']) }}
							<el-select v-if="(form['sales_information_id'] && $check_field('set','user_id')) || (!form['sales_information_id'] && $check_field('add','user_id'))" id="user_id" v-model="form['user_id']" :disabled="disabledObj['user_id_isDisabled']">
								<el-option v-for="o in list_user_user_id" :key="o['usr_name']" :label="o['nick_name'] + '-' + o['usr_name']"
										   :value="o['user_id']">
								</el-option>
							</el-select>
							<el-select v-else-if="$check_field('get','user_id')" id="user_id" v-model="form['user_id']" :disabled="true">
								<el-option v-for="o in list_user_user_id" :key="o['usr_name']" :label="o['nick_name'] + '-' + o['usr_name']"
										   :value="o['user_id']">
								</el-option>
							</el-select>
						</div>
						<el-select v-else id="user_id" v-model="form['user_id']" :disabled="disabledObj['user_id_isDisabled']">
							<el-option v-for="o in list_user_user_id" :key="o['usr_name']" :label="o['nick_name'] + '-' + o['usr_name']"
									   :value="o['user_id']">
							</el-option>
						</el-select>
																</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','user_name') || $check_field('add','user_name') || $check_field('set','user_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="用户姓名" prop="user_name">
															<el-input id="user_name" v-model="form['user_name']" placeholder="请输入用户姓名"
							  v-if="(form['sales_information_id'] && $check_field('set','user_name')) || (!form['sales_information_id'] && $check_field('add','user_name'))" :disabled="disabledObj['user_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','user_name')">{{form['user_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','order_quantity') || $check_field('add','order_quantity') || $check_field('set','order_quantity')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="下单数量" prop="order_quantity">
											<el-input-number id="order_quantity" v-model.number="form['order_quantity']"
						v-if="(form['sales_information_id'] && $check_field('set','order_quantity')) || (!form['sales_information_id'] && $check_field('add','order_quantity'))" :disabled="disabledObj['order_quantity_isDisabled']"></el-input-number>
					<div v-else-if="$check_field('get','order_quantity')">{{form['order_quantity']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','total_order_price') || $check_field('add','total_order_price') || $check_field('set','total_order_price')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="订单总价" prop="total_order_price">
											{{toFixed(form['merchandise_price'] * form['order_quantity'])}}
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','note_information') || $check_field('add','note_information') || $check_field('set','note_information')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="备注信息" prop="note_information">
											<el-input type="textarea" id="note_information" v-model="form['note_information']" placeholder="请输入备注信息"
						v-if="(form['sales_information_id'] && $check_field('set','note_information')) || (!form['sales_information_id'] && $check_field('add','note_information'))" :disabled="disabledObj['note_information_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','note_information')">{{form['note_information']}}</div>
							</el-form-item>
			</el-col>
						
	
	
		
		
	
	
	
		
		
	
		</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/sales_information/view','set') || $check_action('/sales_information/view','add')">
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
				field: "sales_information_id",
				url_add: "~/api/sales_information/add?",
				url_set: "~/api/sales_information/set?",
				url_get_obj: "~/api/sales_information/get_obj?",
				url_upload: "~/api/sales_information/upload?",

				query: {
					"sales_information_id": 0,
				},

				form: {
								"product_code":  '', // 商品编码
										"product_name":  '', // 商品名称
										"product_category":  '', // 商品类别
										"product_brand":  '', // 商品品牌
										"merchandise_price":  0, // 商品价格
										"sales_order_number": this.$get_stamp(), // 销售单号
										"user_id": 0, // 注册用户
										"user_name":  '', // 用户姓名
										"order_quantity":  0, // 下单数量
										"total_order_price": 0,
										"note_information":  '', // 备注信息
											"sales_information_id": 0, // ID
															},
				disabledObj:{
								"product_code_isDisabled": false,
										"product_name_isDisabled": false,
										"product_category_isDisabled": false,
										"product_brand_isDisabled": false,
					          			"merchandise_price_isDisabled": false,
										"sales_order_number_isDisabled": false,
										"user_id_isDisabled": false,
										"user_name_isDisabled": false,
					          			"order_quantity_isDisabled": false,
					          			"total_order_price_isDisabled": false,
										"note_information_isDisabled": false,
										},

	
			
			
			
			
			
			
					// 用户列表
				list_user_user_id: [],
						// 用户组
				group_user_user_id: "",
					
			
			
			
		
			}
		},
		methods: {

	
	
			
	
			
	
			
	
			
	
			
	
			
	
				/**
			 * 获取注册用户用户列表
			 */
			async get_list_user_user_id() {
                var json = await this.$get("~/api/user/get_list?user_group=注册用户");
                if(json.result && json.result.list){
                    this.list_user_user_id = json.result.list;
                }
                else if(json.error){
                    console.error(json.error);
                }
			},
					/**
			 * 获取注册用户用户组
			 */
			async get_group_user_user_id() {
							this.form["user_id"] = this.user.user_id;
							var json = await this.$get("~/api/user_group/get_obj?name=注册用户");
				if(json.result && json.result.obj){
					this.group_user_user_id = json.result.obj;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			get_user_session_user_id(id){
				var _this = this;
				var user_id = {"user_id":id}
				var url = "~/api/"+_this.group_user_user_id.source_table+"/get_obj?"
				this.$get(url, user_id, function(res) {
					if (res.result && res.result.obj) {
						var arr = []
						for (let key in res.result.obj) {
							arr.push(key)
						}
						var arrForm = []
									for (let key in _this.form) {
							arrForm.push(key)
						}
												_this.form["user_id"] = id
									_this.disabledObj['user_id' + '_isDisabled'] = true
						for (var i=0;i<arr.length;i++){
						  if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
							for (var j = 0; j < arrForm.length; j++) {
							  if (arr[i] === arrForm[j]) {
								if (arr[i] !== "user_id") {
			                      _this.form[arrForm[j]] = res.result.obj[arr[i]]
			                      _this.disabledObj[arrForm[j] + '_isDisabled'] = true
								  break;
								} else {
								  _this.disabledObj[arrForm[j] + '_isDisabled'] = true
								}
							  }
							}
						  }
						}
					}
				});
			},
					get_user_user_id(id){
				var obj = this.list_user_user_id.getObj({"user_id":id});
				var ret = "";
				if(obj){
					if(obj.nick_name){
						ret = obj.nick_name;}
					else{
						ret = obj.usr_name;
					}
				}
				return ret;
			},
			
	
			
	
			
	
										set_total_order_price(){
				this.form.total_order_price = parseFloat(this.form.merchandise_price) * parseFloat(this.form.order_quantity)
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

																																																																											/**
					 * 提交前事件
					 * @param {Object} param 提交参数
					 */
					submit_before: function(param) {
						// 保存计算结果
																																																																																																																																										this.set_total_order_price()
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
					
																																																																																																																															return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/sales_information/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/sales_information/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/sales_information/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/sales_information/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/sales_information/view','get');
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
																	this.get_list_user_user_id();
					this.get_group_user_user_id();
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
