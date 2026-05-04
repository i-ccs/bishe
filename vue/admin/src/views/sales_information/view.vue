<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="premium-view-card" shadow="never" v-if="is_view()">
			<div slot="header" class="premium-header">
				<span class="premium-title">销售订单详情</span>
				<span class="premium-subtitle">查看及管理商品的销售记录、客户下单信息与支付总价</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="120px" label-position="top">
				<div class="premium-section-title">所购商品信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="product_code">
							<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码" prefix-icon="el-icon-collection-tag"
								v-if="(form['sales_information_id'] && $check_field('set','product_code')) || (!form['sales_information_id'] && $check_field('add','product_code'))" :disabled="disabledObj['product_code_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_code')" class="premium-readonly-field">{{form['product_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="product_name">
							<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称" prefix-icon="el-icon-goods"
								v-if="(form['sales_information_id'] && $check_field('set','product_name')) || (!form['sales_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_name')" class="premium-readonly-field">{{form['product_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="product_category">
							<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别" prefix-icon="el-icon-folder"
								v-if="(form['sales_information_id'] && $check_field('set','product_category')) || (!form['sales_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_category')" class="premium-readonly-field">{{form['product_category']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品品牌" prop="product_brand">
							<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌" prefix-icon="el-icon-price-tag"
								v-if="(form['sales_information_id'] && $check_field('set','product_brand')) || (!form['sales_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_brand')" class="premium-readonly-field">{{form['product_brand']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','commodity_price') || $check_field('add','commodity_price') || $check_field('set','commodity_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单价" prop="commodity_price">
							<el-input-number id="commodity_price" v-model.number="form['commodity_price']" style="width: 100%"
								v-if="(form['sales_information_id'] && $check_field('set','commodity_price')) || (!form['sales_information_id'] && $check_field('add','commodity_price'))" :disabled="disabledObj['commodity_price_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','commodity_price')" class="premium-readonly-field">{{form['commodity_price']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">客户与订单信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','sales_order_number') || $check_field('add','sales_order_number') || $check_field('set','sales_order_number')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单号" prop="sales_order_number">
							<el-input id="sales_order_number" v-model="form['sales_order_number']" placeholder="请输入销售单号" prefix-icon="el-icon-document"
								v-if="(form['sales_information_id'] && $check_field('set','sales_order_number')) || (!form['sales_information_id'] && $check_field('add','sales_order_number'))" :disabled="true"></el-input>
							<div v-else-if="$check_field('get','sales_order_number')" class="premium-readonly-field">{{form['sales_order_number']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','registered_user') || $check_field('add','registered_user') || $check_field('set','registered_user')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="下单用户" prop="registered_user">
							<el-select v-if="user_group === '管理员'" id="registered_user" v-model="form['registered_user']" style="width: 100%" :disabled="disabledObj['registered_user_isDisabled']">
								<el-option v-for="o in list_user_registered_user" :key="o['username']" :label="o['nickname'] + ' (' + o['username'] + ')'" :value="o['user_id']"></el-option>
							</el-select>
							<div v-else class="premium-readonly-field">{{ get_user_registered_user(form['registered_user']) }}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','user_name') || $check_field('add','user_name') || $check_field('set','user_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="用户姓名" prop="user_name">
							<el-input id="user_name" v-model="form['user_name']" placeholder="请输入用户姓名" prefix-icon="el-icon-user"
								v-if="(form['sales_information_id'] && $check_field('set','user_name')) || (!form['sales_information_id'] && $check_field('add','user_name'))" :disabled="disabledObj['user_name_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','user_name')" class="premium-readonly-field">{{form['user_name']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','order_quantity') || $check_field('add','order_quantity') || $check_field('set','order_quantity')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="下单数量" prop="order_quantity">
							<el-input-number id="order_quantity" v-model.number="form['order_quantity']" style="width: 100%"
								v-if="(form['sales_information_id'] && $check_field('set','order_quantity')) || (!form['sales_information_id'] && $check_field('add','order_quantity'))" :disabled="disabledObj['order_quantity_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','order_quantity')" class="premium-readonly-field">{{form['order_quantity']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','total_order_price') || $check_field('add','total_order_price') || $check_field('set','total_order_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="订单总价" prop="total_order_price">
							<div class="premium-readonly-field" style="background-color: #f0f9eb; border-color: #e1f3d8; color: #67c23a; font-weight: 600;">
								¥ {{toFixed(form['commodity_price'] * form['order_quantity'])}}
							</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','note_information') || $check_field('add','note_information') || $check_field('set','note_information')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="订单备注" prop="note_information">
							<el-input type="textarea" :rows="4" id="note_information" v-model="form['note_information']" placeholder="如有特殊要求请在此备注"
								v-if="(form['sales_information_id'] && $check_field('set','note_information')) || (!form['sales_information_id'] && $check_field('add','note_information'))" :disabled="disabledObj['note_information_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','note_information')" class="premium-readonly-field" style="min-height: 80px;">{{form['note_information']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="$check_action('/sales_information/view','set') || $check_action('/sales_information/view','add')">
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
				field: "sales_information_id",
				url_add: "~/api/sales_information/add?",
				url_set: "~/api/sales_information/set?",
				url_get_obj: "~/api/sales_information/get_obj?",
				url_upload: "~/api/sales_information/upload?",
				query: { "sales_information_id": 0 },
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
					"total_order_price": 0,
					"note_information":  '', // 备注信息
					"sales_information_id": 0, // ID
				},
				disabledObj:{
					"product_code_isDisabled": false,
					"product_name_isDisabled": false,
					"product_category_isDisabled": false,
					"product_brand_isDisabled": false,
					"commodity_price_isDisabled": false,
					"sales_order_number_isDisabled": false,
					"registered_user_isDisabled": false,
					"user_name_isDisabled": false,
					"order_quantity_isDisabled": false,
					"total_order_price_isDisabled": false,
					"note_information_isDisabled": false,
				},
				list_user_registered_user: [],
				group_user_registered_user: "",
			}
		},
		methods: {
			async get_list_user_registered_user() {
                var json = await this.$get("~/api/user/get_list?user_group=注册用户");
                if(json.result && json.result.list){
                    this.list_user_registered_user = json.result.list;
                }
                else if(json.error){
                    console.error(json.error);
                }
			},
			async get_group_user_registered_user() {
				this.form["registered_user"] = this.user.user_id;
				var json = await this.$get("~/api/user_group/get_obj?name=注册用户");
				if(json.result && json.result.obj){
					this.group_user_registered_user = json.result.obj;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			get_user_session_registered_user(id){
				var _this = this;
				var user_id = {"user_id":id}
				var url = "~/api/"+_this.group_user_registered_user.source_table+"/get_obj?"
				this.$get(url, user_id, function(res) {
					if (res.result && res.result.obj) {
						var arr = []
						for (let key in res.result.obj) { arr.push(key) }
						var arrForm = []
						for (let key in _this.form) { arrForm.push(key) }
						_this.form["registered_user"] = id
						_this.disabledObj['registered_user' + '_isDisabled'] = true
						for (var i=0;i<arr.length;i++){
						  if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
							for (var j = 0; j < arrForm.length; j++) {
							  if (arr[i] === arrForm[j]) {
								if (arr[i] !== "registered_user") {
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
			get_user_registered_user(id){
				var obj = this.list_user_registered_user.getObj({"user_id":id});
				var ret = "";
				if(obj){
					ret = obj.nickname || obj.username;
				}
				return ret;
			},
			set_total_order_price(){
				this.form.total_order_price = parseFloat(this.form.commodity_price) * parseFloat(this.form.order_quantity)
			},
			toFixed: function(num){
				if (!isNaN(num)) {
					return ((num + '').indexOf('.') == -1) ? num : num.toFixed(2);
				}
			},
			get_obj_before(param) {
				var form = $.db.get("form");
				$.push(this.form ,form);
				if(this.form && form){
					Object.keys(this.form).forEach(key => {
						Object.keys(form).forEach(dbKey => {
							if(key === dbKey){
								this.disabledObj[key+'_isDisabled'] = true;
								this.form[key] = form[dbKey]
							}
							if(dbKey === "source_table"){ this.form['source_table'] = form[dbKey]; }
							if(dbKey === "source_id"){ this.form['source_id'] = form[dbKey]; }
							if(dbKey === "source_user_id"){ this.form['source_user_id'] = form[dbKey]; }
						})
					})
				}
				$.db.del("form");
				return param;
			},
			get_obj_after(json, func){},
			submit_before: function(param) {
				this.set_total_order_price()
				param = this.form
				for(var key in param){
					try{
						var value = param[key];
						if(value && value instanceof Date){
							param[key] = this.$toTime(value ,"yyyy-MM-dd hh:mm:ss");
						}
					} catch(err){ console.log(key ,"转日期错误：" ,err); }
				}
				return param;
			},
			async submit(param, func){
				if (!param) { param = this.form; }
				var pm = this.events("submit_before", Object.assign({}, param)) || param;
				var msg = await this.events("submit_check", pm);
				var ret;
				if (msg) { this.$toast(msg, 'danger'); }
				else { ret = this.events("submit_main", pm, func); }
				return ret;
			},
			submit_check(param) { return null; },
			is_view(){
				var bl = false;
				if(!bl){ bl = this.$check_action('/sales_information/table','add'); }
				if(!bl){ bl = this.$check_action('/sales_information/table','set'); }
				if(!bl){ bl = this.$check_action('/sales_information/view','add'); }
				if(!bl){ bl = this.$check_action('/sales_information/view','set'); }
				if(!bl){ bl = this.$check_action('/sales_information/view','get'); }
				return bl;
			},
			uploadimg(param) { this.uploadFile(param.file, "avatar"); },
		},
		created() {
			this.get_list_user_registered_user();
			this.get_group_user_registered_user();
		},
	}
</script>

<style scoped>
</style>
