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
							<el-select id="product_code" v-model="form['product_code']" placeholder="请选择商品编码" style="width:100%" filterable
								v-if="(form['sales_information_id'] && $check_field('set','product_code')) || (!form['sales_information_id'] && $check_field('add','product_code'))"
								@change="on_product_code_change" :disabled="disabledObj['product_code_isDisabled']">
								<el-option v-for="item in list_commodity" :key="item.product_code" :label="item.product_code" :value="item.product_code"></el-option>
							</el-select>
							<div v-else-if="$check_field('get','product_code')" class="premium-readonly-field">{{form['product_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="product_name">
							<div class="premium-readonly-field">{{form['product_name'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="product_category">
							<div class="premium-readonly-field">{{form['product_category'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品品牌" prop="product_brand">
							<div class="premium-readonly-field">{{form['product_brand'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','commodity_price') || $check_field('add','commodity_price') || $check_field('set','commodity_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单价" prop="commodity_price">
							<div class="premium-readonly-field">{{form['commodity_price'] !== 0 ? form['commodity_price'] : '请先选择商品编码'}}</div>
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
							<el-select v-if="user_group === '管理员'" id="registered_user" v-model="form['registered_user']" style="width: 100%" :disabled="disabledObj['registered_user_isDisabled']" @change="on_registered_user_change">
								<el-option v-for="o in list_user_registered_user" :key="o['user_name']" :label="o['nick_name'] + ' (' + o['user_name'] + ')'" :value="o['user_id']"></el-option>
							</el-select>
							<div v-else class="premium-readonly-field">{{ get_user_registered_user(form['registered_user']) }}</div>
						</el-form-item>
					</el-col>

				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','order_quantity') || $check_field('add','order_quantity') || $check_field('set','order_quantity')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="下单数量" prop="order_quantity">
							<el-input-number id="order_quantity" v-model.number="form['order_quantity']" style="width: 100%" :min="1"
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
				list_commodity: [],
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
			async get_list_commodity() {
				var json = await this.$get("~/api/commodity_information/get_list?size=1000");
				if(json.result && json.result.list){
					this.list_commodity = json.result.list;
				} else if(json.error){
					console.error(json.error);
				}
			},
			on_product_code_change(code) {
				var item = this.list_commodity.find(c => c.product_code === code);
				if (item) {
					this.form.product_name = item.product_name;
					this.form.product_category = item.product_category;
					this.form.product_brand = item.product_brand;
					this.form.commodity_price = item.commodity_price;
				}
			},
			on_registered_user_change(user_id) {
				var obj = this.list_user_registered_user.find(u => u.user_id === user_id);
				if (obj) {
					this.form.user_name = obj.nick_name || obj.user_name || '';
				} else {
					this.form.user_name = '';
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
					ret = obj.nick_name || obj.user_name;
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
			submit_check(param) {
				if (!param.product_code || param.product_code.trim() === '') {
					return '商品编码不能为空，请从下拉列表中选择';
				}
				if (param.commodity_price === null || param.commodity_price === undefined || param.commodity_price < 0) {
					return '销售单价不能小于0';
				}
				if (param.order_quantity === null || param.order_quantity === undefined || param.order_quantity <= 0) {
					return '下单数量不能为0，请至少填写1件';
				}
				return null;
			},
			is_view(){
				var bl = false;
				if(!bl){ bl = this.$check_action('/sales_information/table','add'); }
				if(!bl){ bl = this.$check_action('/sales_information/table','set'); }
				if(!bl){ bl = this.$check_action('/sales_information/view','add'); }
				if(!bl){ bl = this.$check_action('/sales_information/view','set'); }
				if(!bl){ bl = this.$check_action('/sales_information/view','get'); }
				return bl;
			},
			submit_after(json, func) {
				this.$toast('提交成功！', 'success');
				if (this.form.source_table === 'commodity_information') {
					this.$router.push('/commodity_information/table');
				} else {
					let path = this.$route.fullPath;
					this.$router.push(path.replace('/view', '/table'));
				}
			},
			uploadimg(param) { this.uploadFile(param.file, "avatar"); },
		},
		created() {
			this.get_list_user_registered_user();
			this.get_group_user_registered_user();
			this.get_list_commodity();
		},
	}
</script>

<style scoped>
</style>
