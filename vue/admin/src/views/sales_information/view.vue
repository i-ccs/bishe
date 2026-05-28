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
					<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="prod_code">
							<el-select id="prod_code" v-model="form['prod_code']" placeholder="请选择商品编码" style="width:100%" filterable
								v-if="(form['sales_infor_id'] && $check_field('set','prod_code')) || (!form['sales_infor_id'] && $check_field('add','prod_code'))"
								@change="on_prod_code_change" :disabled="disabledObj['prod_code_isDisabled']">
								<el-option v-for="item in list_commodity" :key="item.prod_code" :label="item.prod_code" :value="item.prod_code"></el-option>
							</el-select>
							<div v-else-if="$check_field('get','prod_code')" class="premium-readonly-field">{{form['prod_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','prod_name') || $check_field('add','prod_name') || $check_field('set','prod_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="prod_name">
							<div class="premium-readonly-field">{{form['prod_name'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','prod_category') || $check_field('add','prod_category') || $check_field('set','prod_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="prod_category">
							<div class="premium-readonly-field">{{form['prod_category'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_brand') || $check_field('add','prod_brand') || $check_field('set','prod_brand')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品品牌" prop="prod_brand">
							<div class="premium-readonly-field">{{form['prod_brand'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','comm_price') || $check_field('add','comm_price') || $check_field('set','comm_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单价" prop="comm_price">
							<div class="premium-readonly-field">{{form['comm_price'] !== 0 ? form['comm_price'] : '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">客户与订单信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','sales_order_number') || $check_field('add','sales_order_number') || $check_field('set','sales_order_number')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单号" prop="sales_order_number">
							<el-input id="sales_order_number" v-model="form['sales_order_number']" placeholder="请输入销售单号" prefix-icon="el-icon-document"
								v-if="(form['sales_infor_id'] && $check_field('set','sales_order_number')) || (!form['sales_infor_id'] && $check_field('add','sales_order_number'))" :disabled="true"></el-input>
							<div v-else-if="$check_field('get','sales_order_number')" class="premium-readonly-field">{{form['sales_order_number']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','registered_user') || $check_field('add','registered_user') || $check_field('set','registered_user')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="下单用户" prop="registered_user">
							<el-select v-if="user_group === '管理员'" id="registered_user" v-model="form['registered_user']" style="width: 100%" :disabled="disabledObj['registered_user_isDisabled']" @change="on_registered_user_change">
								<el-option v-for="o in list_user_registered_user" :key="o['user_na']" :label="o['nick_name'] + ' (' + o['user_na'] + ')'" :value="o['user_id']"></el-option>
							</el-select>
							<div v-else class="premium-readonly-field">{{ get_user_registered_user(form['registered_user']) }}</div>
						</el-form-item>
					</el-col>

				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','order_quantity') || $check_field('add','order_quantity') || $check_field('set','order_quantity')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="下单数量" prop="order_quantity">
							<el-input-number id="order_quantity" v-model.number="form['order_quantity']" style="width: 100%" :min="1"
								v-if="(form['sales_infor_id'] && $check_field('set','order_quantity')) || (!form['sales_infor_id'] && $check_field('add','order_quantity'))" :disabled="disabledObj['order_quantity_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','order_quantity')" class="premium-readonly-field">{{form['order_quantity']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','total_order_price') || $check_field('add','total_order_price') || $check_field('set','total_order_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="订单总价" prop="total_order_price">
							<div class="premium-readonly-field" style="background-color: #f0f9eb; border-color: #e1f3d8; color: #67c23a; font-weight: 600;">
								¥ {{toFixed(form['comm_price'] * form['order_quantity'])}}
							</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','note_infor') || $check_field('add','note_infor') || $check_field('set','note_infor')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="订单备注" prop="note_infor">
							<el-input type="textarea" :rows="4" id="note_infor" v-model="form['note_infor']" placeholder="如有特殊要求请在此备注"
								v-if="(form['sales_infor_id'] && $check_field('set','note_infor')) || (!form['sales_infor_id'] && $check_field('add','note_infor'))" :disabled="disabledObj['note_infor_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','note_infor')" class="premium-readonly-field" style="min-height: 80px;">{{form['note_infor']}}</div>
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
				field: "sales_infor_id",
				url_add: "~/api/sales_information/add?",
				url_set: "~/api/sales_information/set?",
				url_get_obj: "~/api/sales_information/get_obj?",
				url_upload: "~/api/sales_information/upload?",
				query: { "sales_infor_id": 0 },
				form: {
					"prod_code":  '', // 商品编码
					"prod_name":  '', // 商品名称
					"prod_category":  '', // 商品类别
					"prod_brand":  '', // 商品品牌
					"comm_price":  0, // 商品价格
					"sales_order_number": this.$get_stamp(), // 销售单号
					"registered_user": 0, // 注册用户
					"user_na":  '', // 用户姓名
					"order_quantity":  0, // 下单数量
					"total_order_price": 0,
					"note_infor":  '', // 备注信息
					"sales_infor_id": 0, // ID
				},
				disabledObj:{
					"prod_code_isDisabled": false,
					"prod_name_isDisabled": false,
					"prod_category_isDisabled": false,
					"prod_brand_isDisabled": false,
					"comm_price_isDisabled": false,
					"sales_order_number_isDisabled": false,
					"registered_user_isDisabled": false,
					"user_na_isDisabled": false,
					"order_quantity_isDisabled": false,
					"total_order_price_isDisabled": false,
					"note_infor_isDisabled": false,
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
			on_prod_code_change(code) {
				var item = this.list_commodity.find(c => (c.prod_code === code || c.prod_code === code));
				if (item) {
					this.form.prod_name = item.prod_name || item.prod_name;
					this.form.prod_category = item.prod_category || item.prod_category;
					this.form.prod_brand = item.prod_brand || item.prod_brand;
					this.form.comm_price = item.comm_price || item.comm_price;
				}
			},
			on_registered_user_change(user_id) {
				var obj = this.list_user_registered_user.find(u => u.user_id === user_id);
				if (obj) {
					this.form.user_na = obj.nick_name || obj.user_na || '';
				} else {
					this.form.user_na = '';
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
				var url = "~/api/"+_this.group_user_registered_user.sour_table+"/get_obj?"
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
					ret = obj.nick_name || obj.user_na;
				}
				return ret;
			},
			set_total_order_price(){
				this.form.total_order_price = parseFloat(this.form.comm_price) * parseFloat(this.form.order_quantity)
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
							if(dbKey === "sour_table"){ this.form['sour_table'] = form[dbKey]; }
							if(dbKey === "sour_id"){ this.form['sour_id'] = form[dbKey]; }
							if(dbKey === "sour_user_id"){ this.form['sour_user_id'] = form[dbKey]; }
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
				if (!param.prod_code || param.prod_code.trim() === '') {
					return '商品编码不能为空，请从下拉列表中选择';
				}
				if (param.comm_price === null || param.comm_price === undefined || param.comm_price < 0) {
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
				if (this.form.sour_table === 'commodity_information') {
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
