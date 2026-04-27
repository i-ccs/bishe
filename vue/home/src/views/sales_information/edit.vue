<template>
	<div class="diy_edit page_sales_information" id="sales_information_edit">
		<div class='warp'>
			<div class='container'>
				<div class='row diy_edit_content_box'>
						<div v-if="$check_field('set','product_code') || $check_field('add','product_code') || $check_field('get','product_code')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								商品编码:
							</span>
						</div>
								<!-- 文本 -->
									<div class="diy_field diy_text">
							<input type="text" id="form_product_code" v-model="form['product_code']" placeholder="请输入商品编码" v-if="(form['product_code'] && $check_field('set','product_code')) || (!form['product_code'] && $check_field('add','product_code'))"  :disabled="disabledObj['product_code_isDisabled']"/>
							<span v-else-if="$check_field('get','product_code')">{{ form['product_code'] }}</span>
						</div>
										</div>
							<div v-if="$check_field('set','product_name') || $check_field('add','product_name') || $check_field('get','product_name')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								商品名称:
							</span>
						</div>
								<!-- 文本 -->
									<div class="diy_field diy_text">
							<input type="text" id="form_product_name" v-model="form['product_name']" placeholder="请输入商品名称" v-if="(form['product_name'] && $check_field('set','product_name')) || (!form['product_name'] && $check_field('add','product_name'))"  :disabled="disabledObj['product_name_isDisabled']"/>
							<span v-else-if="$check_field('get','product_name')">{{ form['product_name'] }}</span>
						</div>
										</div>
							<div v-if="$check_field('set','product_category') || $check_field('add','product_category') || $check_field('get','product_category')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								商品类别:
							</span>
						</div>
								<!-- 文本 -->
									<div class="diy_field diy_text">
							<input type="text" id="form_product_category" v-model="form['product_category']" placeholder="请输入商品类别" v-if="(form['product_category'] && $check_field('set','product_category')) || (!form['product_category'] && $check_field('add','product_category'))"  :disabled="disabledObj['product_category_isDisabled']"/>
							<span v-else-if="$check_field('get','product_category')">{{ form['product_category'] }}</span>
						</div>
										</div>
							<div v-if="$check_field('set','product_brand') || $check_field('add','product_brand') || $check_field('get','product_brand')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								商品品牌:
							</span>
						</div>
								<!-- 文本 -->
									<div class="diy_field diy_text">
							<input type="text" id="form_product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌" v-if="(form['product_brand'] && $check_field('set','product_brand')) || (!form['product_brand'] && $check_field('add','product_brand'))"  :disabled="disabledObj['product_brand_isDisabled']"/>
							<span v-else-if="$check_field('get','product_brand')">{{ form['product_brand'] }}</span>
						</div>
										</div>
							<div v-if="$check_field('set','commodity_price') || $check_field('add','commodity_price') || $check_field('get','commodity_price')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								商品价格:
							</span>
						</div>
								<!-- 数字 -->
						<div class="diy_field diy_number">
							<input type="number" id="form_commodity_price" v-model.number="form['commodity_price']" placeholder="请输入商品价格" v-if="(form['commodity_price'] && $check_field('set','commodity_price')) || (!form['commodity_price'] && $check_field('add','commodity_price'))" :disabled="disabledObj['commodity_price_isDisabled']" />
							<span v-else-if="$check_field('get','commodity_price')">{{ form['commodity_price'] }}</span>
						</div>
							</div>
							<div v-if="$check_field('set','sales_order_number') || $check_field('add','sales_order_number') || $check_field('get','sales_order_number')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								销售单号:
							</span>
						</div>
								<!-- 文本 -->
									<div class="diy_field diy_text">
							<input type="text" id="form_sales_order_number" v-model="form['sales_order_number']" placeholder="请输入销售单号" v-if="(form['sales_order_number'] && $check_field('set','sales_order_number')) || (!form['sales_order_number'] && $check_field('add','sales_order_number'))" :disabled="true"/>
							<span v-else-if="$check_field('get','sales_order_number')">{{ form['sales_order_number'] }}</span>
						</div>
										</div>
							<div v-if="$check_field('set','registered_user') || $check_field('add','registered_user') || $check_field('get','registered_user')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								注册用户:
							</span>
						</div>
						<div class="diy_field diy_down">
							<select id="form_registered_user" :disabled="disabledObj['registered_user_isDisabled']" v-model="form['registered_user']" v-if="(form['registered_user'] && $check_field('set','registered_user')) || (!form['registered_user'] && $check_field('add','registered_user'))" >
								<option v-for="o in list_user_registered_user" :value="o['user_id']">
									{{o['nickname'] + '-' + o['username']}}
								</option>
							</select>
							<span v-else-if="$check_field('get','registered_user')">{{ get_user_info("registered_user", form['registered_user']) }}</span>
						</div>
					</div>
							<div v-if="$check_field('set','user_name') || $check_field('add','user_name') || $check_field('get','user_name')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								用户姓名:
							</span>
						</div>
								<!-- 文本 -->
									<div class="diy_field diy_text">
							<input type="text" id="form_user_name" v-model="form['user_name']" placeholder="请输入用户姓名" v-if="(form['user_name'] && $check_field('set','user_name')) || (!form['user_name'] && $check_field('add','user_name'))"  :disabled="disabledObj['user_name_isDisabled']"/>
							<span v-else-if="$check_field('get','user_name')">{{ form['user_name'] }}</span>
						</div>
										</div>
							<div v-if="$check_field('set','order_quantity') || $check_field('add','order_quantity') || $check_field('get','order_quantity')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								下单数量:
							</span>
						</div>
								<!-- 数字 -->
						<div class="diy_field diy_number">
							<input type="number" id="form_order_quantity" v-model.number="form['order_quantity']" placeholder="请输入下单数量" v-if="(form['order_quantity'] && $check_field('set','order_quantity')) || (!form['order_quantity'] && $check_field('add','order_quantity'))" :disabled="disabledObj['order_quantity_isDisabled']" />
							<span v-else-if="$check_field('get','order_quantity')">{{ form['order_quantity'] }}</span>
						</div>
							</div>
							<div v-if="$check_field('set','total_order_price') || $check_field('add','total_order_price') || $check_field('get','total_order_price')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								订单总价:
							</span>
						</div>
								<!-- 计算 -->
						<div class="diy_field diy_compute">
							<span v-if="$check_field('get','total_order_price')">{{ toFixed(form['commodity_price'] * form['order_quantity']) }}</span>
						</div>
							</div>
							<div v-if="$check_field('set','note_information') || $check_field('add','note_information') || $check_field('get','note_information')" class="form-item col-12 col-md-6">
						<div class="diy_title">
							<span>
								备注信息:
							</span>
						</div>
								<!-- 多文本 -->
						<div class="diy_field diy_desc">
							<textarea id="form_note_information" v-model="form['note_information']" v-if="(form['note_information'] && $check_field('set','note_information')) || (!form['note_information'] && $check_field('add','note_information'))" :disabled="disabledObj['note_information_isDisabled']" />
							<span v-else-if="$check_field('get','note_information')">{{ form['note_information'] }}</span>
						</div>
							</div>
	




				</div>
				<div class="diy_edit_submit_box row">
					<div class="col-12">
						<div class="btn_box">
							<button class="btn_submit" @click="submit()">提交</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		components: {},
		data() {
			return {
				url_get_obj: "~/api/sales_information/get_obj?",
				url_add: "~/api/sales_information/add?",
				url_set: "~/api/sales_information/set?",

				// 登录权限
				oauth: {
					"signIn": true,
					"user_group": []
				},

				// 查询条件
				query: {
						"product_code": "",
							"product_name": "",
							"product_category": "",
							"product_brand": "",
							"commodity_price": 0,
							"sales_order_number": "",
							"registered_user": 0,
							"user_name": "",
							"order_quantity": 0,
							"total_order_price": 0,
							"note_information": "",
						"sales_information_id": 0,
				},

				obj: {
						"product_code":  '', // 商品编码
							"product_name":  '', // 商品名称
							"product_category":  '', // 商品类别
							"product_brand":  '', // 商品品牌
							"commodity_price":  0, // 商品价格
							"sales_order_number": this.$get_stamp(), // 销售单号
							"registered_user": 0, // 注册用户
							"user_name":  '', // 用户姓名
							"order_quantity":  0, // 下单数量
							"total_order_price": 0, // 订单总价
							"note_information":  '', // 备注信息
						"sales_information_id": 0,
				},

				// 表单字段
				form: {
						"product_code":  '', // 商品编码
							"product_name":  '', // 商品名称
							"product_category":  '', // 商品类别
							"product_brand":  '', // 商品品牌
							"commodity_price":  0, // 商品价格
							"sales_order_number": this.$get_stamp(), // 销售单号
							"registered_user": 0, // 注册用户
							"user_name":  '', // 用户姓名
							"order_quantity":  0, // 下单数量
							"total_order_price": 0, // 订单总价
							"note_information":  '', // 备注信息
						"sales_information_id": 0,
				},
				disabledObj:{
						"product_code_isDisabled": false,
							"product_name_isDisabled": false,
							"product_category_isDisabled": false,
							"product_brand_isDisabled": false,
									"sales_order_number_isDisabled": false,
							"registered_user_isDisabled": false,
							"user_name_isDisabled": false,
											"note_information_isDisabled": false,
					},

																								// 用户列表
				list_user_registered_user: [],
														
				// ID字段
				field: "sales_information_id",

			}
		},
		methods: {
																																																																																			/**
				 * 提交前事件
				 * @param {Object} param 提交参数
				 */
				submit_before: function(param) {
					// console.log('提交前事件', param);
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
						formatDateValue(value) {
		  const date = new Date(value);
		  return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
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
			
				
				
				
				
				
						/**
			 * 获取注册用户用户列表
			 */
			async get_list_user_registered_user() {
				var json = await this.$get("~/api/user/get_list?user_group=注册用户");
				if(json.result && json.result.list){
					this.list_user_registered_user = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
					async get_user_session_registered_user(){
				var _this = this;
				var json = await this.$get("~/api/user_group/get_obj?name=注册用户");
				if(json.result && json.result.obj){
					var source_table = json.result.obj.source_table;
					var user_id = _this.$store.state.user.user_id;
					if (user_id){
						var url = "~/api/"+source_table+"/get_obj?"
						this.$get(url, {"user_id":_this.$store.state.user.user_id}, function(res) {
							if (res.result && res.result.obj) {
								var arr = []
								for (let key in res.result.obj) {
									arr.push(key)
								}
								var arrForm = []
								for (let key in _this.form) {
									arrForm.push(key)
								}
								_this.form["registered_user"] = user_id
								_this.disabledObj['registered_user' + '_isDisabled'] = true
								for (var i=0;i<arr.length;i++){
                  if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
                    for (var j = 0; j < arrForm.length; j++) {
                      if (arr[i] === arrForm[j]) {
                        if (arr[i] !== "registered_user") {
                          _this.form[arrForm[j]] = res.result.obj[arr[i]]
                          _this.disabledObj[arrForm[j] + '_isDisabled'] = true
                          break;
                        }
                      }
                    }
                  }
								}
							}
						});
					}
				}
				else if(json.error){
					console.error(json.error);
				}
			},
	
				
				
				
									set_total_order_price(){
				this.form.total_order_price = parseFloat(this.form.commodity_price) * parseFloat(this.form.order_quantity)
        let r = /^\+?[1-9][0-9]*$/; // 正整数
        if(!r.test(this.form.total_order_price) ){
          this.form.total_order_price = this.form.total_order_price.toFixed(2);
        }
			},
							// 自动计算精度处理
		toFixed: function(num){
			if (!isNaN(num)) {
				return ((num + '').indexOf('.') == -1) ? num : num.toFixed(2);
			}
		},
				
		  		get_user_info(name,id){
				var obj = null;
              				  if (name == 'registered_user'){
					  obj = this.list_user_registered_user.getObj({"user_id":id});
				  }
          				var ret = "";
				if(obj){
				  ret = obj.nickname+"-"+obj.username;
				}
				return ret;
			},
			/**
			 * 修改文件
			 * @param { Object } files 上传文件对象
			 * @param { String } str 表单的属性名
			 */
			change_file(files, str) {
				var form = new FormData();
				form.append("file", files[0]);
				this.$post("~/api/sales_information/upload?", form, (res) => {
					if (res.result) {
						this.form[str] = res.result.url;
					} else if (res.error) {
						this.$toast(res.error.message);
					}
				});
			},
			
			/**
			 * 修改文件
			 * @param { Object } files 上传文件对象
			 * @param { String } str 表单的属性名
			 */
			change_file_multiple(files, str) {
				let _this = this;
				var form = new FormData();
				for (var i = 0; i < files.length; i++) {
					form.set("file", files[i]);
					_this.$post("~/api/sales_information/upload?", form, (res) => {
						if (res.result) {
							if (_this.form[str].length > 0) {
								_this.form[str].push(res.result.url);
							} else {
								_this.form[str] = [res.result.url];
							}
						} else if (res.error) {
							_this.$toast(res.error.message);
						}
					});
				}
			},

			/**
			 * 获取对象后获取缓存表单
			 * @param {Object} json
			 * @param {Object} func
			 */
			get_obj_before(param){
				var form = $.db.get("form");
				// if (form) {
        //   delete(form.examine_state)
        //   delete(form.examine_reply)
        //   this.obj = $.push(this.obj ,form);
				// 	this.form = $.push(this.form ,form);
				// }
				// var arr = []
				// for (let key in form) {
				// 	arr.push(key)
				// }
				// for (var i=0;i<arr.length;i++){
				// 	this.disabledObj[arr[i] + '_isDisabled'] = true
				// }
        if (form) {
          var arr = []
          for (let key in form) {
            arr.push(key)
          }
          var arrForm = []
          for (let key in this.form) {
            arrForm.push(key)
          }
          for (var i=0;i<arr.length;i++){
            if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
              for (var j = 0; j < arrForm.length; j++) {
                if (arrForm[j] === arr[i]) {
                  this.form[arrForm[j]] = form[arr[i]]
                  this.obj[arrForm[j]] = form[arr[i]]
                  this.disabledObj[arrForm[j] + '_isDisabled'] = true
                  break;
                }
              }
			  if(arr[i] === "source_table"){
			  	this.form['source_table'] = form[arr[i]]
			  }
			  if(arr[i] === "source_id"){
			  	this.form['source_id'] = form[arr[i]]
			  }
			  if(arr[i] === "source_user_id"){
			  	this.form['source_user_id'] = form[arr[i]]
			  }
            }
          }
        }
																																	
        $.db.del("form");
				return param;
			},

			/**
			 * 获取对象后获取缓存表单
			 * @param {Object} json
			 * @param {Object} func
			 */
			get_obj_after(json ,func){
				// var form = $.db.get("form");
				// var obj = Object.assign({} ,form ,this.obj);
				// if (obj) {
        //   delete(obj.examine_state)
        //   delete(obj.examine_reply)
				// 	this.obj = $.push(this.obj ,obj);
				// }
				// if (form) {
        //   delete(form.examine_state)
        //   delete(form.examine_reply)
				// 	this.form = $.push(this.form ,form);
				// }

				if(func){
					func(json);
				}
			},

		},
		created() {
																							this.get_user_session_registered_user();
					this.get_list_user_registered_user();
															},
	}
</script>

<style>
	.diy_compute{
		line-height: 40px;
	}
	.diy_field.diy_img_multiple{
		margin: 0;
	}
	.diy_field.diy_img_multiple div{
		float: left;
		position: relative;
		margin: 0 10px 10px 0;
	}
	.diy_field.diy_img_multiple img{
		height: 100px;
		width: auto;
	}
	.diy_field.diy_img_multiple span{
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
