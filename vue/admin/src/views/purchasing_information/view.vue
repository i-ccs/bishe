<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="premium-view-card" shadow="never" v-if="is_view()">
			<div slot="header" class="premium-header">
				<span class="premium-title">采购信息详情</span>
				<span class="premium-subtitle">管理与维护商品的采购记录及供应商对接详情</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="120px" label-position="top">
				<div class="premium-section-title">商品基本信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="product_code">
							<el-input id="product_code" v-model="form['product_code']" placeholder="请输入商品编码" prefix-icon="el-icon-collection-tag"
								v-if="(form['purchasing_information_id'] && $check_field('set','product_code')) || (!form['purchasing_information_id'] && $check_field('add','product_code'))" :disabled="disabledObj['product_code_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_code')" class="premium-readonly-field">{{form['product_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_name') || $check_field('add','product_name') || $check_field('set','product_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="product_name">
							<el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称" prefix-icon="el-icon-goods"
								v-if="(form['purchasing_information_id'] && $check_field('set','product_name')) || (!form['purchasing_information_id'] && $check_field('add','product_name'))" :disabled="disabledObj['product_name_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_name')" class="premium-readonly-field">{{form['product_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','product_category') || $check_field('add','product_category') || $check_field('set','product_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="product_category">
							<el-input id="product_category" v-model="form['product_category']" placeholder="请输入商品类别" prefix-icon="el-icon-folder"
								v-if="(form['purchasing_information_id'] && $check_field('set','product_category')) || (!form['purchasing_information_id'] && $check_field('add','product_category'))" :disabled="disabledObj['product_category_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_category')" class="premium-readonly-field">{{form['product_category']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_brand') || $check_field('add','product_brand') || $check_field('set','product_brand')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品品牌" prop="product_brand">
							<el-input id="product_brand" v-model="form['product_brand']" placeholder="请输入商品品牌" prefix-icon="el-icon-price-tag"
								v-if="(form['purchasing_information_id'] && $check_field('set','product_brand')) || (!form['purchasing_information_id'] && $check_field('add','product_brand'))" :disabled="disabledObj['product_brand_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','product_brand')" class="premium-readonly-field">{{form['product_brand']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','commodity_specifications') || $check_field('add','commodity_specifications') || $check_field('set','commodity_specifications')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品规格" prop="commodity_specifications">
							<el-input id="commodity_specifications" v-model="form['commodity_specifications']" placeholder="请输入商品规格" prefix-icon="el-icon-info"
								v-if="(form['purchasing_information_id'] && $check_field('set','commodity_specifications')) || (!form['purchasing_information_id'] && $check_field('add','commodity_specifications'))" :disabled="disabledObj['commodity_specifications_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','commodity_specifications')" class="premium-readonly-field">{{form['commodity_specifications']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','commodity_price') || $check_field('add','commodity_price') || $check_field('set','commodity_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单价" prop="commodity_price">
							<el-input-number id="commodity_price" v-model.number="form['commodity_price']" style="width: 100%"
								v-if="(form['purchasing_information_id'] && $check_field('set','commodity_price')) || (!form['purchasing_information_id'] && $check_field('add','commodity_price'))" :disabled="disabledObj['commodity_price_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','commodity_price')" class="premium-readonly-field">{{form['commodity_price']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">采购交易详情</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','purchase_order_number') || $check_field('add','purchase_order_number') || $check_field('set','purchase_order_number')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购单号" prop="purchase_order_number">
							<el-input id="purchase_order_number" v-model="form['purchase_order_number']" placeholder="请输入采购单号" prefix-icon="el-icon-document"
								v-if="(form['purchasing_information_id'] && $check_field('set','purchase_order_number')) || (!form['purchasing_information_id'] && $check_field('add','purchase_order_number'))" :disabled="true"></el-input>
							<div v-else-if="$check_field('get','purchase_order_number')" class="premium-readonly-field">{{form['purchase_order_number']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','supplier_name') || $check_field('add','supplier_name') || $check_field('set','supplier_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="供应商名称" prop="supplier_name">
							<el-select id="supplier_name" v-model="form['supplier_name']" style="width: 100%"
								v-if="(form['purchasing_information_id'] && $check_field('set','supplier_name')) || (!form['purchasing_information_id'] && $check_field('add','supplier_name'))">
								<el-option v-for="o in list_supplier_name" :key="o['supplier_name']" :label="o['supplier_name']" :value="o['supplier_name']"></el-option>
							</el-select>
							<div v-else-if="$check_field('get','supplier_name')" class="premium-readonly-field">{{form['supplier_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','purchase_date') || $check_field('add','purchase_date') || $check_field('set','purchase_date')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购日期" prop="purchase_date">
							<el-date-picker :disabled="disabledObj['purchase_date_isDisabled']" style="width: 100%"
								v-if="(form['purchasing_information_id'] && $check_field('set','purchase_date')) || (!form['purchasing_information_id'] && $check_field('add','purchase_date'))" id="purchase_date"
								v-model="form['purchase_date']" type="date" placeholder="选择日期" :picker-options="purchase_date_disableOptions" value-format="yyyy-MM-dd">
							</el-date-picker>
							<div v-else-if="$check_field('get','purchase_date')" class="premium-readonly-field">{{form['purchase_date']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','purchase_quantity') || $check_field('add','purchase_quantity') || $check_field('set','purchase_quantity')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购数量" prop="purchase_quantity">
							<el-input-number id="purchase_quantity" v-model.number="form['purchase_quantity']" style="width: 100%"
								v-if="(form['purchasing_information_id'] && $check_field('set','purchase_quantity')) || (!form['purchasing_information_id'] && $check_field('add','purchase_quantity'))" :disabled="disabledObj['purchase_quantity_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','purchase_quantity')" class="premium-readonly-field">{{form['purchase_quantity']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','purchase_unit_price') || $check_field('add','purchase_unit_price') || $check_field('set','purchase_unit_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购单价" prop="purchase_unit_price">
							<el-input-number id="purchase_unit_price" v-model.number="form['purchase_unit_price']" style="width: 100%"
								v-if="(form['purchasing_information_id'] && $check_field('set','purchase_unit_price')) || (!form['purchasing_information_id'] && $check_field('add','purchase_unit_price'))" :disabled="disabledObj['purchase_unit_price_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','purchase_unit_price')" class="premium-readonly-field">{{form['purchase_unit_price']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','total_purchase_price') || $check_field('add','total_purchase_price') || $check_field('set','total_purchase_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购总价" prop="total_purchase_price">
							<div class="premium-readonly-field" style="background-color: #fff8f8; border-color: #ffdada; color: #f56c6c; font-weight: 600;">
								¥ {{toFixed(form['purchase_quantity'] * form['purchase_unit_price'])}}
							</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','procurement_status') || $check_field('add','procurement_status') || $check_field('set','procurement_status')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="采购情况说明" prop="procurement_status">
							<el-input type="textarea" :rows="4" id="procurement_status" v-model="form['procurement_status']" placeholder="请输入具体采购情况或备注"
								v-if="(form['purchasing_information_id'] && $check_field('set','procurement_status')) || (!form['purchasing_information_id'] && $check_field('add','procurement_status'))" :disabled="disabledObj['procurement_status_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','procurement_status')" class="premium-readonly-field" style="min-height: 80px;">{{form['procurement_status']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="$check_action('/purchasing_information/view','set') || $check_action('/purchasing_information/view','add')">
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
					"commodity_specifications":  '', // 商品规格
					"commodity_price":  0, // 商品价格
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
					"commodity_specifications_isDisabled": false,
					"commodity_price_isDisabled": false,
					"purchase_order_number_isDisabled": false,
					"supplier_name_isDisabled": false,
					"purchase_date_isDisabled": false,
					"purchase_quantity_isDisabled": false,
					"purchase_unit_price_isDisabled": false,
					"total_purchase_price_isDisabled": false,
					"procurement_status_isDisabled": false,
				},
				list_supplier_name: [""],
				purchase_date_disableOptions: {
					disabledDate(time) {
						return time.getTime() < Date.now() - 8.64e7;
					},
				},
			}
		},
		methods: {
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

			get_obj_after(json, func){
				if(this.form["purchase_date"]=="0000-00-00"){
				  this.form["purchase_date"] = null;
				}
				if(parseInt(this.form["purchase_date"]) > 9999){
					this.form["purchase_date"] = this.$toTime(parseInt(this.form["purchase_date"]),"yyyy-MM-dd")
				}
			},

			submit_before: function(param) {
				this.set_total_purchase_price()
				param = this.form
				for(var key in param){
					try{
						var value = param[key];
						if(value && value instanceof Date){
							param[key] = this.$toTime(value ,"yyyy-MM-dd hh:mm:ss");
						}
					}
					catch(err){
						console.log(key ,"转日期错误：" ,err);
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
			
			submit_check(param) {
				console.log('开始验证采购数据:', param);
				
				// 验证采购日期
				if (!param.purchase_date){
					console.log('验证失败：采购日期为空');
					return "采购日期不能为空";
				}
				
				// 验证采购数量必须大于0
				if (param.purchase_quantity === null || param.purchase_quantity === undefined || param.purchase_quantity <= 0) {
					console.log('验证失败：采购数量无效', param.purchase_quantity);
					return '采购数量必须大于0';
				}
				
				// 验证采购单价必须大于0
				if (param.purchase_unit_price === null || param.purchase_unit_price === undefined || param.purchase_unit_price <= 0) {
					console.log('验证失败：采购单价无效', param.purchase_unit_price);
					return '采购单价必须大于0';
				}
				
				// 验证采购单价必须小于商品销售价格
				if (param.commodity_price && param.purchase_unit_price >= param.commodity_price) {
					console.log('验证失败：采购单价高于或等于销售价', {
						purchase_unit_price: param.purchase_unit_price,
						commodity_price: param.commodity_price
					});
					return `采购单价(${param.purchase_unit_price})必须小于商品销售价(${param.commodity_price})`;
				}
				
				console.log('验证通过');
				return null;
			},

			is_view(){
				var bl = false;
				if(!bl){
					bl = this.$check_action('/purchasing_information/table','add');
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/table','set');
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/view','add');
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/view','set');
				}
				if(!bl){
					bl = this.$check_action('/purchasing_information/view','get');
				}
				return bl;
			},

			uploadimg(param) {
				this.uploadFile(param.file, "avatar");
			},
		},
		created() {
			this.get_list_supplier_name();
		},
	}
</script>

<style scoped>
</style>
