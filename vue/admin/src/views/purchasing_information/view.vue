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
					<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="prod_code">
							<el-select id="prod_code" v-model="form['prod_code']" placeholder="请选择商品编码" style="width:100%"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','prod_code'))"
								@change="on_prod_code_change" :disabled="disabledObj['prod_code_isDisabled']" filterable>
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
					<el-col v-if="$check_field('get','comm_spec') || $check_field('add','comm_spec') || $check_field('set','comm_spec')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品规格" prop="comm_spec">
							<div class="premium-readonly-field">{{form['comm_spec'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','comm_price') || $check_field('add','comm_price') || $check_field('set','comm_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="销售单价" prop="comm_price">
							<div class="premium-readonly-field">{{form['comm_price'] !== 0 ? form['comm_price'] : '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">采购交易详情</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','purch_order_number') || $check_field('add','purch_order_number') || $check_field('set','purch_order_number')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购单号" prop="purch_order_number">
							<el-input id="purch_order_number" v-model="form['purch_order_number']" placeholder="请输入采购单号" prefix-icon="el-icon-document"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','purch_order_number'))" :disabled="true"></el-input>
							<div v-else-if="$check_field('get','purch_order_number')" class="premium-readonly-field">{{form['purch_order_number']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','supplier_name') || $check_field('add','supplier_name') || $check_field('set','supplier_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="供应商名称" prop="supplier_name">
							<el-select id="supplier_name" v-model="form['supplier_name']" style="width: 100%"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','supplier_name'))">
								<el-option v-for="o in list_supplier_na" :key="o['supplier_na']" :label="o['supplier_na']" :value="o['supplier_na']"></el-option>
							</el-select>
							<div v-else-if="$check_field('get','supplier_name')" class="premium-readonly-field">{{form['supplier_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','purch_date') || $check_field('add','purch_date') || $check_field('set','purch_date')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购日期" prop="purch_date">
							<el-date-picker :disabled="disabledObj['purch_date_isDisabled']" style="width: 100%"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','purch_date'))" id="purch_date"
								v-model="form['purch_date']" type="date" placeholder="选择日期" :picker-options="purch_date_disableOptions" value-format="yyyy-MM-dd">
							</el-date-picker>
							<div v-else-if="$check_field('get','purch_date')" class="premium-readonly-field">{{form['purch_date']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','purch_quantity') || $check_field('add','purch_quantity') || $check_field('set','purch_quantity')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购数量" prop="purch_quantity">
							<el-input-number id="purch_quantity" v-model.number="form['purch_quantity']" style="width: 100%" :min="0"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','purch_quantity'))" :disabled="disabledObj['purch_quantity_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','purch_quantity')" class="premium-readonly-field">{{form['purch_quantity']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','purch_unit_price') || $check_field('add','purch_unit_price') || $check_field('set','purch_unit_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购单价" prop="purch_unit_price">
							<el-input-number id="purch_unit_price" v-model.number="form['purch_unit_price']" style="width: 100%" :min="0"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','purch_unit_price'))" :disabled="disabledObj['purch_unit_price_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','purch_unit_price')" class="premium-readonly-field">{{form['purch_unit_price']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','total_purch_price') || $check_field('add','total_purch_price') || $check_field('set','total_purch_price')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="采购总价" prop="total_purch_price">
							<div class="premium-readonly-field" style="background-color: #fff8f8; border-color: #ffdada; color: #f56c6c; font-weight: 600;">
								¥ {{toFixed(form['purch_quantity'] * form['purch_unit_price'])}}
							</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','procur_status') || $check_field('add','procur_status') || $check_field('set','procur_status')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="采购情况说明" prop="procur_status">
							<el-input type="textarea" :rows="4" id="procur_status" v-model="form['procur_status']" placeholder="请输入具体采购情况或备注"
								v-if="!isExisting && (!form['purch_inf_id'] && $check_field('add','procur_status'))" :disabled="disabledObj['procur_status_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','procur_status')" class="premium-readonly-field" style="min-height: 80px;">{{form['procur_status']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="!isExisting && $check_action('/purchasing_information/view','add')">
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
					"supplier_name":  '', // 供应商名称
					"purch_date":  '', // 采购日期
					"purch_quantity":  0, // 采购数量
					"purch_unit_price":  0, // 采购单价
					"total_purch_price": 0,
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
					"supplier_name_isDisabled": false,
					"purch_date_isDisabled": false,
					"purch_quantity_isDisabled": false,
					"purch_unit_price_isDisabled": false,
					"total_purch_price_isDisabled": false,
					"procur_status_isDisabled": false,
				},
				list_supplier_na: [""],
				list_commodity: [], // 商品列表
				purch_date_disableOptions: {
					disabledDate(time) {
						return time.getTime() < Date.now() - 8.64e7;
					},
				},
			}
		},
		methods: {
			async get_list_supplier_na() {
				var json = await this.$get("~/api/supply_information/get_list?");
				if(json.result && json.result.list){
					this.list_supplier_na = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			async get_list_commodity() {
				var json = await this.$get("~/api/commodity_information/get_list?size=1000");
				if(json.result && json.result.list){
					this.list_commodity = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			on_prod_code_change(code) {
				var item = this.list_commodity.find(c => (c.prod_code === code || c.prod_code === code));
				if (item) {
					this.form.prod_name = item.prod_name || item.prod_name;
					this.form.prod_category = item.prod_category || item.prod_category;
					this.form.prod_brand = item.prod_brand || item.prod_brand;
					this.form.comm_spec = item.comm_spec || item.comm_spec;
					this.form.comm_price = item.comm_price || item.comm_price;
					// 关联商品表信息
					this.form.sour_table = 'commodity_information';
					this.form.sour_id = item.comm_infor_id || item.comm_infor_id;
					this.form.sour_user_id = this.$store.state.user.user_id;
				}
			},
								
			set_total_purch_price(){
				this.form.total_purch_price = parseFloat(this.form.purch_quantity) * parseFloat(this.form.purch_unit_price)
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

			get_obj_after(json, func){
				if(this.form["purch_date"]=="0000-00-00"){
				  this.form["purch_date"] = null;
				}
				if(parseInt(this.form["purch_date"]) > 9999){
					this.form["purch_date"] = this.$toTime(parseInt(this.form["purch_date"]),"yyyy-MM-dd")
				}
			},

			submit_before: function(param) {
				this.set_total_purch_price()
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
			
			async submit_check(param) {				
				// 验证商品编码
				if (!param.prod_code || param.prod_code.trim() === '') {
					return '商品编码不能为空，请从下拉列表中选择';
				}
				
				// 验证采购日期
				if (!param.purch_date){
					console.log('验证失败：采购日期为空');
					return "采购日期不能为空";
				}
				
				// 验证供应商名称不能为空
				if (!param.supplier_name || param.supplier_name.trim() === '') {
					console.log('验证失败：供应商名称为空');
					return '供应商名称不能为空';
				}
				
				// 验证供应商是否有效 (is_delete)
				var supplier_res = await this.$get("~/api/supply_information/count?", { supplier_na: param.supplier_name });
				if (supplier_res && (supplier_res.result === 0 || supplier_res.result === null)) {
					return '该供应商已被删除或无效，无法提交采购单据';
				}
				
				// 验证采购数量必须大于0
				if (param.purch_quantity === null || param.purch_quantity === undefined || param.purch_quantity <= 0) {
					console.log('验证失败：采购数量无效', param.purch_quantity);
					return '采购数量必须大于0';
				}
				
				// 验证采购单价必须大于0
				if (param.purch_unit_price === null || param.purch_unit_price === undefined || param.purch_unit_price <= 0) {
					console.log('验证失败：采购单价无效', param.purch_unit_price);
					return '采购单价必须大于0';
				}
				
				// 验证采购单价必须小于商品销售价格
				if (param.comm_price && param.purch_unit_price >= param.comm_price) {
					console.log('验证失败：采购单价高于或等于销售价', {
						purch_unit_price: param.purch_unit_price,
						comm_price: param.comm_price
					});
					return `采购单价(${param.purch_unit_price})必须小于商品销售价(${param.comm_price})`;
				}
				
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

			submit_after(json, func) {
				this.$toast('提交成功！', 'success');
				if (this.form.sour_table === 'commodity_information') {
					this.$router.push('/commodity_information/table');
				} else {
					let path = this.$route.fullPath;
					this.$router.push(path.replace('/view', '/table'));
				}
			},

			uploadimg(param) {
				this.uploadFile(param.file, "avatar");
			},
		},
		computed: {
			isExisting() {
				return !!this.form['purch_inf_id'] && this.form['purch_inf_id'] !== 0;
			}
		},
		created() {
			this.get_list_supplier_na();
			this.get_list_commodity();
		},
	}
</script>

<style scoped>
</style>
