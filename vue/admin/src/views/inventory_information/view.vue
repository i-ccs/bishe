<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="premium-view-card" shadow="never" v-if="is_view()">
			<div slot="header" class="premium-header">
				<span class="premium-title">库存核对详情</span>
				<span class="premium-subtitle">实时监控商品库存状态，记录核对日期与实际余量</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="120px" label-position="top">
				<div class="premium-section-title">商品基本信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_code') || $check_field('add','product_code') || $check_field('set','product_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="product_code">
							<el-select id="product_code" v-model="form['product_code']" placeholder="请选择商品编码" style="width:100%" filterable
								v-if="(form['inventory_information_id'] && $check_field('set','product_code')) || (!form['inventory_information_id'] && $check_field('add','product_code'))"
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

				<div class="premium-section-title">库存核对记录</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','product_inventory') || $check_field('add','product_inventory') || $check_field('set','product_inventory')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="系统账面库存" prop="product_inventory">
							<div class="premium-readonly-field">{{form['product_inventory'] !== 0 ? form['product_inventory'] : ('请先选择商品编码')}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','check_date') || $check_field('add','check_date') || $check_field('set','check_date')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="最近核对日期" prop="check_date">
							<el-date-picker :disabled="disabledObj['check_date_isDisabled']" style="width: 100%"
								v-if="(form['inventory_information_id'] && $check_field('set','check_date')) || (!form['inventory_information_id'] && $check_field('add','check_date'))" id="check_date"
								v-model="form['check_date']" type="date" placeholder="选择日期" :picker-options="check_date_disableOptions" value-format="yyyy-MM-dd">
							</el-date-picker>
							<div v-else-if="$check_field('get','check_date')" class="premium-readonly-field">{{form['check_date']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','check_quantity') || $check_field('add','check_quantity') || $check_field('set','check_quantity')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="实际盘点数量" prop="check_quantity">
							<el-input-number id="check_quantity" v-model.number="form['check_quantity']" style="width: 100%" :min="0"
								v-if="(form['inventory_information_id'] && $check_field('set','check_quantity')) || (!form['inventory_information_id'] && $check_field('add','check_quantity'))" :disabled="disabledObj['check_quantity_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','check_quantity')" class="premium-readonly-field">{{form['check_quantity']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','inventory') || $check_field('add','inventory') || $check_field('set','inventory')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="库存变动情况说明" prop="inventory">
							<el-input type="textarea" :rows="4" id="inventory" v-model="form['inventory']" placeholder="请输入库存变动、损耗或其他异常说明..."
								v-if="(form['inventory_information_id'] && $check_field('set','inventory')) || (!form['inventory_information_id'] && $check_field('add','inventory'))" :disabled="disabledObj['inventory_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','inventory')" class="premium-readonly-field" style="min-height: 80px;">{{form['inventory']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="$check_action('/inventory_information/view','set') || $check_action('/inventory_information/view','add')">
						<el-button type="primary" class="premium-btn-submit" @click="submit()" icon="el-icon-check">提交更新</el-button>
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
				field: "inventory_information_id",
				url_add: "~/api/inventory_information/add?",
				url_set: "~/api/inventory_information/set?",
				url_get_obj: "~/api/inventory_information/get_obj?",
				url_upload: "~/api/inventory_information/upload?",
				query: { "inventory_information_id": 0 },
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
				list_commodity: [],
			}
		},
		methods: {
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
					this.form.product_inventory = item.product_inventory;
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
				if (this.form["check_date"] && JSON.stringify(this.form["check_date"]).indexOf("-")===-1){
					this.form["check_date"] = this.$toTime(parseInt(this.form["check_date"]),"yyyy-MM-dd")
				}
				$.db.del("form");
				return param;
			},
			get_obj_after(json, func){
				if(this.form["check_date"]=="0000-00-00"){
				  this.form["check_date"] = null;
				}
				if(parseInt(this.form["check_date"]) > 9999){
					this.form["check_date"] = this.$toTime(parseInt(this.form["check_date"]),"yyyy-MM-dd")
				}
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
				console.log('开始验证库存数据:', param);
				
				// 验证核对日期
				if (!param.check_date){ 
					console.log('验证失败：核对日期为空');
					return "核对日期不能为空"; 
				}
				
				// 验证系统账面库存不能小于0
				if (param.product_inventory === null || param.product_inventory === undefined || param.product_inventory < 0) {
					console.log('验证失败：系统账面库存无效', param.product_inventory);
					return '系统账面库存不能小于0';
				}
				
				// 验证实际盘点数量不能小于0
				if (param.check_quantity === null || param.check_quantity === undefined || param.check_quantity < 0) {
					console.log('验证失败：实际盘点数量无效', param.check_quantity);
					return '实际盘点数量不能小于0';
				}
				
				console.log('验证通过');
				return null;
			},
			is_view(){
				var bl = false;
				if(!bl){ bl = this.$check_action('/inventory_information/table','add'); }
				if(!bl){ bl = this.$check_action('/inventory_information/table','set'); }
				if(!bl){ bl = this.$check_action('/inventory_information/view','add'); }
				if(!bl){ bl = this.$check_action('/inventory_information/view','set'); }
				if(!bl){ bl = this.$check_action('/inventory_information/view','get'); }
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
			this.get_list_commodity();
		},
	}
</script>

<style scoped>
</style>
